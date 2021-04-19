import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "XCSimctl Server"
    }

    app.get("ping") { req -> Response in
        return Response(status: .ok)
    }
    
    try app.register(collection: CreateController())
    try app.register(collection: DeleteController())
    try app.register(collection: ListController())
}

