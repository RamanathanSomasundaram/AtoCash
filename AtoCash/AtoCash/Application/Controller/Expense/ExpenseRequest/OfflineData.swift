//
//  OfflineData.swift
//  AtoCash
//
//  Created by User on 13/06/21.
//

import Foundation
import UIKit

struct offlineData : Codable {
    var expenseTitle : String?
    var businessType : BusinessTypeVM?
    var businessUnit : BusinessUnitVM?
    var businessLocation : BusinessUnitLocationVM?
    var project : ProjectVM?
    var subProjct : SubProjectVM?
    var task : TaskModel?
    var empId : Int?
    var totalAmount : Double?
    var expenseDate : Date?
    var itemsList : [addItemInfo]?
    var isBusiness : Bool?
    var isDepart : Bool?
    
    init(expenseTitle : String?,businessType: BusinessTypeVM? ,businessUnit: BusinessUnitVM?,businessLocation: BusinessUnitLocationVM? = nil,project : ProjectVM? ,subProjct : SubProjectVM?,task : TaskModel?,empId : Int?,totalAmount : Double?,expenseDate : Date?,itemsList : [addItemInfo]?, isBusiness : Bool = false, isDepart : Bool = false ){
        self.expenseTitle = expenseTitle
        self.project = project
        self.businessType = businessType
        self.businessUnit = businessUnit
        self.businessLocation = businessLocation
        self.subProjct = subProjct
        self.task = task
        self.empId = empId
        self.totalAmount = totalAmount
        self.expenseDate = expenseDate
        self.itemsList = itemsList
        self.isBusiness = isBusiness
        self.isDepart = isDepart
    }
    
    enum CodingKeys: String, CodingKey,CaseIterable {
        
        case expenseTitle
        case businessType
        case businessUnit
        case businessLocation
        case project
        case subProjct
        case task
        case empId
        case totalAmount
        case expenseDate
        case itemsList
        case isBusiness
        case isDepart
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        expenseTitle = try values.decodeIfPresent(String.self, forKey: .expenseTitle)
        project = try values.decodeIfPresent(ProjectVM.self, forKey: .project)
        businessUnit = try values.decodeIfPresent(BusinessUnitVM.self, forKey: .businessUnit)
        businessType = try values.decodeIfPresent(BusinessTypeVM.self, forKey: .businessType)
        businessLocation = try values.decodeIfPresent(BusinessUnitLocationVM.self, forKey: .businessLocation)
        subProjct = try values.decodeIfPresent(SubProjectVM.self, forKey: .subProjct)
        task = try values.decodeIfPresent(TaskModel.self, forKey: .task)
        empId = try values.decodeIfPresent(Int.self, forKey: .empId)
        totalAmount = try values.decodeIfPresent(Double.self, forKey: .totalAmount)
        expenseDate = try values.decodeIfPresent(Date.self, forKey: .expenseDate)
        itemsList = try values.decodeIfPresent([addItemInfo].self, forKey: .itemsList)
        isBusiness = try values.decode(Bool.self, forKey: .isBusiness)
        isDepart = try values.decode(Bool.self, forKey: .isDepart)
    }
}
struct offlineRequest{
    var expenseTitle : String?
    var project : ProjectVM?
    var subProjct : SubProjectVM?
    var task : TaskModel?
    var totalAmount : Double?
    var expenseDate : Date?
    var itemsList : [addItemInfo]?
    var isBusiness : Bool?
    
    init(expenseTitle : String?,project : ProjectVM? ,subProjct : SubProjectVM?,task : TaskModel?,totalAmount : Double?,expenseDate : Date?,itemsList : [addItemInfo]?, isBusiness : Bool = false ){
        self.expenseTitle = expenseTitle
        self.project = project
        self.subProjct = subProjct
        self.task = task
        self.totalAmount = totalAmount
        self.expenseDate = expenseDate
        self.itemsList = itemsList
        self.isBusiness = isBusiness
    }
}
