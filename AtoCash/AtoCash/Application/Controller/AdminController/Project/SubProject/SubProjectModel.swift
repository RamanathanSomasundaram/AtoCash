//
//  SubProjectModel.swift
//  AtoCash
//
//  Created by user on 11/03/21.
//

import Foundation

struct SubprojectModel : Codable {
    let id : Int?
    let subProjectName : String?
    let subProjectDesc : String?
    let projectId : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case subProjectName = "subProjectName"
        case subProjectDesc = "subProjectDesc"
        case projectId = "projectId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        subProjectName = try values.decodeIfPresent(String.self, forKey: .subProjectName)
        subProjectDesc = try values.decodeIfPresent(String.self, forKey: .subProjectDesc)
        projectId = try values.decodeIfPresent(Int.self, forKey: .projectId)
    }

}
