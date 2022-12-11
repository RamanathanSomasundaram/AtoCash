//
//  EmployeeTypeModel.swift
//  AtoCash
//
//  Created by user on 11/03/21.
//

import Foundation

struct EmployeeTypeModel : Codable {
    let id : Int?
    let empJobTypeCode : String?
    let empJobTypeDesc : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case empJobTypeCode = "empJobTypeCode"
        case empJobTypeDesc = "empJobTypeDesc"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        empJobTypeCode = try values.decodeIfPresent(String.self, forKey: .empJobTypeCode)
        empJobTypeDesc = try values.decodeIfPresent(String.self, forKey: .empJobTypeDesc)
    }
}
