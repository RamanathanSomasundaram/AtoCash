//
//  RequestCountModel.swift
//  AtoCash
//
//  Created by user on 29/04/21.
//

import Foundation
public struct RequestCountModel: Codable {

    public var approvedCount: Int?
    public var pendingCount: Int?
    public var rejectedCount: Int?
    public var totalCount: Int?
    //{"totalCount":0,"pendingCount":0,"rejectedCount":0,"approvedCount":0}
    public init(approvedCount: Int? = nil , pendingCount: Int? = nil,rejectedCount: Int? = nil,totalCount: Int? = nil ) {
        self.approvedCount = approvedCount
        self.pendingCount = pendingCount
        self.rejectedCount = rejectedCount
        self.totalCount = totalCount
    }

    public enum CodingKeys: String, CodingKey {
        case approvedCount = "approvedCount"
        case pendingCount = "pendingCount"
        case rejectedCount = "rejectedCount"
        case totalCount = "totalCount"
        
    }
}
