//
//  OutgoingTodo.swift
//  App
//
//  Created by Denis Quaid on 03/09/2018.
//

import Foundation
import Vapor

extension Todo {
    struct Outgoing: Content {
        var id: Int?
        var title: String?
        var completed: Bool?
        var order: Int?
        var url: String
    }
}

extension Todo {
    func makeOutgoing(with req: Request) throws -> Outgoing {
        let idString = id?.description ?? ""
        let url = req.baseURL + idString
        return Outgoing(id: id,
                        title: title,
                        completed: completed,
                        order: order,
                        url: url)
        fatalError()
    }
}

extension Future where T == Todo {
    func makeOutgoing(with req: Request) -> Future<Todo.Outgoing> {
        return map { todo in
            return  try todo.makeOutgoing(with: req)
        }
    }
}
