//
//  ViewController.swift
//  Rock
//
//  Created by zhangjianyun on 2018/4/23.
//  Copyright © 2018年 zhangjianyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myImageVIew: UIImageView!
    @IBOutlet weak var doraemonImageView: UIImageView!
    var choise: [String] = ["rock","scissor","paper"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let document = documentsDirectory()
        print("documnet is \(document)")
        let file = fileUrl(fileName: "test.plist")
        print("file is \(file)")
    }
    
    @IBAction func didClickOnStartBtn(_ sender: UIButton) {
        self.title = "Start"
        
        doraemonImageView.image = UIImage.init(named: "rock")
        let index = Int(arc4random() % 3)
        myImageVIew.image = UIImage.init(named: choise[index])
        
        let message = getResult(index: index)
        let alert = UIAlertController.init(title: "结果", message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func getResult(index: Int) -> String {
        switch index {
        case 0:
            return "pingju"
        case 1:
            return "you are loss"
        case 2:
            return "you win"
        default:
            break
        }
        return "unkonw"
    }
    
    // 获取Document目录
    func documentsDirectory() -> NSURL {
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[0] as NSURL
    }
    // 获取document目录下文件的目录
    func fileUrl(fileName: String) -> NSURL {
        let documentUrl = documentsDirectory().appendingPathComponent(fileName)
        return documentUrl! as NSURL
    }
}

