import FluentSQLite
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentSQLiteProvider())
    
    services.register { container -> CommandConfig in
        
        var config = CommandConfig.default()
        config.useFluentCommands()
        return config
    }
    
    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // DQ enable this to use the stuff in Public directoy. When a reuest comes in it will lok for a matching file, otherwise it will direct to your app
    let cors = CORSMiddleware.init(configuration: .init(allowedOrigin: .all,
                                                        allowedMethods: [.GET, .POST, .DELETE,.OPTIONS, .PATCH],
                                                        allowedHeaders: [.xRequestedWith, .origin, .contentType, .accept]))
    // DQ *NB this has to come first so that all other layers pass through this
    middlewares.use(cors)
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    // DQ uses the normal Error object so can create your own
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database
    let sqlite = try SQLiteDatabase(storage: .memory)

    /// Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: sqlite, as: .sqlite)
    services.register(databases)

    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Todo.self, database: .sqlite)
    services.register(migrations)

}
