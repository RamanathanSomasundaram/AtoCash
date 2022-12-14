//
// ExpenseType.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ExpenseType: Codable {

    public var _id: Int?
    public var expenseTypeName: String
    public var expenseTypeDesc: String
    public var statusType: StatusType
    public var statusTypeId: Int?

    public init(_id: Int? = nil, expenseTypeName: String, expenseTypeDesc: String, statusType: StatusType, statusTypeId: Int? = nil) {
        self._id = _id
        self.expenseTypeName = expenseTypeName
        self.expenseTypeDesc = expenseTypeDesc
        self.statusType = statusType
        self.statusTypeId = statusTypeId
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case expenseTypeName
        case expenseTypeDesc
        case statusType
        case statusTypeId
    }

}
