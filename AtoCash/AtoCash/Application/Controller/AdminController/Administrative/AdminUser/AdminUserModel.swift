//
//  AdminUserModel.swift
//  AtoCash
//
//  Created by user on 16/03/21.
//

import Foundation
struct AdminUserModel : Codable {
    let employeeId : Int?
    let id : String?
    let userName : String?
    let normalizedUserName : String?
    let email : String?
    let normalizedEmail : String?
    let emailConfirmed : Bool?
    let passwordHash : String?
    let securityStamp : String?
    let concurrencyStamp : String?
    let phoneNumber : String?
    let phoneNumberConfirmed : Bool?
    let twoFactorEnabled : Bool?
    let lockoutEnd : String?
    let lockoutEnabled : Bool?
    let accessFailedCount : Int?

    enum CodingKeys: String, CodingKey {

        case employeeId = "employeeId"
        case id = "id"
        case userName = "userName"
        case normalizedUserName = "normalizedUserName"
        case email = "email"
        case normalizedEmail = "normalizedEmail"
        case emailConfirmed = "emailConfirmed"
        case passwordHash = "passwordHash"
        case securityStamp = "securityStamp"
        case concurrencyStamp = "concurrencyStamp"
        case phoneNumber = "phoneNumber"
        case phoneNumberConfirmed = "phoneNumberConfirmed"
        case twoFactorEnabled = "twoFactorEnabled"
        case lockoutEnd = "lockoutEnd"
        case lockoutEnabled = "lockoutEnabled"
        case accessFailedCount = "accessFailedCount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        employeeId = try values.decodeIfPresent(Int.self, forKey: .employeeId)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        normalizedUserName = try values.decodeIfPresent(String.self, forKey: .normalizedUserName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        normalizedEmail = try values.decodeIfPresent(String.self, forKey: .normalizedEmail)
        emailConfirmed = try values.decodeIfPresent(Bool.self, forKey: .emailConfirmed)
        passwordHash = try values.decodeIfPresent(String.self, forKey: .passwordHash)
        securityStamp = try values.decodeIfPresent(String.self, forKey: .securityStamp)
        concurrencyStamp = try values.decodeIfPresent(String.self, forKey: .concurrencyStamp)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        phoneNumberConfirmed = try values.decodeIfPresent(Bool.self, forKey: .phoneNumberConfirmed)
        twoFactorEnabled = try values.decodeIfPresent(Bool.self, forKey: .twoFactorEnabled)
        lockoutEnd = try values.decodeIfPresent(String.self, forKey: .lockoutEnd)
        lockoutEnabled = try values.decodeIfPresent(Bool.self, forKey: .lockoutEnabled)
        accessFailedCount = try values.decodeIfPresent(Int.self, forKey: .accessFailedCount)
    }
}
