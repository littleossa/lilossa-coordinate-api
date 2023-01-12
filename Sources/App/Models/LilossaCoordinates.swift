//
//  File.swift
//  
//

import Fluent
import Vapor

final class LilossaCoordinate: Model, Content {
    static let schema = "littleossa_coordinates"
    
    enum DataField: String {
        case createdAt = "created_at"
        case latitude
        case longitude
        
        var key: FieldKey {
            return FieldKey(stringLiteral: self.rawValue)
        }
    }
        
    @ID(key: .id)
    var id: UUID?

    /// 日付
    @Timestamp(key: DataField.createdAt.key, on: .create, format: .iso8601)
    var createdAt: Date?
    
    /// 緯度
    @Field(key: DataField.latitude.key)
    var latitude: Double
    
    /// 経度
    @Field(key: DataField.longitude.key)
    var longitude: Double

    init() { }

    init(id: UUID? = nil, latitude: Double, longitude: Double) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
    }
}
