//
//  PHPhotoLibrary+Rx.swift
//  ToDoDemo
//
//  Created by zhangjianyun on 2018/4/26.
//  Copyright © 2018年 Mars. All rights reserved.
//

import Foundation
import RxSwift
import Photos

extension PHPhotoLibrary {
    static var isAuthorized: Observable<Bool> {
        return Observable.create { observable in
            DispatchQueue.main.async {
                if authorizationStatus() == .authorized {
                    observable.onNext(true)
                    observable.onCompleted()
                }
                else {
                    observable.onNext(false)
                    requestAuthorization {
                        observable.onNext( $0 == .authorized )
                        observable.onCompleted()
                    }
                }
            }
            return Disposables.create()
        }
    }
    
}
