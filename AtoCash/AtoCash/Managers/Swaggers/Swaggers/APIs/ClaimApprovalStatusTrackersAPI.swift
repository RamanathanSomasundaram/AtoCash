//
// ClaimApprovalStatusTrackersAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class ClaimApprovalStatusTrackersAPI {
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiClaimApprovalStatusTrackersApprovalFlowForRequestIdGet(_id: Int, completion: @escaping ((_ data: [ApprovalStatusFlowVM]?,_ error: Error?) -> Void)) {
        apiClaimApprovalStatusTrackersApprovalFlowForRequestIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/ClaimApprovalStatusTrackers/ApprovalFlowForRequest/{id}
     - 

     - examples: [{contentType=application/json, example=[ {
  "approvedDate" : "2000-01-23T04:56:07.000+00:00",
  "approverRole" : "approverRole",
  "approvalLevel" : 0,
  "approvalStatusType" : "approvalStatusType",
  "approverName" : "approverName"
}, {
  "approvedDate" : "2000-01-23T04:56:07.000+00:00",
  "approverRole" : "approverRole",
  "approvalLevel" : 0,
  "approvalStatusType" : "approvalStatusType",
  "approverName" : "approverName"
} ]}]
     - parameter _id: (path)  

     - returns: RequestBuilder<[ApprovalStatusFlowVM]> 
     */
    open class func apiClaimApprovalStatusTrackersApprovalFlowForRequestIdGetWithRequestBuilder(_id: Int) -> RequestBuilder<[ApprovalStatusFlowVM]> {
        var path = "/api/ClaimApprovalStatusTrackers/ApprovalFlowForRequest/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[ApprovalStatusFlowVM]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiClaimApprovalStatusTrackersApprovalsPendingForApproverIdGet(_id: Int, completion: @escaping ((_ data: [ClaimApprovalStatusTrackerDTO]?,_ error: Error?) -> Void)) {
        apiClaimApprovalStatusTrackersApprovalsPendingForApproverIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/ClaimApprovalStatusTrackers/ApprovalsPendingForApprover/{id}
     - 

     - examples: [{contentType=application/json, example=[ {
  "departmentName" : "departmentName",
  "finalApprovedDate" : "2000-01-23T04:56:07.000+00:00",
  "employeeName" : "employeeName",
  "subProjectName" : "subProjectName",
  "comments" : "comments",
  "workTaskId" : 7,
  "workTask" : "workTask",
  "roleId" : 3,
  "departmentId" : 5,
  "employeeId" : 6,
  "approvalStatusTypeId" : 4,
  "approvalLevelId" : 2,
  "reqDate" : "2000-01-23T04:56:07.000+00:00",
  "approvalGroupId" : 9,
  "pettyCashRequestId" : 1,
  "subProjectId" : 2,
  "jobRole" : "jobRole",
  "id" : 0,
  "projectName" : "projectName",
  "approvalStatusType" : "approvalStatusType",
  "projectId" : 5
}, {
  "departmentName" : "departmentName",
  "finalApprovedDate" : "2000-01-23T04:56:07.000+00:00",
  "employeeName" : "employeeName",
  "subProjectName" : "subProjectName",
  "comments" : "comments",
  "workTaskId" : 7,
  "workTask" : "workTask",
  "roleId" : 3,
  "departmentId" : 5,
  "employeeId" : 6,
  "approvalStatusTypeId" : 4,
  "approvalLevelId" : 2,
  "reqDate" : "2000-01-23T04:56:07.000+00:00",
  "approvalGroupId" : 9,
  "pettyCashRequestId" : 1,
  "subProjectId" : 2,
  "jobRole" : "jobRole",
  "id" : 0,
  "projectName" : "projectName",
  "approvalStatusType" : "approvalStatusType",
  "projectId" : 5
} ]}]
     - parameter _id: (path)  

     - returns: RequestBuilder<[ClaimApprovalStatusTrackerDTO]> 
     */
    open class func apiClaimApprovalStatusTrackersApprovalsPendingForApproverIdGetWithRequestBuilder(_id: Int) -> RequestBuilder<[ClaimApprovalStatusTrackerDTO]> {
        var path = "/api/ClaimApprovalStatusTrackers/ApprovalsPendingForApprover/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[ClaimApprovalStatusTrackerDTO]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiClaimApprovalStatusTrackersCountOfApprovalsPendingForApproverIdGet(_id: Int, completion: @escaping ((_ data: Int?,_ error: Error?) -> Void)) {
        apiClaimApprovalStatusTrackersCountOfApprovalsPendingForApproverIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/ClaimApprovalStatusTrackers/CountOfApprovalsPendingForApprover/{id}
     - 

     - examples: [{contentType=application/json, example=0}]
     - parameter _id: (path)  

     - returns: RequestBuilder<Int> 
     */
    open class func apiClaimApprovalStatusTrackersCountOfApprovalsPendingForApproverIdGetWithRequestBuilder(_id: Int) -> RequestBuilder<Int> {
        var path = "/api/ClaimApprovalStatusTrackers/CountOfApprovalsPendingForApprover/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
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
    open class func apiClaimApprovalStatusTrackersDeleteClaimApprovalStatusTrackerIdDelete(_id: Int, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        apiClaimApprovalStatusTrackersDeleteClaimApprovalStatusTrackerIdDeleteWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     - DELETE /api/ClaimApprovalStatusTrackers/DeleteClaimApprovalStatusTracker/{id}
     - 

     - parameter _id: (path)  

     - returns: RequestBuilder<Void> 
     */
    open class func apiClaimApprovalStatusTrackersDeleteClaimApprovalStatusTrackerIdDeleteWithRequestBuilder(_id: Int) -> RequestBuilder<Void> {
        var path = "/api/ClaimApprovalStatusTrackers/DeleteClaimApprovalStatusTracker/{id}"
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
    open class func apiClaimApprovalStatusTrackersGetClaimApprovalStatusTrackerIdGet(_id: Int, completion: @escaping ((_ data: ClaimApprovalStatusTrackerDTO?,_ error: Error?) -> Void)) {
        apiClaimApprovalStatusTrackersGetClaimApprovalStatusTrackerIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/ClaimApprovalStatusTrackers/GetClaimApprovalStatusTracker/{id}
     - 

     - examples: [{contentType=application/json, example={
  "departmentName" : "departmentName",
  "finalApprovedDate" : "2000-01-23T04:56:07.000+00:00",
  "employeeName" : "employeeName",
  "subProjectName" : "subProjectName",
  "comments" : "comments",
  "workTaskId" : 7,
  "workTask" : "workTask",
  "roleId" : 3,
  "departmentId" : 5,
  "employeeId" : 6,
  "approvalStatusTypeId" : 4,
  "approvalLevelId" : 2,
  "reqDate" : "2000-01-23T04:56:07.000+00:00",
  "approvalGroupId" : 9,
  "pettyCashRequestId" : 1,
  "subProjectId" : 2,
  "jobRole" : "jobRole",
  "id" : 0,
  "projectName" : "projectName",
  "approvalStatusType" : "approvalStatusType",
  "projectId" : 5
}}]
     - parameter _id: (path)  

     - returns: RequestBuilder<ClaimApprovalStatusTrackerDTO> 
     */
    open class func apiClaimApprovalStatusTrackersGetClaimApprovalStatusTrackerIdGetWithRequestBuilder(_id: Int) -> RequestBuilder<ClaimApprovalStatusTrackerDTO> {
        var path = "/api/ClaimApprovalStatusTrackers/GetClaimApprovalStatusTracker/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<ClaimApprovalStatusTrackerDTO>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiClaimApprovalStatusTrackersGetClaimApprovalStatusTrackersGet(completion: @escaping ((_ data: [ClaimApprovalStatusTrackerDTO]?,_ error: Error?) -> Void)) {
        apiClaimApprovalStatusTrackersGetClaimApprovalStatusTrackersGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/ClaimApprovalStatusTrackers/GetClaimApprovalStatusTrackers
     - 

     - examples: [{contentType=application/json, example=[ {
  "departmentName" : "departmentName",
  "finalApprovedDate" : "2000-01-23T04:56:07.000+00:00",
  "employeeName" : "employeeName",
  "subProjectName" : "subProjectName",
  "comments" : "comments",
  "workTaskId" : 7,
  "workTask" : "workTask",
  "roleId" : 3,
  "departmentId" : 5,
  "employeeId" : 6,
  "approvalStatusTypeId" : 4,
  "approvalLevelId" : 2,
  "reqDate" : "2000-01-23T04:56:07.000+00:00",
  "approvalGroupId" : 9,
  "pettyCashRequestId" : 1,
  "subProjectId" : 2,
  "jobRole" : "jobRole",
  "id" : 0,
  "projectName" : "projectName",
  "approvalStatusType" : "approvalStatusType",
  "projectId" : 5
}, {
  "departmentName" : "departmentName",
  "finalApprovedDate" : "2000-01-23T04:56:07.000+00:00",
  "employeeName" : "employeeName",
  "subProjectName" : "subProjectName",
  "comments" : "comments",
  "workTaskId" : 7,
  "workTask" : "workTask",
  "roleId" : 3,
  "departmentId" : 5,
  "employeeId" : 6,
  "approvalStatusTypeId" : 4,
  "approvalLevelId" : 2,
  "reqDate" : "2000-01-23T04:56:07.000+00:00",
  "approvalGroupId" : 9,
  "pettyCashRequestId" : 1,
  "subProjectId" : 2,
  "jobRole" : "jobRole",
  "id" : 0,
  "projectName" : "projectName",
  "approvalStatusType" : "approvalStatusType",
  "projectId" : 5
} ]}]

     - returns: RequestBuilder<[ClaimApprovalStatusTrackerDTO]> 
     */
    open class func apiClaimApprovalStatusTrackersGetClaimApprovalStatusTrackersGetWithRequestBuilder() -> RequestBuilder<[ClaimApprovalStatusTrackerDTO]> {
        let path = "/api/ClaimApprovalStatusTrackers/GetClaimApprovalStatusTrackers"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[ClaimApprovalStatusTrackerDTO]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiClaimApprovalStatusTrackersPostClaimApprovalStatusTrackerPost(body: ClaimApprovalStatusTrackerDTO? = nil, completion: @escaping ((_ data: ClaimApprovalStatusTracker?,_ error: Error?) -> Void)) {
        apiClaimApprovalStatusTrackersPostClaimApprovalStatusTrackerPostWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - POST /api/ClaimApprovalStatusTrackers/PostClaimApprovalStatusTracker
     - 

     - examples: [{contentType=application/json, example={
  "finalApprovedDate" : "2000-01-23T04:56:07.000+00:00",
  "workTaskId" : 0,
  "departmentId" : 7,
  "approvalStatusTypeId" : 3,
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
  "approvalLevelId" : 7,
  "reqDate" : "2000-01-23T04:56:07.000+00:00",
  "id" : 0,
  "comments" : "comments",
  "roleId" : 8,
  "employeeId" : 1,
  "approvalGroupId" : 4,
  "pettyCashRequestId" : 3,
  "subProjectId" : 6,
  "approvalLevel" : {
    "level" : 6,
    "levelDesc" : "levelDesc",
    "id" : 0
  },
  "pettyCashRequest" : {
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
  },
  "projManagerId" : 0,
  "projectId" : 7
}}]
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<ClaimApprovalStatusTracker> 
     */
    open class func apiClaimApprovalStatusTrackersPostClaimApprovalStatusTrackerPostWithRequestBuilder(body: ClaimApprovalStatusTrackerDTO? = nil) -> RequestBuilder<ClaimApprovalStatusTracker> {
        let path = "/api/ClaimApprovalStatusTrackers/PostClaimApprovalStatusTracker"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<ClaimApprovalStatusTracker>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
    /**

     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiClaimApprovalStatusTrackersPutClaimApprovalStatusTrackerPut(body: [ClaimApprovalStatusTrackerDTO]? = nil, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        apiClaimApprovalStatusTrackersPutClaimApprovalStatusTrackerPutWithRequestBuilder(body: body).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     - PUT /api/ClaimApprovalStatusTrackers/PutClaimApprovalStatusTracker
     - 

     - parameter body: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func apiClaimApprovalStatusTrackersPutClaimApprovalStatusTrackerPutWithRequestBuilder(body: [ClaimApprovalStatusTrackerDTO]? = nil) -> RequestBuilder<Void> {
        let path = "/api/ClaimApprovalStatusTrackers/PutClaimApprovalStatusTracker"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
}