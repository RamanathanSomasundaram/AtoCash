//
// ApprovalRoleMap.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ApprovalRoleMap: Codable {

    public var _id: Int?
    public var approvalGroup: ApprovalGroup
    public var approvalGroupId: Int?
    public var jobRole: JobRole
    public var roleId: Int?
    public var approvalLevel: ApprovalLevel
    public var approvalLevelId: Int?

    public init(_id: Int? = nil, approvalGroup: ApprovalGroup, approvalGroupId: Int? = nil, jobRole: JobRole, roleId: Int? = nil, approvalLevel: ApprovalLevel, approvalLevelId: Int? = nil) {
        self._id = _id
        self.approvalGroup = approvalGroup
        self.approvalGroupId = approvalGroupId
        self.jobRole = jobRole
        self.roleId = roleId
        self.approvalLevel = approvalLevel
        self.approvalLevelId = approvalLevelId
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case approvalGroup
        case approvalGroupId
        case jobRole
        case roleId
        case approvalLevel
        case approvalLevelId
    }

}