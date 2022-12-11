//
// EmpCurrentPettyCashBalance.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct EmpCurrentPettyCashBalance: Codable {

    public var _id: Int?
    public var employee: Employee
    public var employeeId: Int?
    public var curBalance: Double
    public var updatedOn: Date

    public init(_id: Int? = nil, employee: Employee, employeeId: Int? = nil, curBalance: Double, updatedOn: Date) {
        self._id = _id
        self.employee = employee
        self.employeeId = employeeId
        self.curBalance = curBalance
        self.updatedOn = updatedOn
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case employee
        case employeeId
        case curBalance
        case updatedOn
    }

}
