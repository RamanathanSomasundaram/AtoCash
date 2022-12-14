//
// ClaimApprovalStatusTrackerDTO.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ClaimApprovalStatusTrackerDTO: Codable {

    public var _id: Int?
    public var employeeId: Int?
    public var employeeName: String?
    public var pettyCashRequestId: Int?
    public var departmentId: Int?
    public var departmentName: String?
    public var projectId: Int?
    public var projectName: String?
    public var subProjectId: Int?
    public var subProjectName: String?
    public var workTaskId: Int?
    public var workTask: String?
    public var approvalGroupId: Int?
    public var roleId: Int?
    public var jobRole: String?
    public var approvalLevelId: Int?
    public var reqDate: Date?
    public var finalApprovedDate: Date?
    public var approvalStatusTypeId: Int?
    public var approvalStatusType: String?
    public var comments: String?

    public init(_id: Int? = nil, employeeId: Int? = nil, employeeName: String? = nil, pettyCashRequestId: Int? = nil, departmentId: Int? = nil, departmentName: String? = nil, projectId: Int? = nil, projectName: String? = nil, subProjectId: Int? = nil, subProjectName: String? = nil, workTaskId: Int? = nil, workTask: String? = nil, approvalGroupId: Int? = nil, roleId: Int? = nil, jobRole: String? = nil, approvalLevelId: Int? = nil, reqDate: Date? = nil, finalApprovedDate: Date? = nil, approvalStatusTypeId: Int? = nil, approvalStatusType: String? = nil, comments: String? = nil) {
        self._id = _id
        self.employeeId = employeeId
        self.employeeName = employeeName
        self.pettyCashRequestId = pettyCashRequestId
        self.departmentId = departmentId
        self.departmentName = departmentName
        self.projectId = projectId
        self.projectName = projectName
        self.subProjectId = subProjectId
        self.subProjectName = subProjectName
        self.workTaskId = workTaskId
        self.workTask = workTask
        self.approvalGroupId = approvalGroupId
        self.roleId = roleId
        self.jobRole = jobRole
        self.approvalLevelId = approvalLevelId
        self.reqDate = reqDate
        self.finalApprovedDate = finalApprovedDate
        self.approvalStatusTypeId = approvalStatusTypeId
        self.approvalStatusType = approvalStatusType
        self.comments = comments
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case employeeId
        case employeeName
        case pettyCashRequestId
        case departmentId
        case departmentName
        case projectId
        case projectName
        case subProjectId
        case subProjectName
        case workTaskId
        case workTask
        case approvalGroupId
        case roleId
        case jobRole
        case approvalLevelId
        case reqDate
        case finalApprovedDate
        case approvalStatusTypeId
        case approvalStatusType
        case comments
    }

}
