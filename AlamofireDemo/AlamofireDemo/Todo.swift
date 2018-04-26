//
//  Todo.swift
//  AlamofireDemo
//
//  Created by zhangjianyun on 2018/4/26.
//  Copyright © 2018年 zhangjianyun. All rights reserved.
//

import Foundation

class Todo: CustomStringConvertible {
    var description: String {
        
        return "ID: \(self.id ?? 0)," +
        "title: \(self.title)," +
        "completed: \(self.completed)"
    }
    
    
    var id: UInt?
    var title: String
    var completed: Bool
    
    init(id: UInt, title: String, completed: Bool) {
        
        self.id = id
        self.title = title
        self.completed = completed
    }
    
    required init?(json: [String: Any]) {
        
        guard let id = json["id"] as? UInt,
        let title = json["title"] as? String,
        let completed = json["completed"] as? Bool else {
                return nil
        }
        self.id = id
        self.title = title
        self.completed = completed
        
    }
    
}
