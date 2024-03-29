//
// PettyCashRequestsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class PettyCashRequestsAPI {
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiPettyCashRequestsCountAllPettyCashRequestRaisedByEmployeeIdGet(_id: Int, completion: @escaping ((_ data: RequestCountModel?,_ error: Error?) -> Void)) {
        apiPettyCashRequestsCountAllPettyCashRequestRaisedByEmployeeIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            if error == nil {
                completion((response?.body), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     - GET /api/PettyCashRequests/CountAllPettyCashRequestRaisedByEmployee/{id}
     - 

     - parameter _id: (path)  

     - returns: RequestBuilder<Void> 
     */
    open class func apiPettyCashRequestsCountAllPettyCashRequestRaisedByEmployeeIdGetWithRequestBuilder(_id: Int) -> RequestBuilder<RequestCountModel> {
        var path = "/api/CashAdvanceRequests/CountAllCashAdvanceRequestRaisedByEmployee/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<RequestCountModel>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiPettyCashRequestsDeletePettyCashRequestIdDelete(_id: Int, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        apiPettyCashRequestsDeletePettyCashRequestIdDeleteWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     - DELETE /api/PettyCashRequests/DeletePettyCashRequest/{id}
     - 

     - parameter _id: (path)  

     - returns: RequestBuilder<Void> 
     */
    open class func apiPettyCashRequestsDeletePettyCashRequestIdDeleteWithRequestBuilder(_id: Int) -> RequestBuilder<Void> {
        var path = "/api/CashAdvanceRequests/DeletePettyCashRequest/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiPettyCashRequestsGetPettyCashReqInPendingForAllGet(completion: @escaping ((_ data: Int?,_ error: Error?) -> Void)) {
        apiPettyCashRequestsGetPettyCashReqInPendingForAllGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/PettyCashRequests/GetPettyCashReqInPendingForAll
     - 

     - examples: [{contentType=application/json, example=0}]

     - returns: RequestBuilder<Int> 
     */
    open class func apiPettyCashRequestsGetPettyCashReqInPendingForAllGetWithRequestBuilder() -> RequestBuilder<Int> {
        let path = "/api/CashAdvanceRequests/GetPettyCashReqInPendingForAll"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Int>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiPettyCashRequestsGetPettyCashRequestIdGet(_id: Int, completion: @escaping ((_ data: PettyCashRequestDTO?,_ error: Error?) -> Void)) {
        apiPettyCashRequestsGetPettyCashRequestIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/PettyCashRequests/GetPettyCashRequest/{id}
     - 

     - examples: [{contentType=application/json, example={
  "currencyType" : "currencyType",
  "showEditDelete" : true,
  "employeeName" : "employeeName",
  "comments" : "comments",
  "workTask" : "workTask",
  "workTaskId" : 9,
  "departmentId" : 5,
  "project" : "project",
  "employeeId" : 6,
  "approvalStatusTypeId" : 3,
  "pettyClaimAmount" : 5.962133916683182,
  "currencyTypeId" : 1,
  "approvedDate" : "2000-01-23T04:56:07.000+00:00",
  "cashReqDate" : "2000-01-23T04:56:07.000+00:00",
  "subProjectId" : 7,
  "subProject" : "subProject",
  "id" : 0,
  "department" : "department",
  "approvalStatusType" : "approvalStatusType",
  "pettyClaimRequestDesc" : "pettyClaimRequestDesc",
  "projectId" : 2
}}]
     - parameter _id: (path)  

     - returns: RequestBuilder<PettyCashRequestDTO> 
     */
    open class func apiPettyCashRequestsGetPettyCashRequestIdGetWithRequestBuilder(_id: Int) -> RequestBuilder<PettyCashRequestDTO> {
        var path = "/api/CashAdvanceRequests/GetCashAdvanceRequest/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<PettyCashRequestDTO>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter _id: (path)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiCashRequestsDeleteCashApprovalRequestIdDelete(_id: Int, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        apiCashApprovalRequestsDeleteCashApprovalRequestIdDeleteWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     - DELETE /api/TravelApprovalRequests/DeleteTravelApprovalRequest/{id}
     -

     - parameter _id: (path)

     - returns: RequestBuilder<Void>
     */
    open class func apiCashApprovalRequestsDeleteCashApprovalRequestIdDeleteWithRequestBuilder(_id: Int) -> RequestBuilder<Void> {
        var path = "/api/CashAdvanceRequests/DeleteCashAdvanceRequest/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiPettyCashRequestsGetPettyCashRequestRaisedForEmployeeIdGet(_id: Int, completion: @escaping ((_ data: [PettyCashRequestDTO]?,_ error: Error?) -> Void)) {
        apiPettyCashRequestsGetPettyCashRequestRaisedForEmployeeIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/PettyCashRequests/GetPettyCashRequestRaisedForEmployee/{id}
     - 

     - examples: [{contentType=application/json, example=[ {
  "currencyType" : "currencyType",
  "showEditDelete" : true,
  "employeeName" : "employeeName",
  "comments" : "comments",
  "workTask" : "workTask",
  "workTaskId" : 9,
  "departmentId" : 5,
  "project" : "project",
  "employeeId" : 6,
  "approvalStatusTypeId" : 3,
  "pettyClaimAmount" : 5.962133916683182,
  "currencyTypeId" : 1,
  "approvedDate" : "2000-01-23T04:56:07.000+00:00",
  "cashReqDate" : "2000-01-23T04:56:07.000+00:00",
  "subProjectId" : 7,
  "subProject" : "subProject",
  "id" : 0,
  "department" : "department",
  "approvalStatusType" : "approvalStatusType",
  "pettyClaimRequestDesc" : "pettyClaimRequestDesc",
  "projectId" : 2
}, {
  "currencyType" : "currencyType",
  "showEditDelete" : true,
  "employeeName" : "employeeName",
  "comments" : "comments",
  "workTask" : "workTask",
  "workTaskId" : 9,
  "departmentId" : 5,
  "project" : "project",
  "employeeId" : 6,
  "approvalStatusTypeId" : 3,
  "pettyClaimAmount" : 5.962133916683182,
  "currencyTypeId" : 1,
  "approvedDate" : "2000-01-23T04:56:07.000+00:00",
  "cashReqDate" : "2000-01-23T04:56:07.000+00:00",
  "subProjectId" : 7,
  "subProject" : "subProject",
  "id" : 0,
  "department" : "department",
  "approvalStatusType" : "approvalStatusType",
  "pettyClaimRequestDesc" : "pettyClaimRequestDesc",
  "projectId" : 2
} ]}]
     - parameter _id: (path)  

     - returns: RequestBuilder<[PettyCashRequestDTO]> 
     */
    open class func apiPettyCashRequestsGetPettyCashRequestRaisedForEmployeeIdGetWithRequestBuilder(_id: Int) -> RequestBuilder<[PettyCashRequestDTO]> {
        var path = "/api/CashAdvanceRequests/GetCashAdvanceRequestRaisedForEmployee/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[PettyCashRequestDTO]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiPettyCashRequestsGetPettyCashRequestsGet(completion: @escaping ((_ data: [PettyCashRequestDTO]?,_ error: Error?) -> Void)) {
        apiPettyCashRequestsGetPettyCashRequestsGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/PettyCashRequests/GetPettyCashRequests
     - 

     - examples: [{contentType=application/json, example=[ {
  "currencyType" : "currencyType",
  "showEditDelete" : true,
  "employeeName" : "employeeName",
  "comments" : "comments",
  "workTask" : "workTask",
  "workTaskId" : 9,
  "departmentId" : 5,
  "project" : "project",
  "employeeId" : 6,
  "approvalStatusTypeId" : 3,
  "pettyClaimAmount" : 5.962133916683182,
  "currencyTypeId" : 1,
  "approvedDate" : "2000-01-23T04:56:07.000+00:00",
  "cashReqDate" : "2000-01-23T04:56:07.000+00:00",
  "subProjectId" : 7,
  "subProject" : "subProject",
  "id" : 0,
  "department" : "department",
  "approvalStatusType" : "approvalStatusType",
  "pettyClaimRequestDesc" : "pettyClaimRequestDesc",
  "projectId" : 2
}, {
  "currencyType" : "currencyType",
  "showEditDelete" : true,
  "employeeName" : "employeeName",
  "comments" : "comments",
  "workTask" : "workTask",
  "workTaskId" : 9,
  "departmentId" : 5,
  "project" : "project",
  "employeeId" : 6,
  "approvalStatusTypeId" : 3,
  "pettyClaimAmount" : 5.962133916683182,
  "currencyTypeId" : 1,
  "approvedDate" : "2000-01-23T04:56:07.000+00:00",
  "cashReqDate" : "2000-01-23T04:56:07.000+00:00",
  "subProjectId" : 7,
  "subProject" : "subProject",
  "id" : 0,
  "department" : "department",
  "approvalStatusType" : "approvalStatusType",
  "pettyClaimRequestDesc" : "pettyClaimRequestDesc",
  "projectId" : 2
} ]}]

     - returns: RequestBuilder<[PettyCashRequestDTO]> 
     */
    open class func apiPettyCashRequestsGetPettyCashRequestsGetWithRequestBuilder() -> RequestBuilder<[PettyCashRequestDTO]> {
        let path = "/api/CashAdvanceRequests/GetPettyCashRequests"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[PettyCashRequestDTO]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiPettyCashRequestsPostPettyCashRequestPost(body: PettyCashRequestDTO? = nil, completion: @escaping ((_ data: SuccessModel?,_ error: Error?) -> Void)) {
        apiPettyCashRequestsPostPettyCashRequestPostWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion((response?.body), error)
        }
    }


    /**
     - POST /api/PettyCashRequests/PostPettyCashRequest
     - 

     - examples: [{contentType=application/json, example={
  "comments" : "comments",
  "workTask" : {
    "taskDesc" : "taskDesc",
    "subProjectId" : 5,
    "taskName" : "taskName",
    "id" : 6
  },
  "workTaskId" : 6,
  "departmentId" : 6,
  "project" : {
    "costCenterId" : 9,
    "statusTypeId" : 3,
    "projectManagerId" : 6,
    "projectDesc" : "projectDesc",
    "id" : 8,
    "projectName" : "projectName"
  },
  "employeeId" : 5,
  "approvalStatusTypeId" : 3,
  "pettyClaimAmount" : 9.965781217890562,
  "currencyTypeId" : 9,
  "approvedDate" : "2000-01-23T04:56:07.000+00:00",
  "cashReqDate" : "2000-01-23T04:56:07.000+00:00",
  "subProjectId" : 6,
  "subProject" : {
    "subProjectName" : "subProjectName",
    "subProjectDesc" : "subProjectDesc",
    "id" : 1,
    "projectId" : 2
  },
  "id" : 4,
  "approvalStatusType" : {
    "statusDesc" : "statusDesc",
    "id" : 0,
    "status" : "status"
  },
  "pettyClaimRequestDesc" : "pettyClaimRequestDesc",
  "projectId" : 6
}}]
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<PettyCashRequest> 
     */
    open class func apiPettyCashRequestsPostPettyCashRequestPostWithRequestBuilder(body: PettyCashRequestDTO? = nil) -> RequestBuilder<SuccessModel> {
        let path = "/api/CashAdvanceRequests/PostCashAdvanceRequest"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<SuccessModel>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
    /**

     - parameter _id: (path)  
     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiPettyCashRequestsPutPettyCashRequestIdPut(_id: Int, body: PettyCashRequestDTO? = nil, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        apiPettyCashRequestsPutPettyCashRequestIdPutWithRequestBuilder(_id: _id, body: body).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     - PUT /api/PettyCashRequests/PutPettyCashRequest/{id}
     - 

     - parameter _id: (path)  
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func apiPettyCashRequestsPutPettyCashRequestIdPutWithRequestBuilder(_id: Int, body: PettyCashRequestDTO? = nil) -> RequestBuilder<Void> {
        var path = "/api/CashAdvanceRequests/PutCashAdvanceRequest/{id}"
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
