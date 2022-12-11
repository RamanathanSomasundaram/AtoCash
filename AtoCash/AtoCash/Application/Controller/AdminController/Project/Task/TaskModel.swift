//
//  TaskModel.swift
//  AtoCash
//
//  Created by user on 11/03/21.
//

import Foundation

public struct TaskModel : Codable {
    public var id : Int?
    public var taskName : String?
    public var taskDesc : String?
    public var subProjectId : Int?

    
    public init(_id: Int? = nil, taskName: String? = nil, taskDesc: String? = nil) {
        self.id = _id
        self.taskName = taskName
        self.taskDesc = taskDesc
    }
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case taskName = "taskName"
        case taskDesc = "taskDesc"
        case subProjectId = "subProjectId"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        taskName = try values.decodeIfPresent(String.self, forKey: .taskName)
        taskDesc = try values.decodeIfPresent(String.self, forKey: .taskDesc)
        subProjectId = try values.decodeIfPresent(Int.self, forKey: .subProjectId)
    }

}
