//
// Department.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct Department: Codable {

    public var _id: Int?
    public var deptCode: String
    public var deptName: String
    public var costCenter: CostCenter
    public var costCenterId: Int?
    public var statusType: StatusType
    public var statusTypeId: Int?

    public init(_id: Int? = nil, deptCode: String, deptName: String, costCenter: CostCenter, costCenterId: Int? = nil, statusType: StatusType, statusTypeId: Int? = nil) {
        self._id = _id
        self.deptCode = deptCode
        self.deptName = deptName
        self.costCenter = costCenter
        self.costCenterId = costCenterId
        self.statusType = statusType
        self.statusTypeId = statusTypeId
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case deptCode
        case deptName
        case costCenter
        case costCenterId
        case statusType
        case statusTypeId
    }

}
