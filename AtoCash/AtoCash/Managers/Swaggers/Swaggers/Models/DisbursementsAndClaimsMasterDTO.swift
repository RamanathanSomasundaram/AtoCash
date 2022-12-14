//
// DisbursementsAndClaimsMasterDTO.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct DisbursementsAndClaimsMasterDTO: Codable {

    public var _id: Int?
    public var employeeId: Int?
    public var employeeName: String?
    public var pettyCashRequestId: Int?
    public var expenseReimburseReqId: Int?
    public var requestTypeId: Int?
    public var requestType: String?
    public var departmentId: Int?
    public var department: String?
    public var projectId: Int?
    public var projectName: String?
    public var subProjectName: String?
    public var subProjectId: Int?
    public var workTaskName: String?
    public var workTaskId: Int?
    public var recordDate: Date?
    public var currencyTypeId: Int?
    public var currencyType: String?
    public var claimAmount: Double?
    public var amountToWallet: Double?
    public var amountToCredit: Double?
    public var isSettledAmountCredited: Bool?
    public var settledDate: Date?
    public var settlementComment: String?
    public var settlementAccount: String?
    public var settlementBankCard: String?
    public var additionalData: String?
    public var costCenterId: Int?
    public var costCenter: String?
    public var approvalStatusId: Int?
    public var approvalStatusType: String?

    public init(_id: Int? = nil, employeeId: Int? = nil, employeeName: String? = nil, pettyCashRequestId: Int? = nil, expenseReimburseReqId: Int? = nil, requestTypeId: Int? = nil, requestType: String? = nil, departmentId: Int? = nil, department: String? = nil, projectId: Int? = nil, projectName: String? = nil, subProjectName: String? = nil, subProjectId: Int? = nil, workTaskName: String? = nil, workTaskId: Int? = nil, recordDate: Date? = nil, currencyTypeId: Int? = nil, currencyType: String? = nil, claimAmount: Double? = nil, amountToWallet: Double? = nil, amountToCredit: Double? = nil, isSettledAmountCredited: Bool? = nil, settledDate: Date? = nil, settlementComment: String? = nil, settlementAccount: String? = nil, settlementBankCard: String? = nil, additionalData: String? = nil, costCenterId: Int? = nil, costCenter: String? = nil, approvalStatusId: Int? = nil, approvalStatusType: String? = nil) {
        self._id = _id
        self.employeeId = employeeId
        self.employeeName = employeeName
        self.pettyCashRequestId = pettyCashRequestId
        self.expenseReimburseReqId = expenseReimburseReqId
        self.requestTypeId = requestTypeId
        self.requestType = requestType
        self.departmentId = departmentId
        self.department = department
        self.projectId = projectId
        self.projectName = projectName
        self.subProjectName = subProjectName
        self.subProjectId = subProjectId
        self.workTaskName = workTaskName
        self.workTaskId = workTaskId
        self.recordDate = recordDate
        self.currencyTypeId = currencyTypeId
        self.currencyType = currencyType
        self.claimAmount = claimAmount
        self.amountToWallet = amountToWallet
        self.amountToCredit = amountToCredit
        self.isSettledAmountCredited = isSettledAmountCredited
        self.settledDate = settledDate
        self.settlementComment = settlementComment
        self.settlementAccount = settlementAccount
        self.settlementBankCard = settlementBankCard
        self.additionalData = additionalData
        self.costCenterId = costCenterId
        self.costCenter = costCenter
        self.approvalStatusId = approvalStatusId
        self.approvalStatusType = approvalStatusType
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case employeeId
        case employeeName
        case pettyCashRequestId
        case expenseReimburseReqId
        case requestTypeId
        case requestType
        case departmentId
        case department
        case projectId
        case projectName
        case subProjectName
        case subProjectId
        case workTaskName
        case workTaskId
        case recordDate
        case currencyTypeId
        case currencyType
        case claimAmount
        case amountToWallet
        case amountToCredit
        case isSettledAmountCredited
        case settledDate
        case settlementComment
        case settlementAccount
        case settlementBankCard
        case additionalData
        case costCenterId
        case costCenter
        case approvalStatusId
        case approvalStatusType
    }

}
