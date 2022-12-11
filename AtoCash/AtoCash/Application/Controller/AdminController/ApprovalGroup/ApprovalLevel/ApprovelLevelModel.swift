//
//  ApprovelLevelModel.swift
//  AtoCash
//
//  Created by user on 11/03/21.
//

import Foundation
struct ApprovalLevelModel : Codable {
        let id : Int?
        let level : String?
        let levelDesc : String?

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case level = "level"
            case levelDesc = "levelDesc"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(Int.self, forKey: .id)
            level = try values.decodeIfPresent(String.self, forKey: .level)
            levelDesc = try values.decodeIfPresent(String.self, forKey: .levelDesc)
        }
}
