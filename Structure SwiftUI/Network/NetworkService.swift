//
//  NetworkService.swift
//
//  Created by Aakif Nadeem
//

import UIKit
import Foundation

class NetworkService: NSObject, URLSessionDelegate
{
    static var shared = NetworkService()
    private var baseURL = AppConstants.baseURL
    private var username: String = ""
    private var password: String = ""
    
    func setCredentials(deviceID: String, token: String) {
        self.username = deviceID
        self.password = token
    }

    
    //MARK: Api Calling
    func apiRequest<T: Codable>(_ endpoint: APIEndPoints,
                                requestType: HTTPMethods,
                                params: [String: Any] = [:],
                                appendUrl: String = "",
                                queryParams: [String: Any] = [:],
                                responseModel: APIResponse<T>.Type,
                                contentType: ContentType = .APPLICATIONJSON,
                                sessionID: String = "")
    async -> Result<APIResponse<T>, NetworkError> {
        
        let path = appendUrl == "" ? endpoint.path() : endpoint.path() + appendUrl
        let baseUrl: URL = baseURL.appendingPathComponent(path)
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        urlComponents?.setQueryItems(with: queryParams)
        
        guard let url = urlComponents?.url else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        if let token = LocalHandler.shared.getAccessToken() {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        else {
            let authString = "\(username):\(password)"
            let authData = authString.data(using: .utf8)
            let base64String = authData?.base64EncodedString(options: [])
            if let base64String = base64String {
                request.addValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
            }
        }
        
        request.addValue(contentType.data, forHTTPHeaderField: "Content-Type")
        request.addValue(sessionID, forHTTPHeaderField: "X-Session-ID")
        
        if !(params.isEmpty) {
            do {
                try request.httpBody = JSONSerialization.data(withJSONObject: params)
            }
            catch {
                return .failure(.invalidParams)
            }
        }
        
        do {
            print("\nRequestURL: \(url)")
            print("RequestType: \(requestType)")
            print("Authorization: \(LocalHandler.shared.getAccessToken() ?? "-")")
            print("RequestParams: \(params)")
            
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            return performDataTask(data: data, response: response, responseModel: responseModel)
            
        } catch {
            return .failure(.noResponse)
        }
    }
    
    //MARK: Media Api Calling
    func apiRequestUploadMedia<T: Codable>(_ endpoint: APIEndPoints,
                                           requestType: HTTPMethods,
                                           params: [String: Any] = [:],
                                           queryParams: [String: Any] = [:],
                                           responseModel: APIResponse<T>.Type,
                                           mediaData: [Media]) async -> Result<APIResponse<T>, NetworkError> {
        
        let baseUrl: URL = baseURL.appendingPathComponent(endpoint.path())
        let boundary = UUID().uuidString
        
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        urlComponents?.setQueryItems(with: queryParams)
        
        guard let url = urlComponents?.url else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        
        if let token = LocalHandler.shared.getAccessToken() {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = requestType.rawValue
        request.addValue(ContentType.MULTIFORMDATA(boundary).data, forHTTPHeaderField: "Content-Type")
        
        let dataBody = createDataBody(withParameters: params, media: mediaData, boundary: boundary)
        request.httpBody = dataBody
        
        do {
            print("\nRequestURL: \(url)")
            print("RequestType: \(requestType)")
            print("Authorization: \(LocalHandler.shared.getAccessToken() ?? "-")")
            print("RequestParams: \(dataBody)")
            
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            return performDataTask(data: data, response: response, responseModel: responseModel)
        } catch {
            return .failure(.unknown)
        }
    }
    
    func performDataTask<T: Codable>(data: Data, response: HTTPURLResponse, responseModel: APIResponse<T>.Type) -> Result<APIResponse<T>, NetworkError> {
        switch response.statusCode {
        case 200...299:
            do {
                let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
                if let dataString = String.init(data:data, encoding: .utf8) {
                    print("\(T.self) Response: \(dataString)\n")
                }
                return .success(decodedResponse)
            }
            catch let error {
                print("Decoding Error: ", error)
                return(.failure(.decoding))
            }
        case 400, 403, 404, 422:
            do{
                let decodedResponse = try JSONDecoder().decode(APIErrorResponse.self, from: data)
                print("API Error: \(decodedResponse.error?.message ?? "")")
                return .failure(.errorMessage(decodedResponse.error?.message ?? "Undefined Message in API"))
            }
            catch let error {
                print("Decoding Error: ", error)
                return(.failure(.decoding))
            }
            
        case 401:
            do{
                let decodedResponse = try JSONDecoder().decode(APIErrorResponse.self, from: data)
                print("API Error: \(decodedResponse.error?.message ?? "")")
                return .failure(.unauthorized(decodedResponse.error?.message ?? ""))
            }
            catch let error {
                print("Decoding Error: ", error)
                return(.failure(.decoding))
            }
            
            
        case 500...510:
            return .failure(.serverNotResponding)
            
        default:
            print(response)
            return .failure(.unknown)
        }
    }
    
    func createDataBody(withParameters params: [String: Any]?, media: [Media]?, boundary: String) -> Data {
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(value)".data(using: .utf8)!)
            }
        }
        
        if let media = media {
            for photo in media {
                body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.fileName)\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: \(photo.mimeType)\r\n\r\n".data(using: .utf8)!)
                body.append(photo.data)
            }
        }
        
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        if let dataString = String.init(data: body, encoding: .utf8) {
            print("Form Data: \(dataString)")
        }
        return body
    }
}

extension URLComponents {
    
    private func checkQueryParams(data: Any?) -> String {
        switch data {
        case .none, .some(is NSNull):       return "-"
        case .some(let value as String):    return value == "<null>" ? "-" : value
        case .some(let value):              return "\(value)"
        }
    }
    
    mutating func setQueryItems(with parameters: [String: Any]) {
        if (parameters.count > 0) {
            var queryItems: [URLQueryItem] = []
            
            for (_, value) in parameters.enumerated() {
                if (checkQueryParams(data: value.value) != "") {
                    queryItems.append(URLQueryItem(name: value.key, value: "\(value.value)"))
                }
            }
            self.queryItems = queryItems
        }
    }
}
