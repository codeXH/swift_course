//
//  Todo+Alamofire.swift
//  AlamofireDemo
//
//  Created by zhangjianyun on 2018/4/26.
//  Copyright © 2018年 zhangjianyun. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

enum GetTodoListError: Error {
    case cannotConvertServerResponse
}

extension Todo {
    class func getList(from router: TodoRouter) -> Observable<[[String: Any]]> {
        
        return Observable.create { (observer) -> Disposable in
            let request = Alamofire.request(router)
                .responseJSON(completionHandler: { (response) in
                    
                    guard response.result.error == nil else {
                        observer.on(
                            .error(response.result.error!))
                        return
                    }
                    
                    guard let todos =
                        response.result.value as? [[String: Any]] else {
                            observer.on(
                                .error(GetTodoListError.cannotConvertServerResponse))
                            return
                    }
                    
                    observer.on(.next(todos))
                    observer.onCompleted()
                })
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
