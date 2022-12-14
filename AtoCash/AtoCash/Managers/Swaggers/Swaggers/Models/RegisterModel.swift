//
// RegisterModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct RegisterModel: Codable {

    public var employeeId: Int?
    public var username: String?
    public var email: String?
    public var password: String?

    public init(employeeId: Int? = nil, username: String? = nil, email: String? = nil, password: String? = nil) {
        self.employeeId = employeeId
        self.username = username
        self.email = email
        self.password = password
    }


}
