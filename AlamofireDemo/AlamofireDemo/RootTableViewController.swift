//
//  RootTableViewController.swift
//  AlamofireDemo
//
//  Created by zhangjianyun on 2018/4/26.
//  Copyright © 2018年 zhangjianyun. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

class RootTableViewController: UITableViewController {

    
    var todoList = [Todo]()
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        let todoId: Int? = nil
        _ = Observable.of(todoId)
            .map { tid in
                return TodoRouter.get(tid)
            }
            .flatMap { route in
                return Todo.getList(from: route)
            }
            .subscribe(onNext: { (todos: [[String: Any]]) in
                self.todoList = todos.compactMap { Todo(json: $0 ) }
                self.tableView.reloadData()
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: bag)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Configure the cell...
        let title = self.todoList[indexPath.row].title
        let attributeString =  NSMutableAttributedString(string: title)
        
        if self.todoList[indexPath.row].completed {
            attributeString.addAttribute(.underlineStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        }
        
        cell.textLabel?.attributedText = attributeString
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
