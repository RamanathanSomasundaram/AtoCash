//
// AddEmployeesToProjectId.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct AddEmployeesToProjectId: Codable {

    public var projectId: Int?
    public var employeeIds: [Int]?

    public init(projectId: Int? = nil, employeeIds: [Int]? = nil) {
        self.projectId = projectId
        self.employeeIds = employeeIds
    }


}