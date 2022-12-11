//
// ProjectManagementAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class ProjectManagementAPI {
    /**

     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiProjectManagementAddEmployeesToProjectPost(body: AddEmployeesToProjectId? = nil, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        apiProjectManagementAddEmployeesToProjectPostWithRequestBuilder(body: body).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     - POST /api/ProjectManagement/AddEmployeesToProject
     - 

     - parameter body: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func apiProjectManagementAddEmployeesToProjectPostWithRequestBuilder(body: AddEmployeesToProjectId? = nil) -> RequestBuilder<Void> {
        let path = "/api/ProjectManagement/AddEmployeesToProject"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiProjectManagementDeleteProjectManagementIdDelete(_id: Int, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        apiProjectManagementDeleteProjectManagementIdDeleteWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     - DELETE /api/ProjectManagement/DeleteProjectManagement/{id}
     - 

     - parameter _id: (path)  

     - returns: RequestBuilder<Void> 
     */
    open class func apiProjectManagementDeleteProjectManagementIdDeleteWithRequestBuilder(_id: Int) -> RequestBuilder<Void> {
        var path = "/api/ProjectManagement/DeleteProjectManagement/{id}"
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
    open class func apiProjectManagementGetEmployeesByProjectIdIdGet(_id: Int, completion: @escaping ((_ data: [GetEmployeesForProject]?,_ error: Error?) -> Void)) {
        apiProjectManagementGetEmployeesByProjectIdIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/ProjectManagement/GetEmployeesByProjectId/{id}
     - 

     - examples: [{contentType=application/json, example=[ {
  "employeeName" : "employeeName",
  "isAssigned" : true,
  "employeeId" : 0
}, {
  "employeeName" : "employeeName",
  "isAssigned" : true,
  "employeeId" : 0
} ]}]
     - parameter _id: (path)  

     - returns: RequestBuilder<[GetEmployeesForProject]> 
     */
    open class func apiProjectManagementGetEmployeesByProjectIdIdGetWithRequestBuilder(_id: Int) -> RequestBuilder<[GetEmployeesForProject]> {
        var path = "/api/ProjectManagement/GetEmployeesByProjectId/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[GetEmployeesForProject]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiProjectManagementGetProjectManagementGet(completion: @escaping ((_ data: [ProjectManagementDTO]?,_ error: Error?) -> Void)) {
        apiProjectManagementGetProjectManagementGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/ProjectManagement/GetProjectManagement
     - 

     - examples: [{contentType=application/json, example=[ {
  "employeeName" : "employeeName",
  "employeeId" : 1,
  "id" : 0,
  "projectName" : "projectName",
  "projectId" : 6
}, {
  "employeeName" : "employeeName",
  "employeeId" : 1,
  "id" : 0,
  "projectName" : "projectName",
  "projectId" : 6
} ]}]

     - returns: RequestBuilder<[ProjectManagementDTO]> 
     */
    open class func apiProjectManagementGetProjectManagementGetWithRequestBuilder() -> RequestBuilder<[ProjectManagementDTO]> {
        let path = "/api/ProjectManagement/GetProjectManagement"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[ProjectManagementDTO]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiProjectManagementGetProjectManagementIdGet(_id: Int, completion: @escaping ((_ data: ProjectManagementDTO?,_ error: Error?) -> Void)) {
        apiProjectManagementGetProjectManagementIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/ProjectManagement/GetProjectManagement/{id}
     - 

     - examples: [{contentType=application/json, example={
  "employeeName" : "employeeName",
  "employeeId" : 1,
  "id" : 0,
  "projectName" : "projectName",
  "projectId" : 6
}}]
     - parameter _id: (path)  

     - returns: RequestBuilder<ProjectManagementDTO> 
     */
    open class func apiProjectManagementGetProjectManagementIdGetWithRequestBuilder(_id: Int) -> RequestBuilder<ProjectManagementDTO> {
        var path = "/api/ProjectManagement/GetProjectManagement/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<ProjectManagementDTO>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiProjectManagementGetProjectsByEmployeeIdGet(_id: Int, completion: @escaping ((_ data: [ProjectVM]?,_ error: Error?) -> Void)) {
        apiProjectManagementGetProjectsByEmployeeIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/ProjectManagement/GetProjectsByEmployee/{id}
     - 

     - examples: [{contentType=application/json, example=[ {
  "id" : 0,
  "projectName" : "projectName"
}, {
  "id" : 0,
  "projectName" : "projectName"
} ]}]
     - parameter _id: (path)  

     - returns: RequestBuilder<[ProjectVM]> 
     */
    open class func apiProjectManagementGetProjectsByEmployeeIdGetWithRequestBuilder(_id: Int) -> RequestBuilder<[ProjectVM]> {
        var path = "/api/ProjectManagement/GetProjectsByEmployee/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[ProjectVM]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiProjectManagementPostProjectManagementPost(body: ProjectManagementDTO? = nil, completion: @escaping ((_ data: ProjectManagement?,_ error: Error?) -> Void)) {
        apiProjectManagementPostProjectManagementPostWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - POST /api/ProjectManagement/PostProjectManagement
     - 

     - examples: [{contentType=application/json, example={
  "project" : {
    "costCenterId" : 9,
    "statusTypeId" : 3,
    "projectManagerId" : 6,
    "projectDesc" : "projectDesc",
    "id" : 8,
    "projectName" : "projectName"
  },
  "employeeId" : 1,
  "id" : 0,
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
  "projectId" : 6
}}]
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<ProjectManagement> 
     */
    open class func apiProjectManagementPostProjectManagementPostWithRequestBuilder(body: ProjectManagementDTO? = nil) -> RequestBuilder<ProjectManagement> {
        let path = "/api/ProjectManagement/PostProjectManagement"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<ProjectManagement>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
    /**

     - parameter _id: (path)  
     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiProjectManagementPutProjectManagementIdPut(_id: Int, body: ProjectManagementDTO? = nil, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        apiProjectManagementPutProjectManagementIdPutWithRequestBuilder(_id: _id, body: body).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     - PUT /api/ProjectManagement/PutProjectManagement/{id}
     - 

     - parameter _id: (path)  
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func apiProjectManagementPutProjectManagementIdPutWithRequestBuilder(_id: Int, body: ProjectManagementDTO? = nil) -> RequestBuilder<Void> {
        var path = "/api/ProjectManagement/PutProjectManagement/{id}"
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