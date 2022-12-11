//
//  SuccessModel.swift
//  AtoCash
//
//  Created by user on 28/04/21.
//

import Foundation

public struct SuccessModel: Codable {

    public var status: String?
    public var message: String?

    public init(status: String? = nil , message: String? = nil) {
        self.status = status
        self.message = message
    }

    public enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
    }

}
