//
// EditRoleModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct EditRoleModel: Codable {

    public var _id: String?
    public var roleName: String?

    public init(_id: String? = nil, roleName: String? = nil) {
        self._id = _id
        self.roleName = roleName
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case roleName
    }

}
