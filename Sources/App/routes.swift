import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("test") { req -> String in
        return shell("ls")
    }
    
    app.get("sim") { req -> String in
        return shell("open -a Simulator")
    }
}

