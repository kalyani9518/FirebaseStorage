import UIKit

var greeting = "Hello, playground"

var array :[Int] = [56,76,3,2,7,9,7,4]
var x,y,z : Int
x = 8
y = 2
z = 5
var sum = 0
if x == 1{
    array[y] = z
    print(array)
}
else if x == 0{
    for i in 0...0{
        if y > i && z < array.count{
            for j in y...z{
                sum =  sum + array[j]
                print(sum)
            }
        }
    }
}
else{
    print("value of x  must be 0 or 1")
}

var str1 = ""
var str2 = ""
print(str1.isEmpty && str2.isEmpty ? "None" : "\(str1) \(str2)")


var arr = [6,8,1,25,65,14,2]
for i in 0..<arr.count{
    var rem = arr[i] % 2
    switch rem{
    case 0 :
        print("Even:",arr[i])
    case 1:
        print("Odd:",arr[i])
    default:
        break
    }
}
