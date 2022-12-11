//
//  ProjectModel.swift
//  AtoCash
//
//  Created by user on 11/03/21.
//

import Foundation
struct ProjectModel : Codable {
    let id : Int?
    let projectName : String?
    let projectDesc : String?
    let costCentreId : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case projectName = "projectName"
        case projectDesc = "projectDesc"
        case costCentreId = "costCentreId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        projectName = try values.decodeIfPresent(String.self, forKey: .projectName)
        projectDesc = try values.decodeIfPresent(String.self, forKey: .projectDesc)
        costCentreId = try values.decodeIfPresent(Int.self, forKey: .costCentreId)
    }

}
