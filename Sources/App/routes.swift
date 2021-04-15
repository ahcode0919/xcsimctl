import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "XCSimctl Server"
    }

    app.get("ping") { req -> Response in
        return Response(status: .ok)
    }
    
//    app.get("list", ) { req -> Response in
//        let response = Response()
//        guard let list = List.list() else {
//            throw Abort(.internalServerError, reason: "simctl list failed")
//        }
//        guard let _ = try? response.content.encode(list, as: .json) else {
//            throw Abort(.internalServerError, reason: "simctl list returned an invalid response")
//        }
//        return response
//    }
    let listController = ListController()
    try app.register(collection: listController)
}

