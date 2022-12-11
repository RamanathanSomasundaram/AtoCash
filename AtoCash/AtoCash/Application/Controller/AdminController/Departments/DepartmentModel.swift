//
//  DepartmentModel.swift
//  AtoCash
//
//  Created by user on 11/03/21.
//

import Foundation
struct DepartmentModel : Codable {
    let id : Int?
    let deptCode : String?
    let deptName : String?
    let costCentreId : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case deptCode = "deptCode"
        case deptName = "deptName"
        case costCentreId = "costCentreId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        deptCode = try values.decodeIfPresent(String.self, forKey: .deptCode)
        deptName = try values.decodeIfPresent(String.self, forKey: .deptName)
        costCentreId = try values.decodeIfPresent(Int.self, forKey: .costCentreId)
    }

}

