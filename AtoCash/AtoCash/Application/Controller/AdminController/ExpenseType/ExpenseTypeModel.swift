//
//  ExpenseTypeModel.swift
//  AtoCash
//
//  Created by user on 11/03/21.
//

import Foundation

struct ExpenseTypeModel : Codable {
    let _id : Int?
    let expenseTypeName : String?
    let expenseTypeDesc : String?

    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case expenseTypeName = "expenseTypeName"
        case expenseTypeDesc = "expenseTypeDesc"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(Int.self, forKey: ._id)
        expenseTypeName = try values.decodeIfPresent(String.self, forKey: .expenseTypeName)
        expenseTypeDesc = try values.decodeIfPresent(String.self, forKey: .expenseTypeDesc)
    }
}
