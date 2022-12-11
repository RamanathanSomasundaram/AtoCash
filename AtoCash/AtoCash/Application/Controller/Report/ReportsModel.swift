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

    public var amountToCredit: Double?
    public var amountToWallet: Double?
    public var approvalStatusId: Int?
    public var approvalStatusType: String?
    public var claimAmount: Double?
    public var costCenter: String?
    public var costCenterId: Int?
    public var currencyType: String?
    public var currencyTypeId: Int?
    public var department: String?
    public var departmentId: Int?
    public var employeeId: Int?
    public var employeeName: String?
    public var expenseReimburseReqId: Int?
    public var _id: Int?
    public var pettyCashRequestId: Int?
    public var project: String?
    public var projectId: Int?
    public var recordDate: String?
    public var requestType: String?
    public var requestTypeId: Int?
    public var subProject: String?
    public var subProjectId: Int?
    public var workTask: String?
    public var workTaskId: Int?

    public init(_id: Int? = nil,amountToCredit: Double? = nil,amountToWallet: Double? = nil,approvalStatusId: Int? = nil,approvalStatusType: String? = nil,claimAmount: Double? = nil,costCenter: String? = nil,costCenterId: Int? = nil,currencyType: String? = nil,currencyTypeId: Int? = nil,department: String? = nil,departmentId: Int? = nil,employeeId: Int? = nil,employeeName: String? = nil,expenseReimburseReqId: Int? = nil,pettyCashRequestId: Int? = nil,project: String? = nil,projectId: Int? = nil,recordDate: String? = nil,requestType: String? = nil,requestTypeId: Int? = nil,subProject: String? = nil,subProjectId: Int? = nil,workTask: String? = nil,workTaskId: Int? = nil) {
        self.amountToCredit = amountToCredit
        self.amountToWallet = amountToWallet
        self.approvalStatusId = approvalStatusId
        self.approvalStatusType = approvalStatusType
        self.claimAmount = claimAmount
        self.costCenter = costCenter
        self.costCenterId = costCenterId
        self.currencyType =  currencyType
        self.currencyTypeId = currencyTypeId
        self.department = department
        self.departmentId = departmentId
        self.employeeId = employeeId
        self.employeeName = employeeName
        self.expenseReimburseReqId = expenseReimburseReqId
        self._id = _id
        self.pettyCashRequestId = pettyCashRequestId
        self.project = project
        self.projectId = projectId
        self.recordDate = recordDate
        self.requestType = requestType
        self.requestTypeId = requestTypeId
        self.subProject = subProject
        self.subProjectId = subProjectId
        self.workTask = workTask
        self.workTaskId = workTaskId
    }

    public enum CodingKeys: String, CodingKey {
        case _id = "id"
        case amountToCredit
        case amountToWallet
        case approvalStatusId
        case approvalStatusType
        case claimAmount
        case costCenter
        case costCenterId
        case currencyType
        case currencyTypeId
        case department = "departmentName"
        case departmentId
        case employeeId
        case employeeName
        case expenseReimburseReqId
        case pettyCashRequestId
        case project = "projectName"
        case projectId
        case recordDate
        case requestType
        case requestTypeId
        case subProject = "subProjectName"
        case subProjectId
        case workTask = "workTaskName"
        case workTaskId
    }
}
