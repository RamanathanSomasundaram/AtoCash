//
// RequestsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class RequestsAPI {
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiRequestsDeleteRequestTypeIdDelete(_id: Int, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        apiRequestsDeleteRequestTypeIdDeleteWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     - DELETE /api/Requests/DeleteRequestType/{id}
     - 

     - parameter _id: (path)  

     - returns: RequestBuilder<Void> 
     */
    open class func apiRequestsDeleteRequestTypeIdDeleteWithRequestBuilder(_id: Int) -> RequestBuilder<Void> {
        var path = "/api/Requests/DeleteRequestType/{id}"
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
    open class func apiRequestsGetRequestTypeIdGet(_id: Int, completion: @escaping ((_ data: RequestType?,_ error: Error?) -> Void)) {
        apiRequestsGetRequestTypeIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/Requests/GetRequestType/{id}
     - 

     - examples: [{contentType=application/json, example={
  "requestName" : "requestName",
  "requestTypeDesc" : "requestTypeDesc",
  "id" : 0
}}]
     - parameter _id: (path)  

     - returns: RequestBuilder<RequestType> 
     */
    open class func apiRequestsGetRequestTypeIdGetWithRequestBuilder(_id: Int) -> RequestBuilder<RequestType> {
        var path = "/api/Requests/GetRequestType/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<RequestType>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiRequestsGetRequestTypesGet(completion: @escaping ((_ data: [RequestType]?,_ error: Error?) -> Void)) {
        apiRequestsGetRequestTypesGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/Requests/GetRequestTypes
     - 

     - examples: [{contentType=application/json, example=[ {
  "requestName" : "requestName",
  "requestTypeDesc" : "requestTypeDesc",
  "id" : 0
}, {
  "requestName" : "requestName",
  "requestTypeDesc" : "requestTypeDesc",
  "id" : 0
} ]}]

     - returns: RequestBuilder<[RequestType]> 
     */
    open class func apiRequestsGetRequestTypesGetWithRequestBuilder() -> RequestBuilder<[RequestType]> {
        let path = "/api/Requests/GetRequestTypes"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[RequestType]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiRequestsPostRequestTypePost(body: RequestType? = nil, completion: @escaping ((_ data: RequestType?,_ error: Error?) -> Void)) {
        apiRequestsPostRequestTypePostWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - POST /api/Requests/PostRequestType
     - 

     - examples: [{contentType=application/json, example={
  "requestName" : "requestName",
  "requestTypeDesc" : "requestTypeDesc",
  "id" : 0
}}]
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<RequestType> 
     */
    open class func apiRequestsPostRequestTypePostWithRequestBuilder(body: RequestType? = nil) -> RequestBuilder<RequestType> {
        let path = "/api/Requests/PostRequestType"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<RequestType>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
    /**

     - parameter _id: (path)  
     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiRequestsPutRequestTypeIdPut(_id: Int, body: RequestType? = nil, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        apiRequestsPutRequestTypeIdPutWithRequestBuilder(_id: _id, body: body).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     - PUT /api/Requests/PutRequestType/{id}
     - 

     - parameter _id: (path)  
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func apiRequestsPutRequestTypeIdPutWithRequestBuilder(_id: Int, body: RequestType? = nil) -> RequestBuilder<Void> {
        var path = "/api/Requests/PutRequestType/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiRequestsRequestTypesForDropdownGet(completion: @escaping ((_ data: [RequestTypeVM]?,_ error: Error?) -> Void)) {
        apiRequestsRequestTypesForDropdownGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /api/Requests/RequestTypesForDropdown
     - 

     - examples: [{contentType=application/json, example=[ {
  "requestName" : "requestName",
  "id" : 0
}, {
  "requestName" : "requestName",
  "id" : 0
} ]}]

     - returns: RequestBuilder<[RequestTypeVM]> 
     */
    open class func apiRequestsRequestTypesForDropdownGetWithRequestBuilder() -> RequestBuilder<[RequestTypeVM]> {
        let path = "/api/Requests/RequestTypesForDropdown"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[RequestTypeVM]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
}
