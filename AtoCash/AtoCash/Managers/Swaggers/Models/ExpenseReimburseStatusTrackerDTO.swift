//
// ExpenseReimburseStatusTrackerDTO.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ExpenseReimburseStatusTrackerDTO: Codable {

    public var _id: Int?
    public var employeeId: Int?
    public var employeeName: String?
    public var expenseReimburseRequestId: Int?
    public var currencyTypeId: Int?
    public var currencyType: String?
    public var totalClaimAmount: Double?
    public var expReimReqDate: Date?
    public var departmentId: Int?
    public var department: String?
    public var projectId: Int?
    public var project: String?
    public var workTaskId: Int?
    public var workTask: String?
    public var subProjectId: Int?
    public var subProject: String?
    public var approvalGroupId: Int?
    public var approvalLevelId: Int?
    public var jobRoleId: Int?
    public var jobRole: String?
    public var approvalStatusType: String?
    public var approvalStatusTypeId: Int?
    public var approvedDate: Date?
    public var comments: String?

    public init(_id: Int? = nil, employeeId: Int? = nil, employeeName: String? = nil, expenseReimburseRequestId: Int? = nil, currencyTypeId: Int? = nil, currencyType: String? = nil, totalClaimAmount: Double? = nil, expReimReqDate: Date? = nil, departmentId: Int? = nil, department: String? = nil, projectId: Int? = nil, project: String? = nil, workTaskId: Int? = nil, workTask: String? = nil, subProjectId: Int? = nil, subProject: String? = nil, approvalGroupId: Int? = nil, approvalLevelId: Int? = nil, jobRoleId: Int? = nil, jobRole: String? = nil, approvalStatusType: String? = nil, approvalStatusTypeId: Int? = nil, approvedDate: Date? = nil, comments: String? = nil) {
        self._id = _id
        self.employeeId = employeeId
        self.employeeName = employeeName
        self.expenseReimburseRequestId = expenseReimburseRequestId
        self.currencyTypeId = currencyTypeId
        self.currencyType = currencyType
        self.totalClaimAmount = totalClaimAmount
        self.expReimReqDate = expReimReqDate
        self.departmentId = departmentId
        self.department = department
        self.projectId = projectId
        self.project = project
        self.workTaskId = workTaskId
        self.workTask = workTask
        self.subProjectId = subProjectId
        self.subProject = subProject
        self.approvalGroupId = approvalGroupId
        self.approvalLevelId = approvalLevelId
        self.jobRoleId = jobRoleId
        self.jobRole = jobRole
        self.approvalStatusType = approvalStatusType
        self.approvalStatusTypeId = approvalStatusTypeId
        self.approvedDate = approvedDate
        self.comments = comments
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case employeeId
        case employeeName
        case expenseReimburseRequestId
        case currencyTypeId
        case currencyType
        case totalClaimAmount
        case expReimReqDate
        case departmentId
        case department
        case projectId
        case project
        case workTaskId
        case workTask
        case subProjectId
        case subProject
        case approvalGroupId
        case approvalLevelId
        case jobRoleId
        case jobRole
        case approvalStatusType
        case approvalStatusTypeId
        case approvedDate
        case comments
    }

}