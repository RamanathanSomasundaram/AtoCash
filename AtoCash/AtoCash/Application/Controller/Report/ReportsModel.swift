//
//  ReportsModel.swift
//  AtoCash
//
//  Created by user on 05/05/21.
//

import Foundation
/*
 amountToCredit: 0
 amountToWallet: 0
 approvalStatusId: 4
 approvalStatusType: "Approved"
 claimAmount: 100
 costCenter: "AT-CC-0001"
 costCenterId: 2
 currencyType: "INR"
 currencyTypeId: 1
 department: "ATRPA-001"
 departmentId: 2
 employeeId: 5
 employeeName: "Irfan  Rashid"
 expenseReimburseReqId: null
 id: 2019
 pettyCashRequestId: 2010
 project: null
 projectId: null
 recordDate: "0001-01-01T00:00:00"
 requestType: "Cash Advance Request"
 requestTypeId: 1
 subProject: null
 subProjectId: null
 workTask: null
 workTaskId: null
 
 **/
public struct ReportsModel: Codable {

    let id : Int?
    let employeeId : Int?
    let employeeName : String?
    let blendedRequestId : Int?
    let requestTypeId : Int?
    let requestType : String?
    let businessTypeId : Int?
    let businessType : String?
    let businessUnitId : Int?
    let businessUnit : String?
    let projectId : Int?
    let projectName : String?
    let subProjectName : String?
    let subProjectId : Int?
    let workTaskName : String?
    let workTaskId : Int?
    let requestDate : Date?
    let currencyTypeId : Int?
    let currencyType : String?
    let claimAmount : Double?
    let amountToWallet : Int?
    let amountToCredit : Int?
    let isSettledAmountCredited : Bool?
    let settledDate : String?
    let settlementComment : String?
    let settlementAccount : String?
    let settlementBankCard : String?
    let additionalData : String?
    let costCenterId : Int?
    let costCenter : String?
    let approvalStatusId : Int?
    let approvalStatusType : String?
    let requestTitleDescription : String?

    public enum CodingKeys: String, CodingKey {

        case id = "id"
        case employeeId = "employeeId"
        case employeeName = "employeeName"
        case blendedRequestId = "blendedRequestId"
        case requestTypeId = "requestTypeId"
        case requestType = "requestType"
        case businessTypeId = "businessTypeId"
        case businessType = "businessType"
        case businessUnitId = "businessUnitId"
        case businessUnit = "businessUnit"
        case projectId = "projectId"
        case projectName = "projectName"
        case subProjectName = "subProjectName"
        case subProjectId = "subProjectId"
        case workTaskName = "workTaskName"
        case workTaskId = "workTaskId"
        case requestDate = "requestDate"
        case currencyTypeId = "currencyTypeId"
        case currencyType = "currencyType"
        case claimAmount = "claimAmount"
        case amountToWallet = "amountToWallet"
        case amountToCredit = "amountToCredit"
        case isSettledAmountCredited = "isSettledAmountCredited"
        case settledDate = "settledDate"
        case settlementComment = "settlementComment"
        case settlementAccount = "settlementAccount"
        case settlementBankCard = "settlementBankCard"
        case additionalData = "additionalData"
        case costCenterId = "costCenterId"
        case costCenter = "costCenter"
        case approvalStatusId = "approvalStatusId"
        case approvalStatusType = "approvalStatusType"
        case requestTitleDescription = "requestTitleDescription"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        employeeId = try values.decodeIfPresent(Int.self, forKey: .employeeId)
        employeeName = try values.decodeIfPresent(String.self, forKey: .employeeName)
        blendedRequestId = try values.decodeIfPresent(Int.self, forKey: .blendedRequestId)
        requestTypeId = try values.decodeIfPresent(Int.self, forKey: .requestTypeId)
        requestType = try values.decodeIfPresent(String.self, forKey: .requestType)
        businessTypeId = try values.decodeIfPresent(Int.self, forKey: .businessTypeId)
        businessType = try values.decodeIfPresent(String.self, forKey: .businessType)
        businessUnitId = try values.decodeIfPresent(Int.self, forKey: .businessUnitId)
        businessUnit = try values.decodeIfPresent(String.self, forKey: .businessUnit)
        projectId = try values.decodeIfPresent(Int.self, forKey: .projectId)
        projectName = try values.decodeIfPresent(String.self, forKey: .projectName)
        subProjectName = try values.decodeIfPresent(String.self, forKey: .subProjectName)
        subProjectId = try values.decodeIfPresent(Int.self, forKey: .subProjectId)
        workTaskName = try values.decodeIfPresent(String.self, forKey: .workTaskName)
        workTaskId = try values.decodeIfPresent(Int.self, forKey: .workTaskId)
        requestDate = try values.decodeIfPresent(Date.self, forKey: .requestDate)
        currencyTypeId = try values.decodeIfPresent(Int.self, forKey: .currencyTypeId)
        currencyType = try values.decodeIfPresent(String.self, forKey: .currencyType)
        claimAmount = try values.decodeIfPresent(Double.self, forKey: .claimAmount)
        amountToWallet = try values.decodeIfPresent(Int.self, forKey: .amountToWallet)
        amountToCredit = try values.decodeIfPresent(Int.self, forKey: .amountToCredit)
        isSettledAmountCredited = try values.decodeIfPresent(Bool.self, forKey: .isSettledAmountCredited)
        settledDate = try values.decodeIfPresent(String.self, forKey: .settledDate)
        settlementComment = try values.decodeIfPresent(String.self, forKey: .settlementComment)
        settlementAccount = try values.decodeIfPresent(String.self, forKey: .settlementAccount)
        settlementBankCard = try values.decodeIfPresent(String.self, forKey: .settlementBankCard)
        additionalData = try values.decodeIfPresent(String.self, forKey: .additionalData)
        costCenterId = try values.decodeIfPresent(Int.self, forKey: .costCenterId)
        costCenter = try values.decodeIfPresent(String.self, forKey: .costCenter)
        approvalStatusId = try values.decodeIfPresent(Int.self, forKey: .approvalStatusId)
        approvalStatusType = try values.decodeIfPresent(String.self, forKey: .approvalStatusType)
        requestTitleDescription = try values.decodeIfPresent(String.self, forKey: .requestTitleDescription)
    }

}
