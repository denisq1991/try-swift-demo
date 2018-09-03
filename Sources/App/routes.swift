import Vapor

/// Register your application's routes here.


struct JSONExample: Content {
    let name: String
    let birthday: Date
}

public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.get("json") { req -> JSONExample in
        return JSONExample.init(name: "Denis", birthday: Date.init(timeInterval: 1000, since: Date()))
        fatalError()
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.get("todos", Todo.parameter, use: todoController.view)
    router.post("todos", use: todoController.create)
    router.patch("todos", Todo.parameter, use: todoController.update)
    router.delete("todos", use: todoController.clear)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
