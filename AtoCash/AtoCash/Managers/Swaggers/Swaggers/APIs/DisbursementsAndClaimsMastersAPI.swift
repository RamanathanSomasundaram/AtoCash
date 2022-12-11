//
// DisbursementsAndClaimsMastersAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class DisbursementsAndClaimsMastersAPI {
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiDisbursementsAndClaimsMastersGet(completion: @escaping ((_ data: [DisbursementsAndClaimsMasterDTO]?,_ error: Error?) -> Void)) {
        apiDisbursementsAndClaimsMastersGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/DisbursementsAndClaimsMasters
     - 

     - examples: [{contentType=application/json, example=[ {
  "currencyType" : "currencyType",
  "subProjectName" : "subProjectName",
  "requestTypeId" : 5,
  "workTaskId" : 3,
  "departmentId" : 2,
  "workTaskName" : "workTaskName",
  "isSettledAmountCredited" : true,
  "costCenterId" : 1,
  "recordDate" : "2000-01-23T04:56:07.000+00:00",
  "id" : 0,
  "settledDate" : "2000-01-23T04:56:07.000+00:00",
  "additionalData" : "additionalData",
  "department" : "department",
  "employeeName" : "employeeName",
  "requestType" : "requestType",
  "costCenter" : "costCenter",
  "expenseReimburseReqId" : 5,
  "claimAmount" : 4.145608029883936,
  "employeeId" : 6,
  "amountToWallet" : 7.386281948385884,
  "approvalStatusId" : 1,
  "currencyTypeId" : 2,
  "settlementBankCard" : "settlementBankCard",
  "pettyCashRequestId" : 1,
  "subProjectId" : 9,
  "settlementComment" : "settlementComment",
  "projectName" : "projectName",
  "approvalStatusType" : "approvalStatusType",
  "projectId" : 7,
  "amountToCredit" : 1.2315135367772556,
  "settlementAccount" : "settlementAccount"
}, {
  "currencyType" : "currencyType",
  "subProjectName" : "subProjectName",
  "requestTypeId" : 5,
  "workTaskId" : 3,
  "departmentId" : 2,
  "workTaskName" : "workTaskName",
  "isSettledAmountCredited" : true,
  "costCenterId" : 1,
  "recordDate" : "2000-01-23T04:56:07.000+00:00",
  "id" : 0,
  "settledDate" : "2000-01-23T04:56:07.000+00:00",
  "additionalData" : "additionalData",
  "department" : "department",
  "employeeName" : "employeeName",
  "requestType" : "requestType",
  "costCenter" : "costCenter",
  "expenseReimburseReqId" : 5,
  "claimAmount" : 4.145608029883936,
  "employeeId" : 6,
  "amountToWallet" : 7.386281948385884,
  "approvalStatusId" : 1,
  "currencyTypeId" : 2,
  "settlementBankCard" : "settlementBankCard",
  "pettyCashRequestId" : 1,
  "subProjectId" : 9,
  "settlementComment" : "settlementComment",
  "projectName" : "projectName",
  "approvalStatusType" : "approvalStatusType",
  "projectId" : 7,
  "amountToCredit" : 1.2315135367772556,
  "settlementAccount" : "settlementAccount"
} ]}]

     - returns: RequestBuilder<[DisbursementsAndClaimsMasterDTO]> 
     */
    open class func apiDisbursementsAndClaimsMastersGetWithRequestBuilder() -> RequestBuilder<[DisbursementsAndClaimsMasterDTO]> {
        let path = "/api/DisbursementsAndClaimsMasters"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[DisbursementsAndClaimsMasterDTO]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiDisbursementsAndClaimsMastersIdGet(_id: Int, completion: @escaping ((_ data: DisbursementsAndClaimsMasterDTO?,_ error: Error?) -> Void)) {
        apiDisbursementsAndClaimsMastersIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/DisbursementsAndClaimsMasters/{id}
     - 

     - examples: [{contentType=application/json, example={
  "currencyType" : "currencyType",
  "subProjectName" : "subProjectName",
  "requestTypeId" : 5,
  "workTaskId" : 3,
  "departmentId" : 2,
  "workTaskName" : "workTaskName",
  "isSettledAmountCredited" : true,
  "costCenterId" : 1,
  "recordDate" : "2000-01-23T04:56:07.000+00:00",
  "id" : 0,
  "settledDate" : "2000-01-23T04:56:07.000+00:00",
  "additionalData" : "additionalData",
  "department" : "department",
  "employeeName" : "employeeName",
  "requestType" : "requestType",
  "costCenter" : "costCenter",
  "expenseReimburseReqId" : 5,
  "claimAmount" : 4.145608029883936,
  "employeeId" : 6,
  "amountToWallet" : 7.386281948385884,
  "approvalStatusId" : 1,
  "currencyTypeId" : 2,
  "settlementBankCard" : "settlementBankCard",
  "pettyCashRequestId" : 1,
  "subProjectId" : 9,
  "settlementComment" : "settlementComment",
  "projectName" : "projectName",
  "approvalStatusType" : "approvalStatusType",
  "projectId" : 7,
  "amountToCredit" : 1.2315135367772556,
  "settlementAccount" : "settlementAccount"
}}]
     - parameter _id: (path)  

     - returns: RequestBuilder<DisbursementsAndClaimsMasterDTO> 
     */
    open class func apiDisbursementsAndClaimsMastersIdGetWithRequestBuilder(_id: Int) -> RequestBuilder<DisbursementsAndClaimsMasterDTO> {
        var path = "/api/DisbursementsAndClaimsMasters/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<DisbursementsAndClaimsMasterDTO>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter _id: (path)  
     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiDisbursementsAndClaimsMastersIdPut(_id: Int, body: DisbursementsAndClaimsMasterDTO? = nil, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        apiDisbursementsAndClaimsMastersIdPutWithRequestBuilder(_id: _id, body: body).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     - PUT /api/DisbursementsAndClaimsMasters/{id}
     - 

     - parameter _id: (path)  
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func apiDisbursementsAndClaimsMastersIdPutWithRequestBuilder(_id: Int, body: DisbursementsAndClaimsMasterDTO? = nil) -> RequestBuilder<Void> {
        var path = "/api/DisbursementsAndClaimsMasters/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
}