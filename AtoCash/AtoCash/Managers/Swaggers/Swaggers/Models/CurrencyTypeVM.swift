//
// CurrencyTypeVM.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct CurrencyTypeVM: Codable {

    public var _id: Int?
    public var currencyCode: String?

    public init(_id: Int? = nil, currencyCode: String? = nil) {
        self._id = _id
        self.currencyCode = currencyCode
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case currencyCode
    }

}
