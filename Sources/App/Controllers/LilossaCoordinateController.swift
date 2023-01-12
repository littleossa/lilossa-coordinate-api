import Fluent
import Vapor

struct LilossaCoordinateController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        /// localhost:8080/littleossa_coordinates
        let coordinates = routes.grouped(PathComponent(stringLiteral: LilossaCoordinate.schema))
        // GET
        coordinates.get(use: index)
        // POST
        coordinates.post(use: create)
        // DELETE
        coordinates.group(":coordinateID") { coordinate in
            coordinate.delete(use: delete)
        }
    }
    
    func index(req: Request) async throws -> [LilossaCoordinate] {
        try await LilossaCoordinate.query(on: req.db)
            .sort(\.$createdAt, .descending) // 生成日の降順に並び替え
            .all()
    }
    
    func create(req: Request) async throws -> LilossaCoordinate {
        let coordinate = try req.content.decode(LilossaCoordinate.self)
        try await coordinate.save(on: req.db)
        return coordinate
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        guard let coordinate = try await LilossaCoordinate.find(req.parameters.get("coordinateID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await coordinate.delete(on: req.db)
        return .noContent
    }
}
