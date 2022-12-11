//
//  EmployeeModel.swift
//  AtoCash
//
//  Created by user on 11/03/21.
//

import Foundation
struct EmployeeModel : Codable {
    let id : Int?
    let firstName : String?
    let middleName : String?
    let lastName : String?
    let empCode : String?
    let bankAccount : String?
    let bankCardNo : String?
    let nationalID : String?
    let passportNo : String?
    let taxNumber : String?
    let nationality : String?
    let dob : String?
    let doj : String?
    let gender : String?
    let email : String?
    let mobileNumber : String?
    let employmentTypeId : Int?
    let departmentId : Int?
    let roleId : Int?
    let approvalGroupId : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case firstName = "firstName"
        case middleName = "middleName"
        case lastName = "lastName"
        case empCode = "empCode"
        case bankAccount = "bankAccount"
        case bankCardNo = "bankCardNo"
        case nationalID = "nationalID"
        case passportNo = "passportNo"
        case taxNumber = "taxNumber"
        case nationality = "nationality"
        case dob = "dob"
        case doj = "doj"
        case gender = "gender"
        case email = "email"
        case mobileNumber = "mobileNumber"
        case employmentTypeId = "employmentTypeId"
        case departmentId = "departmentId"
        case roleId = "roleId"
        case approvalGroupId = "approvalGroupId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        middleName = try values.decodeIfPresent(String.self, forKey: .middleName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        empCode = try values.decodeIfPresent(String.self, forKey: .empCode)
        bankAccount = try values.decodeIfPresent(String.self, forKey: .bankAccount)
        bankCardNo = try values.decodeIfPresent(String.self, forKey: .bankCardNo)
        nationalID = try values.decodeIfPresent(String.self, forKey: .nationalID)
        passportNo = try values.decodeIfPresent(String.self, forKey: .passportNo)
        taxNumber = try values.decodeIfPresent(String.self, forKey: .taxNumber)
        nationality = try values.decodeIfPresent(String.self, forKey: .nationality)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        doj = try values.decodeIfPresent(String.self, forKey: .doj)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobileNumber = try values.decodeIfPresent(String.self, forKey: .mobileNumber)
        employmentTypeId = try values.decodeIfPresent(Int.self, forKey: .employmentTypeId)
        departmentId = try values.decodeIfPresent(Int.self, forKey: .departmentId)
        roleId = try values.decodeIfPresent(Int.self, forKey: .roleId)
        approvalGroupId = try values.decodeIfPresent(Int.self, forKey: .approvalGroupId)
    }

}
