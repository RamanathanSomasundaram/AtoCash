//
// ApprovalGroupVM.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ApprovalGroupVM: Codable {

    public var _id: Int?
    public var approvalGroupCode: String?

    public init(_id: Int? = nil, approvalGroupCode: String? = nil) {
        self._id = _id
        self.approvalGroupCode = approvalGroupCode
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case approvalGroupCode
    }

}