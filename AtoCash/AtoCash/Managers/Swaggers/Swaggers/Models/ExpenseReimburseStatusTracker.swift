//
// ExpenseReimburseStatusTracker.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ExpenseReimburseStatusTracker: Codable {

    public var _id: Int?
    public var employee: Employee
    public var employeeId: Int?
    public var expenseReimburseRequest: ExpenseReimburseRequest
    public var expenseReimburseRequestId: Int?
    public var currencyType: CurrencyType
    public var currencyTypeId: Int?
    public var totalClaimAmount: Double
    public var expReimReqDate: Date
    public var department: Department?
    public var departmentId: Int?
    public var projManager: Employee?
    public var projManagerId: Int?
    public var project: Project?
    public var projectId: Int?
    public var subProject: SubProject?
    public var subProjectId: Int?
    public var workTask: WorkTask?
    public var workTaskId: Int?
    public var approvalGroupId: Int
    public var jobRole: JobRole
    public var jobRoleId: Int?
    public var approvalLevel: ApprovalLevel
    public var approvalLevelId: Int?
    public var approvalStatusType: ApprovalStatusType
    public var approvalStatusTypeId: Int?
    public var approvedDate: Date?
    public var comments: String

    public init(_id: Int? = nil, employee: Employee, employeeId: Int? = nil, expenseReimburseRequest: ExpenseReimburseRequest, expenseReimburseRequestId: Int? = nil, currencyType: CurrencyType, currencyTypeId: Int? = nil, totalClaimAmount: Double, expReimReqDate: Date, department: Department? = nil, departmentId: Int? = nil, projManager: Employee? = nil, projManagerId: Int? = nil, project: Project? = nil, projectId: Int? = nil, subProject: SubProject? = nil, subProjectId: Int? = nil, workTask: WorkTask? = nil, workTaskId: Int? = nil, approvalGroupId: Int, jobRole: JobRole, jobRoleId: Int? = nil, approvalLevel: ApprovalLevel, approvalLevelId: Int? = nil, approvalStatusType: ApprovalStatusType, approvalStatusTypeId: Int? = nil, approvedDate: Date? = nil, comments: String) {
        self._id = _id
        self.employee = employee
        self.employeeId = employeeId
        self.expenseReimburseRequest = expenseReimburseRequest
        self.expenseReimburseRequestId = expenseReimburseRequestId
        self.currencyType = currencyType
        self.currencyTypeId = currencyTypeId
        self.totalClaimAmount = totalClaimAmount
        self.expReimReqDate = expReimReqDate
        self.department = department
        self.departmentId = departmentId
        self.projManager = projManager
        self.projManagerId = projManagerId
        self.project = project
        self.projectId = projectId
        self.subProject = subProject
        self.subProjectId = subProjectId
        self.workTask = workTask
        self.workTaskId = workTaskId
        self.approvalGroupId = approvalGroupId
        self.jobRole = jobRole
        self.jobRoleId = jobRoleId
        self.approvalLevel = approvalLevel
        self.approvalLevelId = approvalLevelId
        self.approvalStatusType = approvalStatusType
        self.approvalStatusTypeId = approvalStatusTypeId
        self.approvedDate = approvedDate
        self.comments = comments
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case employee
        case employeeId
        case expenseReimburseRequest
        case expenseReimburseRequestId
        case currencyType
        case currencyTypeId
        case totalClaimAmount
        case expReimReqDate
        case department
        case departmentId
        case projManager
        case projManagerId
        case project
        case projectId
        case subProject
        case subProjectId
        case workTask
        case workTaskId
        case approvalGroupId
        case jobRole
        case jobRoleId
        case approvalLevel
        case approvalLevelId
        case approvalStatusType
        case approvalStatusTypeId
        case approvedDate
        case comments
    }

}
