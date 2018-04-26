//
//  TodoRouter.swift
//  AlamofireDemo
//
//  Created by zhangjianyun on 2018/4/26.
//  Copyright © 2018年 zhangjianyun. All rights reserved.
//

import Foundation
import Alamofire

enum TodoRouter {
    
    static let baseUrl: String = "https://jsonplaceholder.typicode.com/"
    case get(Int?)
    case post([[String: Any]])
}

extension TodoRouter: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .get:
                return .get
            case .post:
                return .post
            }
        }
        
        var params: [String: Any]? {
            switch self {
            case .get:
                return nil
            case .post:
                return params
            }
        }
        
        var url: URL {
            
            var relativeUrl: String = "todos"
            
            switch self {
            case .get(let todoId):
                if todoId != nil {
                    relativeUrl = "todos/\(todoId!)"
                }
            default:
                break
            }
            
            let  url = URL(string: TodoRouter.baseUrl)!.appendingPathComponent(relativeUrl)
            return url
            
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let encoding = JSONEncoding.default
        
        return try encoding.encode(request, with: params)
    }
    
    
}
