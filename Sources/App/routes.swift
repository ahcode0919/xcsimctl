import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "XCSimctl Server"
    }

    app.get("ping") { req -> Response in
        return Response(status: .ok)
    }
    
    try app.register(collection: AddMediaController())
    try app.register(collection: AppInfoController())
    try app.register(collection: BootController())
    try app.register(collection: BootStatusController())
    try app.register(collection: CloneController())
    try app.register(collection: CreateController())
    try app.register(collection: DarwinUpController())
    try app.register(collection: DeleteController())
    try app.register(collection: EraseController())
    try app.register(collection: GetAppController())
    try app.register(collection: GetEnvController())
    try app.register(collection: ICloudSyncController())
    try app.register(collection: InstallController())
    try app.register(collection: IOController())
    try app.register(collection: KeyboardController())
    try app.register(collection: KeychainController())
    try app.register(collection: LaunchController())
    try app.register(collection: ListAppsController())
    try app.register(collection: ListController())
    try app.register(collection: LogVerboseController())
    try app.register(collection: NotifyController())
    try app.register(collection: OpenURLController())
    try app.register(collection: PairController())
    try app.register(collection: PasteBoardController())
    try app.register(collection: PrivacyController())
    try app.register(collection: PushController())
    try app.register(collection: RenameController())
    try app.register(collection: ResetController())
    try app.register(collection: RuntimeController())
    try app.register(collection: ShutdownController())
    try app.register(collection: SpawnController())
    try app.register(collection: TerminateController())
    try app.register(collection: UIController())
    try app.register(collection: UpgradeController())
}

