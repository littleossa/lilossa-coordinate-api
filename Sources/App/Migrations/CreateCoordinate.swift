//
//  CreateCoordinate.swift
//  
//
//

import Fluent

struct CreateCoordinate: AsyncMigration {
    
    // データテーブルを用意
    func prepare(on database: Database) async throws {
        try await database.schema(LilossaCoordinate.schema) // Table name
            .id()
            .field(LilossaCoordinate.DataField.createdAt.key, .string) // Column name 日付
            .field(LilossaCoordinate.DataField.latitude.key, .double, .required) // Column name 緯度
            .field(LilossaCoordinate.DataField.longitude.key, .double, .required) // Column name 経度
            .create()
    }

    // データテーブルを元に戻す
    func revert(on database: Database) async throws {
        try await database.schema(LilossaCoordinate.schema).delete()
    }
}

