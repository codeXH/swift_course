//: Playground - noun: a place where people can play

import UIKit
//
// Tuple
var str = (404,"httperror")
str.0
str.1

var user = (name: "xiaohei",id: 10, Mail: "123@qq.com")
user.0
user.id

//相当于重新复制了一份tuple， 修改它的值并不会修改原来tuple的值
var (code, message) = str
code
message


//tuple只能比较相同个数元素的
//var tuple1 = (1,2)
//var tuple12 = (1,3)
//
//tuple1 > tuple12

//当tuple的元素个数大于7以后，将无法进行比较
var tuple2 = (1,2,3,4,5,6,7)
var tuple21 = (1,2,3,4,5,6,7)
//tuple2 == tuple21


//取余操作
var a = 20
var b = 10
//不支持浮点型取余,需要使用
//8 % 2.5
8.truncatingRemainder(dividingBy: 2.5)
8.truncatingRemainder(dividingBy: 2.1)


/// #1 集合类型
var array1: Array<Int> = Array<Int>()
var array2: [Int] = []
var array3 = array2

var threeInt = [Int](repeating: 3, count: 4)
var sixInt = threeInt + threeInt
var fiveInts = [1,2,3,4,5]

fiveInts.count
array1.isEmpty

for (index,numebr) in fiveInts.enumerated() {
    
    print(index)
    print(numebr)
}
fiveInts
fiveInts.forEach({print($0)})

var 😀 = "Hello Mars"
let arr = 😀.description

