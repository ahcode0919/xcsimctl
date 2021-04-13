import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "XCSimctl Server"
    }

    app.get("ping") { req -> Response in
        return Response(status: .ok)
    }
    
    app.get("list") { req -> Response in
        let response = Response()
        guard let _ = try? response.content.encode(List.list(), as: .json) else {
            throw Abort(.internalServerError, reason: "simctl list failed")
        }
        return response
    }
}

