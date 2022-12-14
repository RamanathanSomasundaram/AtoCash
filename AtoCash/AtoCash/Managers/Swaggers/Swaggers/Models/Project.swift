//
// Project.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct Project: Codable {

    public var _id: Int?
    public var projectName: String
    public var costCenter: CostCenter
    public var costCenterId: Int?
    public var projectManager: Employee
    public var projectManagerId: Int?
    public var projectDesc: String
    public var statusType: StatusType
    public var statusTypeId: Int?

    public init(_id: Int? = nil, projectName: String, costCenter: CostCenter, costCenterId: Int? = nil, projectManager: Employee, projectManagerId: Int? = nil, projectDesc: String, statusType: StatusType, statusTypeId: Int? = nil) {
        self._id = _id
        self.projectName = projectName
        self.costCenter = costCenter
        self.costCenterId = costCenterId
        self.projectManager = projectManager
        self.projectManagerId = projectManagerId
        self.projectDesc = projectDesc
        self.statusType = statusType
        self.statusTypeId = statusTypeId
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case projectName
        case costCenter
        case costCenterId
        case projectManager
        case projectManagerId
        case projectDesc
        case statusType
        case statusTypeId
    }

}
