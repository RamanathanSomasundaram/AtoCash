//
// EmpCurrentPettyCashBalanceDTO.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct EmpCurrentPettyCashBalanceDTO: Codable {

    public var _id: Int?
    public var employeeId: Int?
    public var curBalance: Double?
    public var maxLimit: Double?
    public var cashInHand: Double?
    public var pendingApprovalCA: Double?
    public var pendingApprovalER: Double?
    public var pendingSettlementCA: Double?
    public var pendingSettlementER: Double?
    public var adjustedAgainstCA: Double?
    public var updatedOn: Date?
//    {"maxLimit":20000,"curBalance":20000,"cashInHand":0,"pendingApprovalCA":0,"pendingApprovalER":0,"pendingSettlementCA":0,"pendingSettlementER":0,"adjustedAgainstCA":0,"walletBalLastUpdated":"2023-01-23T09:18:11.74531Z"}
    public init(_id: Int? = nil, employeeId: Int? = nil, curBalance: Double? = nil, updatedOn: Date? = nil) {
        self._id = _id
        self.employeeId = employeeId
        self.curBalance = curBalance
        self.updatedOn = updatedOn
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case employeeId
        case curBalance
        case maxLimit
        case cashInHand
        case pendingApprovalCA
        case pendingApprovalER
        case pendingSettlementCA
        case pendingSettlementER
        case adjustedAgainstCA
        case updatedOn = "walletBalLastUpdated"
    }

}
