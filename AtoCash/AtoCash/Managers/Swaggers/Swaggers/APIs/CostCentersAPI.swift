//
// CostCentersAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class CostCentersAPI {
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiCostCentersCostCentersForDropdownGet(completion: @escaping ((_ data: [CostCenterVM]?,_ error: Error?) -> Void)) {
        apiCostCentersCostCentersForDropdownGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/CostCenters/CostCentersForDropdown
     - 

     - examples: [{contentType=application/json, example=[ {
  "costCenterCode" : "costCenterCode",
  "id" : 0
}, {
  "costCenterCode" : "costCenterCode",
  "id" : 0
} ]}]

     - returns: RequestBuilder<[CostCenterVM]> 
     */
    open class func apiCostCentersCostCentersForDropdownGetWithRequestBuilder() -> RequestBuilder<[CostCenterVM]> {
        let path = "/api/CostCenters/CostCentersForDropdown"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[CostCenterVM]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiCostCentersDeleteCostCenterIdDelete(_id: Int, completion: @escaping ((_ data: SuccessModel?,_ error: Error?) -> Void)) {
        apiCostCentersDeleteCostCenterIdDeleteWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            if error == nil {
                completion((response?.body), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     - DELETE /api/CostCenters/DeleteCostCenter/{id}
     - 

     - parameter _id: (path)  

     - returns: RequestBuilder<Void> 
     */
    open class func apiCostCentersDeleteCostCenterIdDeleteWithRequestBuilder(_id: Int) -> RequestBuilder<SuccessModel> {
        var path = "/api/CostCenters/DeleteCostCenter/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<SuccessModel>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiCostCentersGetCostCenterIdGet(_id: Int, completion: @escaping ((_ data: CostCenterDTO?,_ error: Error?) -> Void)) {
        apiCostCentersGetCostCenterIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/CostCenters/GetCostCenter/{id}
     - 

     - examples: [{contentType=application/json, example={
  "costCenterCode" : "costCenterCode",
  "statusType" : "statusType",
  "statusTypeId" : 6,
  "id" : 0,
  "costCenterDesc" : "costCenterDesc"
}}]
     - parameter _id: (path)  

     - returns: RequestBuilder<CostCenterDTO> 
     */
    open class func apiCostCentersGetCostCenterIdGetWithRequestBuilder(_id: Int) -> RequestBuilder<CostCenterDTO> {
        var path = "/api/CostCenters/GetCostCenter/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<CostCenterDTO>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiCostCentersGetCostCentersGet(completion: @escaping ((_ data: [CostCenterDTO]?,_ error: Error?) -> Void)) {
        apiCostCentersGetCostCentersGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/CostCenters/GetCostCenters
     - 

     - examples: [{contentType=application/json, example=[ {
  "costCenterCode" : "costCenterCode",
  "statusType" : "statusType",
  "statusTypeId" : 6,
  "id" : 0,
  "costCenterDesc" : "costCenterDesc"
}, {
  "costCenterCode" : "costCenterCode",
  "statusType" : "statusType",
  "statusTypeId" : 6,
  "id" : 0,
  "costCenterDesc" : "costCenterDesc"
} ]}]

     - returns: RequestBuilder<[CostCenterDTO]> 
     */
    open class func apiCostCentersGetCostCentersGetWithRequestBuilder() -> RequestBuilder<[CostCenterDTO]> {
        let path = "/api/CostCenters/GetCostCenters"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[CostCenterDTO]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiCostCentersPostCostCenterPost(body: CostCenterDTO? = nil, completion: @escaping ((_ data: SuccessModel?,_ error: Error?) -> Void)) {
        apiCostCentersPostCostCenterPostWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - POST /api/CostCenters/PostCostCenter
     - 

     - examples: [{contentType=application/json, example={
  "costCenterCode" : "costCenterCode",
  "statusType" : {
    "id" : 7,
    "status" : "status"
  },
  "statusTypeId" : 9,
  "id" : 2,
  "costCenterDesc" : "costCenterDesc"
}}]
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<CostCenter> 
     */
    open class func apiCostCentersPostCostCenterPostWithRequestBuilder(body: CostCenterDTO? = nil) -> RequestBuilder<SuccessModel> {
        let path = "/api/CostCenters/PostCostCenter"
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
    open class func apiCostCentersPutCostCenterIdPut(_id: Int, body: CostCenterDTO? = nil, completion: @escaping ((_ data: SuccessModel?,_ error: Error?) -> Void)) {
        apiCostCentersPutCostCenterIdPutWithRequestBuilder(_id: _id, body: body).execute { (response, error) -> Void in
            if error == nil {
                completion((response?.body), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     - PUT /api/CostCenters/PutCostCenter/{id}
     - 

     - parameter _id: (path)  
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func apiCostCentersPutCostCenterIdPutWithRequestBuilder(_id: Int, body: CostCenterDTO? = nil) -> RequestBuilder<SuccessModel> {
        var path = "/api/CostCenters/PutCostCenter/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<SuccessModel>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
}