//
// JobRoleDTO.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct JobRoleDTO: Codable {

    public var _id: Int?
    public var roleCode: String?
    public var roleName: String?
    public var maxPettyCashAllowed: Double?

    public init(_id: Int? = nil, roleCode: String? = nil, roleName: String? = nil, maxPettyCashAllowed: Double? = nil) {
        self._id = _id
        self.roleCode = roleCode
        self.roleName = roleName
        self.maxPettyCashAllowed = maxPettyCashAllowed
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case roleCode
        case roleName
        case maxPettyCashAllowed
    }

}
