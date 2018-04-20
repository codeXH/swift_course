//
//  CurrentWeatherUITest.swift
//  SkyUITests
//
//  Created by zhangjianyun on 2018/4/17.
//  Copyright © 2018年 Mars. All rights reserved.
//

import XCTest
@testable import Sky

class CurrentWeatherUITest: XCTestCase {
    
    let app = XCUIApplication()
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments += ["UI-TESTING"]
        let json = """
{
    "longitude" : 100,
    "latitude" : 52,
    "currently" : {
        "temperature" : 23,
        "humidity" : 0.91,
        "icon" : "snow",
        "time" : 1507180335,
        "summary" : "Light Snow"
    }
}
"""
        app.launchEnvironment["FakeJSON"] = json
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_location_button_esits() {
        
        //等待异步加载完成后的测试
        let locationBtn = app.buttons["LocationBtn"]
        let exists = NSPredicate(format: "exists == true")

        expectation(for: exists,
                    evaluatedWith: locationBtn,
                    handler: nil)
        waitForExpectations(timeout: 5, handler:nil)
        
        XCTAssert(locationBtn.exists)
    }
    
    func test_currently_weather_display() {
        
        // 重写异步返回数据的接口，使数据直接同步返回，从而实现同步调用
        XCTAssert(app.images["snow"].exists)
        XCTAssert(app.staticTexts["Light Snow"].exists)
        XCTAssert(app.buttons["LocationBtn"].exists)
    }
}
