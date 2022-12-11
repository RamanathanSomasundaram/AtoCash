//
// PettyCashRequestDTO.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct PettyCashRequestDTO: Codable {

    public var _id: Int?
    public var employeeName: String?
    public var employeeId: Int?
    public var currencyType: String?
    public var currencyTypeId: Int?
    public var pettyClaimAmount: Double?
    public var pettyClaimRequestDesc: String?
    public var cashReqDate: Date?
    public var department: String?
    public var departmentId: Int?
    public var project: String?
    public var projectId: Int?
    public var subProject: String?
    public var subProjectId: Int?
    public var workTask: String?
    public var workTaskId: Int?
    public var approvalStatusType: String?
    public var approvalStatusTypeId: Int?
    public var approvedDate: Date?
    public var showEditDelete: Bool?
    public var comments: String?

    public init(_id: Int? = nil, employeeName: String? = nil, employeeId: Int? = nil, currencyType: String? = nil, currencyTypeId: Int? = nil, pettyClaimAmount: Double? = nil, pettyClaimRequestDesc: String? = nil, cashReqDate: Date? = nil, department: String? = nil, departmentId: Int? = nil, project: String? = nil, projectId: Int? = nil, subProject: String? = nil, subProjectId: Int? = nil, workTask: String? = nil, workTaskId: Int? = nil, approvalStatusType: String? = nil, approvalStatusTypeId: Int? = nil, approvedDate: Date? = nil, showEditDelete: Bool? = nil, comments: String? = nil) {
        self._id = _id
        self.employeeName = employeeName
        self.employeeId = employeeId
        self.currencyType = currencyType
        self.currencyTypeId = currencyTypeId
        self.pettyClaimAmount = pettyClaimAmount
        self.pettyClaimRequestDesc = pettyClaimRequestDesc
        self.cashReqDate = cashReqDate
        self.department = department
        self.departmentId = departmentId
        self.project = project
        self.projectId = projectId
        self.subProject = subProject
        self.subProjectId = subProjectId
        self.workTask = workTask
        self.workTaskId = workTaskId
        self.approvalStatusType = approvalStatusType
        self.approvalStatusTypeId = approvalStatusTypeId
        self.approvedDate = approvedDate
        self.showEditDelete = showEditDelete
        self.comments = comments
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case employeeName
        case employeeId
        case currencyType
        case currencyTypeId
        case pettyClaimAmount
        case pettyClaimRequestDesc
        case cashReqDate
        case department
        case departmentId
        case project
        case projectId
        case subProject
        case subProjectId
        case workTask
        case workTaskId
        case approvalStatusType
        case approvalStatusTypeId
        case approvedDate
        case showEditDelete
        case comments
    }

}