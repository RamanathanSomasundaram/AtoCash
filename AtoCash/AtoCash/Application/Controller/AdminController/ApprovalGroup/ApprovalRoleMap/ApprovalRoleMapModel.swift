//
//  ApprovalRoleMapModel.swift
//  AtoCash
//
//  Created by user on 12/03/21.
//

import Foundation

struct ApprovalRoleMapModel : Codable {
    let id : Int?
    let approvalGroupId : Int?
    let roleId : Int?
    let approvalLevelId : Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case approvalGroupId = "approvalGroupId"
        case roleId = "roleId"
        case approvalLevelId = "approvalLevelId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        approvalGroupId = try values.decodeIfPresent(Int.self, forKey: .approvalGroupId)
        roleId = try values.decodeIfPresent(Int.self, forKey: .roleId)
        approvalLevelId = try values.decodeIfPresent(Int.self, forKey: .approvalLevelId)
    }
}
