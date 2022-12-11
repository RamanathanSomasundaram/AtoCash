//
//  RolesModel.swift
//  AtoCash
//
//  Created by user on 11/03/21.
//

import Foundation

struct JobRoleModel : Codable {
    let id : Int?
    let roleCode : String?
    let roleName : String?
    let maxPettyCashAllowed : Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case roleCode = "roleCode"
        case roleName = "roleName"
        case maxPettyCashAllowed = "maxPettyCashAllowed"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        roleCode = try values.decodeIfPresent(String.self, forKey: .roleCode)
        roleName = try values.decodeIfPresent(String.self, forKey: .roleName)
        maxPettyCashAllowed = try values.decodeIfPresent(Int.self, forKey: .maxPettyCashAllowed)
    }
}
