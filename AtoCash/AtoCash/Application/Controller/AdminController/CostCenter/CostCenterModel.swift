//
//  CostCenterModel.swift
//  AtoCash
//
//  Created by user on 11/03/21.
//

import Foundation

struct CostCenterModel : Codable {
    let id : Int?
    let costCentreCode : String?
    let costCentreDesc : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case costCentreCode = "costCentreCode"
        case costCentreDesc = "costCentreDesc"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        costCentreCode = try values.decodeIfPresent(String.self, forKey: .costCentreCode)
        costCentreDesc = try values.decodeIfPresent(String.self, forKey: .costCentreDesc)
    }

}
