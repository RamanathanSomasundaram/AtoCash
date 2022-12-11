//
//  AdvacanceRequestModel.swift
//  AtoCash
//
//  Created by user on 19/03/21.
//

import Foundation

struct AdvanceRequestModel : Codable {
    let id : Int?
    let employeeName: String?
    let employeeId : Int?
    let pettyClaimAmount : Int?
    let pettyClaimRequestDesc : String?
    let cashReqDate : String?
    let department: String?
    let departmentId : Int?
    let project : String?
    let projectId : Int?
    let subProject : String?
    let subProjectId : Int?
    let workTask : String?
    let workTaskId : Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case employeeName = "employeeName"
        case employeeId = "employeeId"
        case pettyClaimAmount = "pettyClaimAmount"
        case pettyClaimRequestDesc = "pettyClaimRequestDesc"
        case cashReqDate = "cashReqDate"
        case department = "department"
        case departmentId = "departmentId"
        case project = "project"
        case projectId = "projectId"
        case subProject = "subProject"
        case subProjectId = "subProjectId"
        case workTask = "workTask"
        case workTaskId = "workTaskId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        employeeId = try values.decodeIfPresent(Int.self, forKey: .employeeId)
        pettyClaimAmount = try values.decodeIfPresent(Int.self, forKey: .pettyClaimAmount)
        departmentId = try values.decodeIfPresent(Int.self, forKey: .departmentId)
        projectId = try values.decodeIfPresent(Int.self, forKey: .projectId)
        subProjectId = try values.decodeIfPresent(Int.self, forKey: .subProjectId)
        workTaskId = try values.decodeIfPresent(Int.self, forKey: .workTaskId)
        employeeName = try values.decodeIfPresent(String.self, forKey: .employeeName)
        pettyClaimRequestDesc = try values.decodeIfPresent(String.self, forKey: .pettyClaimRequestDesc)
        cashReqDate = try values.decodeIfPresent(String.self, forKey: .cashReqDate)
        department = try values.decodeIfPresent(String.self, forKey: .department)
        project = try values.decodeIfPresent(String.self, forKey: .project)
        subProject = try values.decodeIfPresent(String.self, forKey: .subProject)
        workTask = try values.decodeIfPresent(String.self, forKey: .workTask)
    }
}
