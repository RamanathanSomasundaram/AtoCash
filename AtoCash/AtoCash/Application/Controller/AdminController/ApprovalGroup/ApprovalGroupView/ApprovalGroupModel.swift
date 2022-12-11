//
//  ApprovalGroupModel.swift
//  AtoCash
//
//  Created by user on 12/03/21.
//

import Foundation

struct ApprovalGroupModel : Codable {
    let id : Int?
    let approvalGroupCode : String?
    let approvalGroupDesc : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case approvalGroupCode = "approvalGroupCode"
        case approvalGroupDesc = "approvalGroupDesc"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        approvalGroupCode = try values.decodeIfPresent(String.self, forKey: .approvalGroupCode)
        approvalGroupDesc = try values.decodeIfPresent(String.self, forKey: .approvalGroupDesc)
    }
}
