//
// JobRoleVM.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct JobRoleVM: Codable {

    public var _id: Int?
    public var roleCode: String?

    public init(_id: Int? = nil, roleCode: String? = nil) {
        self._id = _id
        self.roleCode = roleCode
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case roleCode
    }

}
