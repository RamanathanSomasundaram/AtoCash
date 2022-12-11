//
//  ApprovalStatusModel.swift
//  AtoCash
//
//  Created by user on 12/03/21.
//

import Foundation

struct ApprovalStatusModel : Codable {
        let id : Int?
        let status : String?
        let statusDesc : String?

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case status = "status"
            case statusDesc = "statusDesc"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(Int.self, forKey: .id)
            status = try values.decodeIfPresent(String.self, forKey: .status)
            statusDesc = try values.decodeIfPresent(String.self, forKey: .statusDesc)
        }
}
