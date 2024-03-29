//
// TravelRequestSearchModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct TravelRequestSearchModel: Codable {

    public var LoggedEmpId: Int?
    public var IsManager: Bool?
    public var ReporteeEmpId: Int?
    

    public init(LoggedEmpId: Int? = nil, IsManager: Bool? = nil, ReporteeEmpId: Int? = nil) {
        self.LoggedEmpId = LoggedEmpId
        self.IsManager = IsManager
        self.ReporteeEmpId = ReporteeEmpId
    }

}
