//
// ApprovalStatusFlowVM.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ApprovalStatusFlowVM: Codable {

    public var approvalLevel: Int?
    public var approverRole: String?
    public var approverName: String?
    public var approvalStatusType: String?
    public var approverActionDate: Date?

    public init(approvalLevel: Int? = nil, approverRole: String? = nil, approverName: String? = nil, approvalStatusType: String? = nil, approvedDate: Date? = nil) {
        self.approvalLevel = approvalLevel
        self.approverRole = approverRole
        self.approverName = approverName
        self.approvalStatusType = approvalStatusType
        self.approverActionDate = approvedDate
    }

}
