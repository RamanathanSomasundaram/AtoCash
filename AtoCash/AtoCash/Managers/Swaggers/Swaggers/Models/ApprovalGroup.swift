//
// ApprovalGroup.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ApprovalGroup: Codable {

    public var _id: Int?
    public var approvalGroupCode: String
    public var approvalGroupDesc: String

    public init(_id: Int? = nil, approvalGroupCode: String, approvalGroupDesc: String) {
        self._id = _id
        self.approvalGroupCode = approvalGroupCode
        self.approvalGroupDesc = approvalGroupDesc
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case approvalGroupCode
        case approvalGroupDesc
    }

}
