//
//  NetworkEnums.swift
//
//  Created by Aakif Nadeem

import Foundation

enum HTTPMethods: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
    case MULTIPART = "MULTIPART"
    case DEFAULT = "DEFAULT"
}

enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidParams
    case noResponse
    case unauthorized(String)
    case decoding
    case serverNotResponding
    case errorMessage(String)
    case formDataCreation
    case unknown
    
    var message: String? {
        switch self {
            
        case .invalidURL:
            return "Please enter valid URL"
            
        case .invalidParams:
            return "Please enter valid Params"
            
        case .noResponse:
            return "No internet. Please check your connection"
            
        case .unauthorized(let msg):
            if (msg == "Unauthorized") {
                return "Session expired. Please login again later"
            }
            else {
                return msg
            }
            
            
        case .decoding:
            return "Decoding error"
       
        case .serverNotResponding:
            return "Server is not responding. Please try again later."
            
        case .errorMessage(let data):
            return data
            
        case .formDataCreation:
            return "Error Creating FormData"
            
        default:
            return "Unknown error"
        }
    }
}

enum ContentType {
    case MULTIFORMDATA(String)
    case FORMURLENCODED
    case APPLICATIONJSON
    case NONE
    
    var data: String {
        switch self {
            
        case .MULTIFORMDATA(let boundary):
            return "multipart/form-data; boundary=\(boundary)"
            
        case .FORMURLENCODED:
            return "application/x-www-form-urlencoded"
            
        case .APPLICATIONJSON:
            return "application/json"
            
        case .NONE:
            return ""
        }
    }
}
