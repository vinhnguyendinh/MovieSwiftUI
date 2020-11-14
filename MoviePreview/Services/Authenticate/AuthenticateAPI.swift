//
//  AuthenticateAPI.swift
//  MoviePreview
//
//  Created by Vinh Nguyen Dinh on R 2/11/09.
//

import Moya

let authenticateProvider = MoyaProvider<Authenticate>(plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: String.JSONResponseDataFormatter),
                                                                                                         logOptions: .verbose))])
public enum Authenticate {
    case createRequestToken
    case login(username: String, password: String, requestToken: String)
}

// MARK: - TargetType
extension Authenticate: TargetType {
    public var baseURL: URL {
        return URL(string: URLs.baseUrl)!
    }
    
    public var path: String {
        switch self {
        case .createRequestToken:
            return "\(URLs.createRequestToken)"
            
        case .login:
            return "\(URLs.login)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
            
        default:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .login(let username, let password, let requestToken):
            return .requestCompositeParameters(bodyParameters: [
                "username": username,
                "password": password,
                "request_token": requestToken
            ], bodyEncoding: URLEncoding.httpBody, urlParameters: ["api_key": URLs.apiKey,])
            
        default:
            return .requestParameters(parameters: ["api_key": URLs.apiKey], encoding: URLEncoding.default)
        }
    }
    
    public var validationType: ValidationType {
        switch self {
        default:
            return .successCodes
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .createRequestToken:
            return "{\"success\":true,\"expires_at\":\"2020-11-09 08:10:32 UTC\",\"request_token\":\"988451a3898a0abb1104886132ed699fbbc100a6\"}"
                .data(using: String.Encoding.utf8)!
            
        case .login:
            return "{\"success\":true,\"expires_at\":\"2020-11-13 08:02:56 UTC\",\"request_token\":\"924ac9f30841e38c63e82b45f33a8c6cb1058a81\"}"
                .data(using: String.Encoding.utf8)!
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
}
