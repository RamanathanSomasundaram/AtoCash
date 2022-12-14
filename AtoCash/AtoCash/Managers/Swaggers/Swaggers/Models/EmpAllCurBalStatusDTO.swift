//
// EmpAllCurBalStatusDTO.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct EmpAllCurBalStatusDTO: Codable {

    public var maxLimit: Double?
    public var curBalance: Double?
    public var cashInHand: Double?
    public var totalAmountToCredit: Double?
    public var totalAmountToWallet: Double?
    public var walletBalLastUpdated: Date?

    public init(maxLimit: Double? = nil, curBalance: Double? = nil, cashInHand: Double? = nil, totalAmountToCredit: Double? = nil, totalAmountToWallet: Double? = nil, walletBalLastUpdated: Date? = nil) {
        self.maxLimit = maxLimit
        self.curBalance = curBalance
        self.cashInHand = cashInHand
        self.totalAmountToCredit = totalAmountToCredit
        self.totalAmountToWallet = totalAmountToWallet
        self.walletBalLastUpdated = walletBalLastUpdated
    }


}
