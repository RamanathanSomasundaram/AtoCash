//
//  LoginModel.swift
//  AtoCash
//
//  Created by user on 04/02/21.
//

import Foundation

struct LoginModel1 : Codable {
    let token : String?
    let role : [String]?
    let firstName : String?
    let lastName : String?
    let empId : String?
    let email : String?
    let currencyCode : Int?
    let currencyType : String?

    enum CodingKeys: String, CodingKey {

        case token = "token"
        case role = "role"
        case firstName = "firstName"
        case lastName = "lastName"
        case empId = "empId"
        case email = "email"
        case currencyCode = "currencyId"
        case currencyType = "currencyCode"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        role = try values.decodeIfPresent([String].self, forKey: .role)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        empId = try values.decodeIfPresent(String.self, forKey: .empId)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        currencyCode = try values.decodeIfPresent(Int.self, forKey: .currencyCode)
        currencyType = try values.decodeIfPresent(String.self, forKey: .currencyType)
    }

}
