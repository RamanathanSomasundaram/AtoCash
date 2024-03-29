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

    open class func apiExpenseIsBusinessDropDownGet(_isBusiness: Bool, completion: @escaping ((_ data: [ExpenseBusinessDTO]?,_ error: Error?) -> Void)) {
        apiExpenseIsBusinessGetWithRequestBuilder(_isBusiness: _isBusiness).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }
        open class func apiExpenseIsBusinessGetWithRequestBuilder(_isBusiness: Bool) -> RequestBuilder<[ExpenseBusinessDTO]> {
            var path = "/api/ExpenseCategories/GetSelectedExpenseCategoriesForDropdown"
//            let _idPreEscape = "\(_isBusiness)"
//            let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
//            path = path.replacingOccurrences(of: "{isBusiness}", with: _idPostEscape, options: .literal, range: nil)
            let URLString = SwaggerClientAPI.basePath + path
            let parameters: [String:Any]? = nil
            let url = URLComponents(string: URLString)


            let requestBuilder: RequestBuilder<[ExpenseBusinessDTO]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

            return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
        }
    
    open class func apiExpenseVendorDropDownGet(completion: @escaping ((_ data: [ExpenseVendorDTO]?,_ error: Error?) -> Void)) {
        apiExpenseVendorGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }
        open class func apiExpenseVendorGetWithRequestBuilder() -> RequestBuilder<[ExpenseVendorDTO]> {
            var path = "/api/Vendors/VendorsForDropdown"
//            let _idPreEscape = "\(_isBusiness)"
//            let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
//            path = path.replacingOccurrences(of: "{isBusiness}", with: _idPostEscape, options: .literal, range: nil)
            let URLString = SwaggerClientAPI.basePath + path
            let parameters: [String:Any]? = nil
            let url = URLComponents(string: URLString)


            let requestBuilder: RequestBuilder<[ExpenseVendorDTO]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

            return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
        }
    //https://fwserver.atocash.com/api/ExpenseTypes/ExpenseTypesForExpenseCategoryId/103
    //[{id: 1018, expenseTypeName: "LOCAL PURCHASES CASH VENDOR:LOCAL PURCHASES CASH VENDOR"}]
    open class func apiExpenseIsBusinessCategoryDropDownGet(_id: Int, completion: @escaping ((_ data: [ExpenseBusinessCategoryDTO]?,_ error: Error?) -> Void)) {
        apiExpenseIsBusinessCategoryGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }
    open class func apiExpenseIsBusinessCategoryGetWithRequestBuilder(_id: Int) -> RequestBuilder<[ExpenseBusinessCategoryDTO]> {
            var path = "/api/ExpenseTypes/ExpenseTypesForExpenseCategoryId/{id}"
            let _idPreEscape = "\(_id)"
            let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
            path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
            let URLString = SwaggerClientAPI.basePath + path
            let parameters: [String:Any]? = nil
            let url = URLComponents(string: URLString)


            let requestBuilder: RequestBuilder<[ExpenseBusinessCategoryDTO]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

            return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
        }
    //https://fwserver.atocash.com/api/VATRate/GetVATPercentage/
    //{id: 1, vatPercentage: 15}
    
    open class func apiExpenseIsVATDropDownGet(_id: Int, completion: @escaping ((_ data: ExpenseVATDTO?,_ error: Error?) -> Void)) {
        apiExpenseIsVATGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }
        open class func apiExpenseIsVATGetWithRequestBuilder(_id: Int) -> RequestBuilder<ExpenseVATDTO> {
            var path = "/api/VATRate/GetVATPercentage"
            let URLString = SwaggerClientAPI.basePath + path
            let parameters: [String:Any]? = nil
            let url = URLComponents(string: URLString)


            let requestBuilder: RequestBuilder<ExpenseVATDTO>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

            return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
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

    //https://fwserver.atocash.com/api/ExpenseReimburseRequests/PostExpenseReimburseRequest
    
    /*
     {"expenseReportTitle":"vgfvgvgv","projectId":null,"subProjectId":null,"workTaskId":null,"expensefor":"Business Area","employeeId":"10004","currencyTypeId":1,"isBusinessAreaReq":true,"expenseSubClaims":[{"expenseCategoryId":101,"invoiceNo":"1234","invoiceDate":"2022-12-10T20:00:01.166Z","expenseTypeId":1001,"expenseReimbClaimAmount":100,"location":"Madurai","vendor":"taj","description":"Madurai","taxNo":"12345","NoOfDaysDate":["2022-11-08T20:00:16.953Z","2022-12-08T20:00:16.953Z"],"isVAT":true,"tax":15,"taxAmount":15,"expStrtDate":"2022-11-08T20:00:16.953Z","expEndDate":"2022-12-08T20:00:16.953Z","expNoOfDays":31,"documentIds":"45"}]}
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

    /*
     {"expenseReportTitle":"vgfvgvgv","projectId":null,"subProjectId":null,"workTaskId":null,"expensefor":"Business Area","employeeId":"10004","currencyTypeId":1,"isBusinessAreaReq":true,"expenseSubClaims":[{"expenseCategoryId":101,"invoiceNo":"1234","invoiceDate":"2022-12-10T20:00:01.166Z","expenseTypeId":1001,"expenseReimbClaimAmount":100,"location":"Madurai","vendor":"taj","description":"Madurai","taxNo":"12345","NoOfDaysDate":["2022-11-08T20:00:16.953Z","2022-12-08T20:00:16.953Z"],"isVAT":true,"tax":15,"taxAmount":15,"expStrtDate":"2022-11-08T20:00:16.953Z","expEndDate":"2022-12-08T20:00:16.953Z","expNoOfDays":31,"documentIds":"45"}]}
     */
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
    "comments" : "comments",
    "workTask" : {
      "taskDesc" : "taskDesc",
      "subProjectId" : 5,
      "taskName" : "taskName",
      "id" : 6
    },
    "workTaskId" : 2,
    "departmentId" : 7,
    "totalClaimAmount" : 2.3021358869347655,
    "project" : {
      "costCenterId" : 9,
      "statusTypeId" : 3,
      "projectManagerId" : 6,
      "projectDesc" : "projectDesc",
      "id" : 8,
      "projectName" : "projectName"
    },
    "expenseReportTitle" : "expenseReportTitle",
    "employeeId" : 5,
    "approvalStatusTypeId" : 4,
    "currencyTypeId" : 5,
    "approvedDate" : "2000-01-23T04:56:07.000+00:00",
    "subProjectId" : 3,
    "expReimReqDate" : "2000-01-23T04:56:07.000+00:00",
    "subProject" : {
      "subProjectName" : "subProjectName",
      "subProjectDesc" : "subProjectDesc",
      "id" : 1,
      "projectId" : 2
    },
    "id" : 1,
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
    "projectId" : 9
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
    "comments" : "comments",
    "workTask" : {
      "taskDesc" : "taskDesc",
      "subProjectId" : 5,
      "taskName" : "taskName",
      "id" : 6
    },
    "workTaskId" : 2,
    "departmentId" : 7,
    "totalClaimAmount" : 2.3021358869347655,
    "project" : {
      "costCenterId" : 9,
      "statusTypeId" : 3,
      "projectManagerId" : 6,
      "projectDesc" : "projectDesc",
      "id" : 8,
      "projectName" : "projectName"
    },
    "expenseReportTitle" : "expenseReportTitle",
    "employeeId" : 5,
    "approvalStatusTypeId" : 4,
    "currencyTypeId" : 5,
    "approvedDate" : "2000-01-23T04:56:07.000+00:00",
    "subProjectId" : 3,
    "expReimReqDate" : "2000-01-23T04:56:07.000+00:00",
    "subProject" : {
      "subProjectName" : "subProjectName",
      "subProjectDesc" : "subProjectDesc",
      "id" : 1,
      "projectId" : 2
    },
    "id" : 1,
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
    "projectId" : 9
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
     /*
      {"expenseReportTitle":"vgfvgvgv","projectId":null,"subProjectId":null,"workTaskId":null,"expensefor":"Business Area","employeeId":"10004","currencyTypeId":1,"isBusinessAreaReq":true,"expenseSubClaims":[{"expenseCategoryId":101,"invoiceNo":"1234","invoiceDate":"2022-12-10T20:00:01.166Z","expenseTypeId":1001,"expenseReimbClaimAmount":100,"location":"Madurai","vendor":"taj","description":"Madurai","taxNo":"12345","NoOfDaysDate":["2022-11-08T20:00:16.953Z","2022-12-08T20:00:16.953Z"],"isVAT":true,"tax":15,"taxAmount":15,"expStrtDate":"2022-11-08T20:00:16.953Z","expEndDate":"2022-12-08T20:00:16.953Z","expNoOfDays":31,"documentIds":"45"}]}
      */
     - examples: [{contentType=application/json, example={
  "expenseReimburseRequest" : {
    "currencyType" : {
      "country" : "country",
      "currencyName" : "currencyName",
      "statusTypeId" : 1,
      "id" : 1,
      "currencyCode" : "currencyCode"
    },
    "comments" : "comments",
    "workTask" : {
      "taskDesc" : "taskDesc",
      "subProjectId" : 5,
      "taskName" : "taskName",
      "id" : 6
    },
    "workTaskId" : 2,
    "departmentId" : 7,
    "totalClaimAmount" : 2.3021358869347655,
    "project" : {
      "costCenterId" : 9,
      "statusTypeId" : 3,
      "projectManagerId" : 6,
      "projectDesc" : "projectDesc",
      "id" : 8,
      "projectName" : "projectName"
    },
    "expenseReportTitle" : "expenseReportTitle",
    "employeeId" : 5,
    "approvalStatusTypeId" : 4,
    "currencyTypeId" : 5,
    "approvedDate" : "2000-01-23T04:56:07.000+00:00",
    "subProjectId" : 3,
    "expReimReqDate" : "2000-01-23T04:56:07.000+00:00",
    "subProject" : {
      "subProjectName" : "subProjectName",
      "subProjectDesc" : "subProjectDesc",
      "id" : 1,
      "projectId" : 2
    },
    "id" : 1,
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
    "projectId" : 9
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
