//
//  APIError.swift
//  StocksAcademy
//
//  Created by bovsheva on 19.06.2022.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badUrl
    case badResponse(statusCode: Int)
    case urlSessionError(URLError?)
    case parsing(DecodingError?)
    case uknown(Error?)
    
    var localizedDescription: String {
        // for users
        switch self {
            
            case .badUrl, .parsing, .uknown:
                return "Sorry, something went wrong."
            
            case .badResponse(_):
                return "Sorry, the connection to our server failed."
            
            case .urlSessionError(let error):
                return error?.localizedDescription ?? "Sorry, something went wrong."
        }
    }
    
    var description: String {
        // for debugging
        switch self {
            case .badUrl:
                return "Invalid url"
            
            case .badResponse(statusCode: let code):
                return "Bad response with status code \(code)"
            
            case .urlSessionError(let error):
                return "URL session error \(error?.localizedDescription ?? "")"
            
            case .parsing(let error):
                return "Decoding error \(error?.localizedDescription ?? "")"
            
            case .uknown(let error):
                return "Uknown error \(error?.localizedDescription ?? "")"
        }
    }
}
