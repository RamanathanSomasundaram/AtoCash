//
//  AdminRoleModel.swift
//  AtoCash
//
//  Created by user on 16/03/21.
//

import Foundation
struct AdminRoleModel : Codable {
    let id : String?
    let name : String?
    let normalizedName : String?
    let concurrencyStamp : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case normalizedName = "normalizedName"
        case concurrencyStamp = "concurrencyStamp"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        normalizedName = try values.decodeIfPresent(String.self, forKey: .normalizedName)
        concurrencyStamp = try values.decodeIfPresent(String.self, forKey: .concurrencyStamp)
    }
}
