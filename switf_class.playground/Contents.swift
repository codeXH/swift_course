//: Playground - noun: a place where people can play
//: 1:OOP
//: 2:储存属性（例如字符串），计算属性（例如Int型），类属性（使用类对象调用）
//: 3:继承
//: 4:多态（使用父类指针指向子类）
import UIKit
import Foundation

class Person {
    var name = ""
    var age = 0
    
    init() {
        print("这是构造函数")
    }
    init(name: String, age: Int) {
        self.name = name
        self.age = age
        print("这是自定义的构造函数")
    }
    deinit {
        print("这是析构函数")
    }
    
    func sleep() {
        print("\(name) sleep a night")
    }
    
    var english = 0
    var chinese = 0
    var math = 0
    var sum: Int {
        get {
            return english+chinese+math
        }
    }
    class var des: String {
        get {
            return "这是一个类方法"
        }
    }
}

var li = Person.init()
li.name = "lisi"
li.sleep()
li.english = 80
li.chinese = 90
li.math = 100
li.sum
Person.des


class Man: Person {
    
    override func sleep() {
        print("man sleep")
    }
}

class Women: Person {
    
    override func sleep() {
        print("women sleep")
    }
}

var p: Person = Person()
var m: Man = Man()
var w: Women = Women()

p.sleep()
m.sleep()
w.sleep()

//: 编译时时父类对象，运行时是子类对象
//: 比如说tag值，self.view是view对象，运行时会变成自己tag所对应的对象，比如说uibutton，uilabel
var p1: Person = Man()
p1.sleep()
