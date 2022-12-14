//
// TravelApprovalRequestsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class TravelApprovalRequestsAPI {
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiTravelApprovalRequestsCountAllTravelRequestRaisedByEmployeeIdGet(_id: Int, completion: @escaping ((_ data: RequestCountModel?,_ error: Error?) -> Void)) {
        apiTravelApprovalRequestsCountAllTravelRequestRaisedByEmployeeIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            if error == nil {
                completion((response?.body), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     - GET /api/TravelApprovalRequests/CountAllTravelRequestRaisedByEmployee/{id}
     - 

     - parameter _id: (path)  

     - returns: RequestBuilder<Void> 
     */
    open class func apiTravelApprovalRequestsCountAllTravelRequestRaisedByEmployeeIdGetWithRequestBuilder(_id: Int) -> RequestBuilder<RequestCountModel> {
        var path = "/api/TravelApprovalRequests/CountAllTravelRequestRaisedByEmployee/{id}"
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
    open class func apiTravelApprovalRequestsDeleteTravelApprovalRequestIdDelete(_id: Int, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        apiTravelApprovalRequestsDeleteTravelApprovalRequestIdDeleteWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
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
    open class func apiTravelApprovalRequestsDeleteTravelApprovalRequestIdDeleteWithRequestBuilder(_id: Int) -> RequestBuilder<Void> {
        var path = "/api/TravelApprovalRequests/DeleteTravelApprovalRequest/{id}"
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
    open class func apiTravelApprovalRequestsGetTravelApprovalRequestIdGet(_id: Int, completion: @escaping ((_ data: TravelApprovalRequestDTO?,_ error: Error?) -> Void)) {
        apiTravelApprovalRequestsGetTravelApprovalRequestIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/TravelApprovalRequests/GetTravelApprovalRequest/{id}
     - 

     - examples: [{contentType=application/json, example={
  "showEditDelete" : true,
  "employeeName" : "employeeName",
  "comments" : "comments",
  "workTaskId" : 2,
  "workTask" : "workTask",
  "costCenter" : "costCenter",
  "departmentId" : 1,
  "project" : "project",
  "employeeId" : 6,
  "travelPurpose" : "travelPurpose",
  "approvalStatusTypeId" : 9,
  "travelEndDate" : "2000-01-23T04:56:07.000+00:00",
  "approvedDate" : "2000-01-23T04:56:07.000+00:00",
  "costCenterId" : 7,
  "travelStartDate" : "2000-01-23T04:56:07.000+00:00",
  "subProjectId" : 5,
  "subProject" : "subProject",
  "id" : 0,
  "department" : "department",
  "approvalStatusType" : "approvalStatusType",
  "reqRaisedDate" : "2000-01-23T04:56:07.000+00:00",
  "projectId" : 5
}}]
     - parameter _id: (path)  

     - returns: RequestBuilder<TravelApprovalRequestDTO> 
     */
    open class func apiTravelApprovalRequestsGetTravelApprovalRequestIdGetWithRequestBuilder(_id: Int) -> RequestBuilder<TravelApprovalRequestDTO> {
        var path = "/api/TravelApprovalRequests/GetTravelApprovalRequest/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<TravelApprovalRequestDTO>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiTravelApprovalRequestsGetTravelApprovalRequestRaisedForEmployeeIdGet(_id: Int, completion: @escaping ((_ data: [TravelApprovalRequestDTO]?,_ error: Error?) -> Void)) {
        apiTravelApprovalRequestsGetTravelApprovalRequestRaisedForEmployeeIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/TravelApprovalRequests/GetTravelApprovalRequestRaisedForEmployee/{id}
     - 

     - examples: [{contentType=application/json, example=[ {
  "showEditDelete" : true,
  "employeeName" : "employeeName",
  "comments" : "comments",
  "workTaskId" : 2,
  "workTask" : "workTask",
  "costCenter" : "costCenter",
  "departmentId" : 1,
  "project" : "project",
  "employeeId" : 6,
  "travelPurpose" : "travelPurpose",
  "approvalStatusTypeId" : 9,
  "travelEndDate" : "2000-01-23T04:56:07.000+00:00",
  "approvedDate" : "2000-01-23T04:56:07.000+00:00",
  "costCenterId" : 7,
  "travelStartDate" : "2000-01-23T04:56:07.000+00:00",
  "subProjectId" : 5,
  "subProject" : "subProject",
  "id" : 0,
  "department" : "department",
  "approvalStatusType" : "approvalStatusType",
  "reqRaisedDate" : "2000-01-23T04:56:07.000+00:00",
  "projectId" : 5
}, {
  "showEditDelete" : true,
  "employeeName" : "employeeName",
  "comments" : "comments",
  "workTaskId" : 2,
  "workTask" : "workTask",
  "costCenter" : "costCenter",
  "departmentId" : 1,
  "project" : "project",
  "employeeId" : 6,
  "travelPurpose" : "travelPurpose",
  "approvalStatusTypeId" : 9,
  "travelEndDate" : "2000-01-23T04:56:07.000+00:00",
  "approvedDate" : "2000-01-23T04:56:07.000+00:00",
  "costCenterId" : 7,
  "travelStartDate" : "2000-01-23T04:56:07.000+00:00",
  "subProjectId" : 5,
  "subProject" : "subProject",
  "id" : 0,
  "department" : "department",
  "approvalStatusType" : "approvalStatusType",
  "reqRaisedDate" : "2000-01-23T04:56:07.000+00:00",
  "projectId" : 5
} ]}]
     - parameter _id: (path)  

     - returns: RequestBuilder<[TravelApprovalRequestDTO]> 
     */
    open class func apiTravelApprovalRequestsGetTravelApprovalRequestRaisedForEmployeeIdGetWithRequestBuilder(_id: Int) -> RequestBuilder<[TravelApprovalRequestDTO]> {
        var path = "/api/TravelApprovalRequests/GetTravelApprovalRequestRaisedForEmployee/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[TravelApprovalRequestDTO]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiTravelApprovalRequestsGetTravelApprovalRequestsGet(completion: @escaping ((_ data: [TravelApprovalRequestDTO]?,_ error: Error?) -> Void)) {
        apiTravelApprovalRequestsGetTravelApprovalRequestsGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/TravelApprovalRequests/GetTravelApprovalRequests
     - 

     - examples: [{contentType=application/json, example=[ {
  "showEditDelete" : true,
  "employeeName" : "employeeName",
  "comments" : "comments",
  "workTaskId" : 2,
  "workTask" : "workTask",
  "costCenter" : "costCenter",
  "departmentId" : 1,
  "project" : "project",
  "employeeId" : 6,
  "travelPurpose" : "travelPurpose",
  "approvalStatusTypeId" : 9,
  "travelEndDate" : "2000-01-23T04:56:07.000+00:00",
  "approvedDate" : "2000-01-23T04:56:07.000+00:00",
  "costCenterId" : 7,
  "travelStartDate" : "2000-01-23T04:56:07.000+00:00",
  "subProjectId" : 5,
  "subProject" : "subProject",
  "id" : 0,
  "department" : "department",
  "approvalStatusType" : "approvalStatusType",
  "reqRaisedDate" : "2000-01-23T04:56:07.000+00:00",
  "projectId" : 5
}, {
  "showEditDelete" : true,
  "employeeName" : "employeeName",
  "comments" : "comments",
  "workTaskId" : 2,
  "workTask" : "workTask",
  "costCenter" : "costCenter",
  "departmentId" : 1,
  "project" : "project",
  "employeeId" : 6,
  "travelPurpose" : "travelPurpose",
  "approvalStatusTypeId" : 9,
  "travelEndDate" : "2000-01-23T04:56:07.000+00:00",
  "approvedDate" : "2000-01-23T04:56:07.000+00:00",
  "costCenterId" : 7,
  "travelStartDate" : "2000-01-23T04:56:07.000+00:00",
  "subProjectId" : 5,
  "subProject" : "subProject",
  "id" : 0,
  "department" : "department",
  "approvalStatusType" : "approvalStatusType",
  "reqRaisedDate" : "2000-01-23T04:56:07.000+00:00",
  "projectId" : 5
} ]}]

     - returns: RequestBuilder<[TravelApprovalRequestDTO]> 
     */
    open class func apiTravelApprovalRequestsGetTravelApprovalRequestsGetWithRequestBuilder() -> RequestBuilder<[TravelApprovalRequestDTO]> {
        let path = "/api/TravelApprovalRequests/GetTravelApprovalRequests"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[TravelApprovalRequestDTO]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiTravelApprovalRequestsGetTravelReqInPendingForAllGet(completion: @escaping ((_ data: Int?,_ error: Error?) -> Void)) {
        apiTravelApprovalRequestsGetTravelReqInPendingForAllGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/TravelApprovalRequests/GetTravelReqInPendingForAll
     - 

     - examples: [{contentType=application/json, example=0}]

     - returns: RequestBuilder<Int> 
     */
    open class func apiTravelApprovalRequestsGetTravelReqInPendingForAllGetWithRequestBuilder() -> RequestBuilder<Int> {
        let path = "/api/TravelApprovalRequests/GetTravelReqInPendingForAll"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Int>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiTravelApprovalRequestsPostTravelApprovalRequestPost(body: TravelApprovalRequestDTO? = nil, completion: @escaping ((_ data: SuccessModel?,_ error: Error?) -> Void)) {
        apiTravelApprovalRequestsPostTravelApprovalRequestPostWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - POST /api/TravelApprovalRequests/PostTravelApprovalRequest
     - 

     - examples: [{contentType=application/json, example={
  "comments" : "comments",
  "workTask" : {
    "taskDesc" : "taskDesc",
    "subProjectId" : 5,
    "taskName" : "taskName",
    "id" : 6
  },
  "workTaskId" : 2,
  "costCenter" : {
    "costCenterCode" : "costCenterCode",
    "statusType" : {
      "id" : 7,
      "status" : "status"
    },
    "statusTypeId" : 9,
    "id" : 2,
    "costCenterDesc" : "costCenterDesc"
  },
  "departmentId" : 1,
  "project" : {
    "costCenterId" : 9,
    "statusTypeId" : 3,
    "projectManagerId" : 6,
    "projectDesc" : "projectDesc",
    "id" : 8,
    "projectName" : "projectName"
  },
  "employeeId" : 6,
  "travelPurpose" : "travelPurpose",
  "approvalStatusTypeId" : 9,
  "employee" : {
    "currencyType" : {
      "country" : "country",
      "currencyName" : "currencyName",
      "statusTypeId" : 1,
      "id" : 1,
      "currencyCode" : "currencyCode"
    },
    "lastName" : "lastName",
    "approvalGroup" : {
      "approvalGroupDesc" : "approvalGroupDesc",
      "approvalGroupCode" : "approvalGroupCode",
      "id" : 0
    },
    "role" : {
      "roleCode" : "roleCode",
      "roleName" : "roleName",
      "id" : 1,
      "maxPettyCashAllowed" : 5.962133916683182
    },
    "gender" : "gender",
    "mobileNumber" : "mobileNumber",
    "departmentId" : 4,
    "statusTypeId" : 7,
    "nationalID" : "nationalID",
    "id" : 6,
    "department" : {
      "deptName" : "deptName",
      "costCenterId" : 3,
      "costCenter" : {
        "costCenterCode" : "costCenterCode",
        "statusType" : {
          "id" : 7,
          "status" : "status"
        },
        "statusTypeId" : 9,
        "id" : 2,
        "costCenterDesc" : "costCenterDesc"
      },
      "statusTypeId" : 2,
      "id" : 5,
      "deptCode" : "deptCode"
    },
    "email" : "",
    "bankAccount" : "bankAccount",
    "passportNo" : "passportNo",
    "bankCardNo" : "bankCardNo",
    "employmentType" : {
      "empJobTypeCode" : "empJobTypeCode",
      "id" : 1,
      "empJobTypeDesc" : "empJobTypeDesc"
    },
    "roleId" : 7,
    "taxNumber" : "taxNumber",
    "currencyTypeId" : 6,
    "firstName" : "firstName",
    "nationality" : "nationality",
    "empCode" : "empCode",
    "employmentTypeId" : 5,
    "dob" : "2000-01-23T04:56:07.000+00:00",
    "approvalGroupId" : 1,
    "middleName" : "middleName",
    "doj" : "2000-01-23T04:56:07.000+00:00"
  },
  "travelEndDate" : "2000-01-23T04:56:07.000+00:00",
  "approvedDate" : "2000-01-23T04:56:07.000+00:00",
  "costCenterId" : 7,
  "travelStartDate" : "2000-01-23T04:56:07.000+00:00",
  "subProjectId" : 5,
  "subProject" : {
    "subProjectName" : "subProjectName",
    "subProjectDesc" : "subProjectDesc",
    "id" : 1,
    "projectId" : 2
  },
  "id" : 0,
  "department" : {
    "deptName" : "deptName",
    "costCenterId" : 3,
    "costCenter" : {
      "costCenterCode" : "costCenterCode",
      "statusType" : {
        "id" : 7,
        "status" : "status"
      },
      "statusTypeId" : 9,
      "id" : 2,
      "costCenterDesc" : "costCenterDesc"
    },
    "statusTypeId" : 2,
    "id" : 5,
    "deptCode" : "deptCode"
  },
  "approvalStatusType" : {
    "statusDesc" : "statusDesc",
    "id" : 0,
    "status" : "status"
  },
  "reqRaisedDate" : "2000-01-23T04:56:07.000+00:00",
  "projectId" : 5
}}]
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<TravelApprovalRequest> 
     */
    open class func apiTravelApprovalRequestsPostTravelApprovalRequestPostWithRequestBuilder(body: TravelApprovalRequestDTO? = nil) -> RequestBuilder<SuccessModel> {
        let path = "/api/TravelApprovalRequests/PostTravelApprovalRequest"
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
    open class func apiTravelApprovalRequestsPutTravelApprovalRequestIdPut(_id: Int, body: TravelApprovalRequestDTO? = nil, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        apiTravelApprovalRequestsPutTravelApprovalRequestIdPutWithRequestBuilder(_id: _id, body: body).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     - PUT /api/TravelApprovalRequests/PutTravelApprovalRequest/{id}
     - 

     - parameter _id: (path)  
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func apiTravelApprovalRequestsPutTravelApprovalRequestIdPutWithRequestBuilder(_id: Int, body: TravelApprovalRequestDTO? = nil) -> RequestBuilder<Void> {
        var path = "/api/TravelApprovalRequests/PutTravelApprovalRequest/{id}"
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
