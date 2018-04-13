//
//  ViewController.swift
//  swift_weather
//
//  Created by zhangjianyun on 2018/4/13.
//  Copyright © 2018年 zhangjianyun. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON



class ViewController: UIViewController,CLLocationManagerDelegate {

    let corelocation = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        corelocation.desiredAccuracy = kCLLocationAccuracyBest
        corelocation.requestWhenInUseAuthorization()
        corelocation.delegate = self
        corelocation.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let location: CLLocation = locations.last as! CLLocation
        
        if location.horizontalAccuracy > 0 {
            
            print("\(location.coordinate.latitude)")
            print("\(location.coordinate.longitude)")
            
            self.updateWeatherInfo(location.coordinate.latitude, longutude: location.coordinate.longitude)
            corelocation.stopUpdatingLocation()
        }
    }
    func updateWeatherInfo(_ lotitude: CLLocationDegrees, longutude: CLLocationDegrees) {
        
        let url = "https://api.haichufang.com/hp/homepage/getMnActivityInfo"

        // 网络请求的数据
        Alamofire.request(url).responseJSON { response in
            
            // 初始化json数据
            let json = JSON.init(response.data!)
            // 根据顺序取自己想要的数据
            let result = json["result"][0]
            let image = json["result"][0]["specialImg"]
            print("result is \(result)")
            print("image is \(image)")
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

