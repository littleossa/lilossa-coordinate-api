import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {

    app.databases.use(.postgres(
        hostname: "localhost",
        username: "postgres",
        password: "",
        database: "littleossacoordinatedb"
    ), as: .psql)

    // 追加されていない場合のみ実行される
    app.migrations.add(CreateCoordinate())

    // register routes
    try routes(app)
}
