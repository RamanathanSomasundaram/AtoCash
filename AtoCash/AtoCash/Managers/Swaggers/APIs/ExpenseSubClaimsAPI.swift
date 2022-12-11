//
// ExpenseSubClaimsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class ExpenseSubClaimsAPI {
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiExpenseSubClaimsDeleteExpenseSubClaimIdDelete(_id: Int, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        apiExpenseSubClaimsDeleteExpenseSubClaimIdDeleteWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     - DELETE /api/ExpenseSubClaims/DeleteExpenseSubClaim/{id}
     - 

     - parameter _id: (path)  

     - returns: RequestBuilder<Void> 
     */
    open class func apiExpenseSubClaimsDeleteExpenseSubClaimIdDeleteWithRequestBuilder(_id: Int) -> RequestBuilder<Void> {
        var path = "/api/ExpenseSubClaims/DeleteExpenseSubClaim/{id}"
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
    open class func apiExpenseSubClaimsGetExpenseSubClaimIdGet(_id: Int, completion: @escaping ((_ data: ExpenseSubClaimDTO?,_ error: Error?) -> Void)) {
        apiExpenseSubClaimsGetExpenseSubClaimIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/ExpenseSubClaims/GetExpenseSubClaim/{id}
     - 

     - examples: [{contentType=application/json, example={
  "currencyType" : "currencyType",
  "workTaskId" : 5,
  "departmentId" : 7,
  "description" : "description",
  "project" : "project",
  "approvalStatusTypeId" : 9,
  "documentIDs" : "documentIDs",
  "vendor" : "vendor",
  "id" : 2,
  "invoiceNo" : "invoiceNo",
  "department" : "department",
  "expenseReimbClaimAmount" : 7.386281948385884,
  "employeeName" : "employeeName",
  "expenseType" : "expenseType",
  "workTask" : "workTask",
  "employeeId" : 4,
  "tax" : 1.2315135,
  "invoiceDate" : "2000-01-23T04:56:07.000+00:00",
  "currencyTypeId" : 1,
  "approvedDate" : "2000-01-23T04:56:07.000+00:00",
  "subProjectId" : 4,
  "expReimReqDate" : "2000-01-23T04:56:07.000+00:00",
  "subProject" : "subProject",
  "location" : "location",
  "expenseTypeId" : 6,
  "taxAmount" : 1.0246457001441578,
  "approvalStatusType" : "approvalStatusType",
  "projectId" : 1
}}]
     - parameter _id: (path)  

     - returns: RequestBuilder<ExpenseSubClaimDTO> 
     */
    open class func apiExpenseSubClaimsGetExpenseSubClaimIdGetWithRequestBuilder(_id: Int) -> RequestBuilder<ExpenseSubClaimDTO> {
        var path = "/api/ExpenseSubClaims/GetExpenseSubClaim/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<ExpenseSubClaimDTO>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiExpenseSubClaimsGetExpenseSubClaimsByExpenseIdIdGet(_id: Int, completion: @escaping ((_ data: [ExpenseSubClaimDTO]?,_ error: Error?) -> Void)) {
        apiExpenseSubClaimsGetExpenseSubClaimsByExpenseIdIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/ExpenseSubClaims/GetExpenseSubClaimsByExpenseId/{id}
     - 

     - examples: [{contentType=application/json, example=[ {
  "currencyType" : "currencyType",
  "workTaskId" : 5,
  "departmentId" : 7,
  "description" : "description",
  "project" : "project",
  "approvalStatusTypeId" : 9,
  "documentIDs" : "documentIDs",
  "vendor" : "vendor",
  "id" : 2,
  "invoiceNo" : "invoiceNo",
  "department" : "department",
  "expenseReimbClaimAmount" : 7.386281948385884,
  "employeeName" : "employeeName",
  "expenseType" : "expenseType",
  "workTask" : "workTask",
  "employeeId" : 4,
  "tax" : 1.2315135,
  "invoiceDate" : "2000-01-23T04:56:07.000+00:00",
  "currencyTypeId" : 1,
  "approvedDate" : "2000-01-23T04:56:07.000+00:00",
  "subProjectId" : 4,
  "expReimReqDate" : "2000-01-23T04:56:07.000+00:00",
  "subProject" : "subProject",
  "location" : "location",
  "expenseTypeId" : 6,
  "taxAmount" : 1.0246457001441578,
  "approvalStatusType" : "approvalStatusType",
  "projectId" : 1
}, {
  "currencyType" : "currencyType",
  "workTaskId" : 5,
  "departmentId" : 7,
  "description" : "description",
  "project" : "project",
  "approvalStatusTypeId" : 9,
  "documentIDs" : "documentIDs",
  "vendor" : "vendor",
  "id" : 2,
  "invoiceNo" : "invoiceNo",
  "department" : "department",
  "expenseReimbClaimAmount" : 7.386281948385884,
  "employeeName" : "employeeName",
  "expenseType" : "expenseType",
  "workTask" : "workTask",
  "employeeId" : 4,
  "tax" : 1.2315135,
  "invoiceDate" : "2000-01-23T04:56:07.000+00:00",
  "currencyTypeId" : 1,
  "approvedDate" : "2000-01-23T04:56:07.000+00:00",
  "subProjectId" : 4,
  "expReimReqDate" : "2000-01-23T04:56:07.000+00:00",
  "subProject" : "subProject",
  "location" : "location",
  "expenseTypeId" : 6,
  "taxAmount" : 1.0246457001441578,
  "approvalStatusType" : "approvalStatusType",
  "projectId" : 1
} ]}]
     - parameter _id: (path)  

     - returns: RequestBuilder<[ExpenseSubClaimDTO]> 
     */
    open class func apiExpenseSubClaimsGetExpenseSubClaimsByExpenseIdIdGetWithRequestBuilder(_id: Int) -> RequestBuilder<[ExpenseSubClaimDTO]> {
        var path = "/api/ExpenseSubClaims/GetExpenseSubClaimsByExpenseId/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[ExpenseSubClaimDTO]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiExpenseSubClaimsGetExpenseSubClaimsGet(completion: @escaping ((_ data: [ExpenseSubClaim]?,_ error: Error?) -> Void)) {
        apiExpenseSubClaimsGetExpenseSubClaimsGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/ExpenseSubClaims/GetExpenseSubClaims
     - 

     - examples: [{contentType=application/json, example=[ {
  "expenseReimburseRequest" : {
    "currencyType" : {
      "country" : "country",
      "currencyName" : "currencyName",
      "statusTypeId" : 1,
      "id" : 1,
      "currencyCode" : "currencyCode"
    },
    "workTask" : {
      "taskDesc" : "taskDesc",
      "subProjectId" : 5,
      "taskName" : "taskName",
      "id" : 6
    },
    "workTaskId" : 4,
    "departmentId" : 9,
    "totalClaimAmount" : 7.061401241503109,
    "project" : {
      "statusTypeId" : 3,
      "projectManagerId" : 6,
      "projectDesc" : "projectDesc",
      "id" : 8,
      "projectName" : "projectName",
      "costCentreId" : 9
    },
    "expenseReportTitle" : "expenseReportTitle",
    "employeeId" : 5,
    "approvalStatusTypeId" : 7,
    "currencyTypeId" : 2,
    "approvedDate" : "2000-01-23T04:56:07.000+00:00",
    "subProjectId" : 2,
    "expReimReqDate" : "2000-01-23T04:56:07.000+00:00",
    "subProject" : {
      "subProjectName" : "subProjectName",
      "subProjectDesc" : "subProjectDesc",
      "id" : 1,
      "projectId" : 2
    },
    "id" : 5,
    "department" : {
      "deptName" : "deptName",
      "statusTypeId" : 2,
      "id" : 5,
      "costCentre" : {
        "costCentreCode" : "costCentreCode",
        "statusType" : {
          "id" : 7,
          "status" : "status"
        },
        "statusTypeId" : 9,
        "id" : 2,
        "costCentreDesc" : "costCentreDesc"
      },
      "deptCode" : "deptCode",
      "costCentreId" : 3
    },
    "approvalStatusType" : {
      "statusDesc" : "statusDesc",
      "id" : 0,
      "status" : "status"
    },
    "projectId" : 3
  },
  "expenseType" : {
    "statusType" : {
      "id" : 7,
      "status" : "status"
    },
    "expenseTypeDesc" : "expenseTypeDesc",
    "expenseTypeName" : "expenseTypeName",
    "statusTypeId" : 5,
    "id" : 1
  },
  "expenseReimburseRequestId" : 6,
  "description" : "description",
  "tax" : 7.0614014,
  "invoiceDate" : "2000-01-23T04:56:07.000+00:00",
  "documentIDs" : "documentIDs",
  "vendor" : "vendor",
  "expenseTypeId" : 5,
  "location" : "location",
  "id" : 0,
  "invoiceNo" : "invoiceNo",
  "taxAmount" : 9.301444243932576,
  "expenseReimbClaimAmount" : 2.3021358869347655
}, {
  "expenseReimburseRequest" : {
    "currencyType" : {
      "country" : "country",
      "currencyName" : "currencyName",
      "statusTypeId" : 1,
      "id" : 1,
      "currencyCode" : "currencyCode"
    },
    "workTask" : {
      "taskDesc" : "taskDesc",
      "subProjectId" : 5,
      "taskName" : "taskName",
      "id" : 6
    },
    "workTaskId" : 4,
    "departmentId" : 9,
    "totalClaimAmount" : 7.061401241503109,
    "project" : {
      "statusTypeId" : 3,
      "projectManagerId" : 6,
      "projectDesc" : "projectDesc",
      "id" : 8,
      "projectName" : "projectName",
      "costCentreId" : 9
    },
    "expenseReportTitle" : "expenseReportTitle",
    "employeeId" : 5,
    "approvalStatusTypeId" : 7,
    "currencyTypeId" : 2,
    "approvedDate" : "2000-01-23T04:56:07.000+00:00",
    "subProjectId" : 2,
    "expReimReqDate" : "2000-01-23T04:56:07.000+00:00",
    "subProject" : {
      "subProjectName" : "subProjectName",
      "subProjectDesc" : "subProjectDesc",
      "id" : 1,
      "projectId" : 2
    },
    "id" : 5,
    "department" : {
      "deptName" : "deptName",
      "statusTypeId" : 2,
      "id" : 5,
      "costCentre" : {
        "costCentreCode" : "costCentreCode",
        "statusType" : {
          "id" : 7,
          "status" : "status"
        },
        "statusTypeId" : 9,
        "id" : 2,
        "costCentreDesc" : "costCentreDesc"
      },
      "deptCode" : "deptCode",
      "costCentreId" : 3
    },
    "approvalStatusType" : {
      "statusDesc" : "statusDesc",
      "id" : 0,
      "status" : "status"
    },
    "projectId" : 3
  },
  "expenseType" : {
    "statusType" : {
      "id" : 7,
      "status" : "status"
    },
    "expenseTypeDesc" : "expenseTypeDesc",
    "expenseTypeName" : "expenseTypeName",
    "statusTypeId" : 5,
    "id" : 1
  },
  "expenseReimburseRequestId" : 6,
  "description" : "description",
  "tax" : 7.0614014,
  "invoiceDate" : "2000-01-23T04:56:07.000+00:00",
  "documentIDs" : "documentIDs",
  "vendor" : "vendor",
  "expenseTypeId" : 5,
  "location" : "location",
  "id" : 0,
  "invoiceNo" : "invoiceNo",
  "taxAmount" : 9.301444243932576,
  "expenseReimbClaimAmount" : 2.3021358869347655
} ]}]

     - returns: RequestBuilder<[ExpenseSubClaim]> 
     */
    open class func apiExpenseSubClaimsGetExpenseSubClaimsGetWithRequestBuilder() -> RequestBuilder<[ExpenseSubClaim]> {
        let path = "/api/ExpenseSubClaims/GetExpenseSubClaims"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[ExpenseSubClaim]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiExpenseSubClaimsPostExpenseSubClaimPost(body: ExpenseSubClaim? = nil, completion: @escaping ((_ data: ExpenseSubClaim?,_ error: Error?) -> Void)) {
        apiExpenseSubClaimsPostExpenseSubClaimPostWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - POST /api/ExpenseSubClaims/PostExpenseSubClaim
     - 

     - examples: [{contentType=application/json, example={
  "expenseReimburseRequest" : {
    "currencyType" : {
      "country" : "country",
      "currencyName" : "currencyName",
      "statusTypeId" : 1,
      "id" : 1,
      "currencyCode" : "currencyCode"
    },
    "workTask" : {
      "taskDesc" : "taskDesc",
      "subProjectId" : 5,
      "taskName" : "taskName",
      "id" : 6
    },
    "workTaskId" : 4,
    "departmentId" : 9,
    "totalClaimAmount" : 7.061401241503109,
    "project" : {
      "statusTypeId" : 3,
      "projectManagerId" : 6,
      "projectDesc" : "projectDesc",
      "id" : 8,
      "projectName" : "projectName",
      "costCentreId" : 9
    },
    "expenseReportTitle" : "expenseReportTitle",
    "employeeId" : 5,
    "approvalStatusTypeId" : 7,
    "currencyTypeId" : 2,
    "approvedDate" : "2000-01-23T04:56:07.000+00:00",
    "subProjectId" : 2,
    "expReimReqDate" : "2000-01-23T04:56:07.000+00:00",
    "subProject" : {
      "subProjectName" : "subProjectName",
      "subProjectDesc" : "subProjectDesc",
      "id" : 1,
      "projectId" : 2
    },
    "id" : 5,
    "department" : {
      "deptName" : "deptName",
      "statusTypeId" : 2,
      "id" : 5,
      "costCentre" : {
        "costCentreCode" : "costCentreCode",
        "statusType" : {
          "id" : 7,
          "status" : "status"
        },
        "statusTypeId" : 9,
        "id" : 2,
        "costCentreDesc" : "costCentreDesc"
      },
      "deptCode" : "deptCode",
      "costCentreId" : 3
    },
    "approvalStatusType" : {
      "statusDesc" : "statusDesc",
      "id" : 0,
      "status" : "status"
    },
    "projectId" : 3
  },
  "expenseType" : {
    "statusType" : {
      "id" : 7,
      "status" : "status"
    },
    "expenseTypeDesc" : "expenseTypeDesc",
    "expenseTypeName" : "expenseTypeName",
    "statusTypeId" : 5,
    "id" : 1
  },
  "expenseReimburseRequestId" : 6,
  "description" : "description",
  "tax" : 7.0614014,
  "invoiceDate" : "2000-01-23T04:56:07.000+00:00",
  "documentIDs" : "documentIDs",
  "vendor" : "vendor",
  "expenseTypeId" : 5,
  "location" : "location",
  "id" : 0,
  "invoiceNo" : "invoiceNo",
  "taxAmount" : 9.301444243932576,
  "expenseReimbClaimAmount" : 2.3021358869347655
}}]
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<ExpenseSubClaim> 
     */
    open class func apiExpenseSubClaimsPostExpenseSubClaimPostWithRequestBuilder(body: ExpenseSubClaim? = nil) -> RequestBuilder<ExpenseSubClaim> {
        let path = "/api/ExpenseSubClaims/PostExpenseSubClaim"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<ExpenseSubClaim>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
    /**

     - parameter _id: (path)  
     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiExpenseSubClaimsPutExpenseSubClaimIdPut(_id: Int, body: ExpenseSubClaim? = nil, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        apiExpenseSubClaimsPutExpenseSubClaimIdPutWithRequestBuilder(_id: _id, body: body).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     - PUT /api/ExpenseSubClaims/PutExpenseSubClaim/{id}
     - 

     - parameter _id: (path)  
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func apiExpenseSubClaimsPutExpenseSubClaimIdPutWithRequestBuilder(_id: Int, body: ExpenseSubClaim? = nil) -> RequestBuilder<Void> {
        var path = "/api/ExpenseSubClaims/PutExpenseSubClaim/{id}"
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