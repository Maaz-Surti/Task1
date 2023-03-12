////
////  Network.swift
////  DiamondHouse
////
////  Created by RCD on 16/01/2023.
////
//
//import Foundation
//
//enum ApiError: Error {
//    case requestFailed(description: String)
//    case invalidData
//    case invalidURL
//    case responseUnsuccessful(description: String)
//    case jsonConversionFailure(description: String)
//    case jsonParsingFailure
//    case failedSerialization
//    case noInternet
//    
//    var customDescription: String {
//        switch self {
//        case let .requestFailed(description): return "Request Failed: \(description)"
//        case .invalidData: return "Invalid Data"
//        case .invalidURL: return "Invalid URL"
//        case let .responseUnsuccessful(description): return "Unsuccessful: \(description)"
//        case let .jsonConversionFailure(description): return "JSON Conversion Failure: \(description)"
//        case .jsonParsingFailure: return "JSON Parsing Failure"
//        case .failedSerialization: return "Serialization failed."
//        case .noInternet: return "No internet connection"
//        }
//    }
//}
//
//enum Method: String {
//    
//    case get = "GET"
//    case post = "POST"
//}
//
//protocol GenericApi {
//    var session: URLSession { get }
//    func request<T: Codable>(type: T.Type, params: Params?, method: Method, with URL: URL?) async throws -> T
//}
//
//extension GenericApi {
//    func request<T: Codable>(type: T.Type, params: Params? = nil, method: Method = .get, with URL: URL?) async throws -> T {
//        
//        guard let URL = URL else{
//            
//            throw ApiError.invalidURL
//        }
//        
//        var request = URLRequest(url: URL)
//        
//       // request.setValue(Constants.authToken, forHTTPHeaderField: "Token")
//        
//        if let params {
//            
//            request.httpBody = params.percentEncoded()
//        }
//        
//        let (data, response) = try await session.data(for: request)
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw ApiError.requestFailed(description: "Invalid response")
//        }
//        guard httpResponse.statusCode == 200 else {
//            throw ApiError.responseUnsuccessful(description: "Status code: \(httpResponse.statusCode)")
//        }
//        
//        do {
//            let decoder = JSONDecoder()
//            return try decoder.decode(type, from: data)
//        } catch {
//            throw ApiError.jsonConversionFailure(description: error.localizedDescription)
//        }
//    }
//}
//
//final class Network: GenericApi {
//    
//    var session: URLSession
//
//    init(configuration: URLSessionConfiguration) {
//     self.session = URLSession(configuration: configuration)
//    }
//
//    convenience init() {
//     self.init(configuration: .default)
//    }
//}
//
//
