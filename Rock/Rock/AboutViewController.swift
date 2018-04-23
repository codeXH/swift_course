//
//  AboutViewController.swift
//  Rock
//
//  Created by zhangjianyun on 2018/4/23.
//  Copyright © 2018年 zhangjianyun. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "About Us"
        setupView()
    }
    
    func setupView() {
        
        let filePath = Bundle.main.path(forResource: "aboutus", ofType: "html")
        guard let path = filePath else {
            return
        }
        guard let url = URL(string: path) else {
            return
        }
        webView.loadRequest(URLRequest.init(url: url))
    }
}
