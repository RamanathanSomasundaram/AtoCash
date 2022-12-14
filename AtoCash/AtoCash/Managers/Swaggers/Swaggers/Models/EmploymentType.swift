//
// EmploymentType.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct EmploymentType: Codable {

    public var _id: Int?
    public var empJobTypeCode: String
    public var empJobTypeDesc: String

    public init(_id: Int? = nil, empJobTypeCode: String, empJobTypeDesc: String) {
        self._id = _id
        self.empJobTypeCode = empJobTypeCode
        self.empJobTypeDesc = empJobTypeDesc
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case empJobTypeCode
        case empJobTypeDesc
    }

}
