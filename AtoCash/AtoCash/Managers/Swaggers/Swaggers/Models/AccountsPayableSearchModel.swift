//
// AccountsPayableSearchModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct AccountsPayableSearchModel: Codable {

    public var isAccountSettled: Bool?
    public var settledAccountsFrom: Date?
    public var settledAccountsTo: Date?

    public init(isAccountSettled: Bool? = nil, settledAccountsFrom: Date? = nil, settledAccountsTo: Date? = nil) {
        self.isAccountSettled = isAccountSettled
        self.settledAccountsFrom = settledAccountsFrom
        self.settledAccountsTo = settledAccountsTo
    }


}
