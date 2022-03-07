
var greeting = "Hello, playground"
//MARK: Dictionary

//var dict : [String:String] = [:]
//var dict : Dictionary<String,String> = Dictionary<String,String>()
//ar dict = Dictionary<String, String>()
var  dict = [String:String]()
dict = ["1":"ABC","2":"DEF","3":"GHI"]
dict["4"] = "JKL"

dict.updateValue("MNO", forKey: "5")
print(dict)


//MARK: Array
//var array = Array<Int>()
//var array : Array<Int>  = Array<Int>()
//var array = [Int]()
var array : [Int] = []

array = [43,3,14,76]
array.insert(9, at: 4)
array.insert(6, at: 5)
print(array)
//remove
array.remove(at: 2)
print(array)
//
print(array.first!)
print(array.last!)
for index in array{
    print("\(index) ")
}
var players = ["Rahul","Sachin","Dhoni","Virat","Raina"]
for i in 0..<players.count {
    print("\(i + 1). \(players[i])")
}

//MARK: Set
//Unordered collection of data, set cannot contain duplicated element
var a: Set<Int> = [1,3,5,7,7,9,0]
let b: Set<Int> = [2,4,6,8,10,0]
print(a)
a.insert(11)


//MARK: TUPLES
// The values in a tuple can be of any type, and do not need to be of same type.commonly used to return multiple values from a function call

print("TUPLE EXAMPLE")
func tupleDemo()->(name:String,age:Int){
//UnnamedTuple
    var unNamedTuple = ("Name",3,"Address")
    print("unNamedTuple : ",unNamedTuple)
    unNamedTuple.1 = 6
    print("Updated : ",unNamedTuple)
//NamedTuple
    var namedTuple = (name:"PQR",age:23)
    print("namedTuple : ",namedTuple)
    namedTuple.0 = "ZYX"
    print("updated:",namedTuple.name)
return namedTuple
}
var tuple = tupleDemo()
print("return multiple value from function by using tuple:",tuple)


//MARK: Classe
class A{
    var name = "testName"
    var b: B?
}
class B{
    var age:Int = 3
}
class Student {
    var name: String
    var rno:Int
    init(name:String, rno:Int) {
        self.name = name
        self.rno = rno
    }
    deinit{
        print("Deinited")
    }
}
print()
print("CLASS EXAMPLE :")
    let studentObj = Student(name: "XYZ", rno: 11)
    print("studentObj name and rno",studentObj.name,studentObj.rno)
    let copyObj = studentObj
    copyObj.name = "ABC"
    copyObj.rno = 12
    print("studentObj name and rno",studentObj.name,studentObj.rno)
    print("copyObj name and rno:",copyObj.name,copyObj.rno)
    
//MARK: STRUCTURE
struct Student1 {
    var name: String
    var rno:Int
    init(name:String, rno:Int) {
        self.name = name
        self.rno = rno
    }
}
print()
print("STRUCTURE EXAMPLE :")
    let studentObj1 = Student1(name: "XYZ", rno: 1)
    var copyObj1 = studentObj1
    copyObj1.name = "ABC"
    copyObj1.rno = 2
    print("studentObj name and rno",studentObj1.name,studentObj1.rno)
    print("copyObj1 name and rno",copyObj1.name,copyObj1.rno)
   
//Difference between structrure and class is class is reference type and structure is value type.
//Reference type :When you copy a Reference type/class, you end up with two references to one instance of the data
//value type : When you copy a value type/struct, you end up with two unique copies of the data.
    //Inheritance are allowed in stucture in classes it is allowed.




//MARK: OPTIONAL
//An optional is basically a constant or variable that can hold a value OR no value
var name : String?
name = "BIPP"
print(name)
//MARK: UNWRAPPING OPTIONAL
func optionalTech(){
    print("Force unwrapping")
    print(name!)
    print("optional binding")
    print("if-let")
    if let name = name{
    print("if-let",name)
}
else{
    print("if-let:name is not present")
}
  
    guard let name = name else{
        return
    }
    print("gurad-let",name)
    let obj = A()
    obj.b = B()
    if let age = obj.b?.age{
    print("Optional Chaining ",age)
    }
}

optionalTech()

//MARK: LOOPS
print("for-in")


var randomInts: [Int] = []

for _ in 0..<25 {
    let randomInt = Int.random(in: 1...50)
    randomInts.append(randomInt)
}
print(randomInts)

while(randomInts.count<0)
{
    print(randomInts)
}

print("while")
var i = 1
var n = 10
while (i <= n) {
    print(i*i)
    i+=1
}

print("repeat-while")
var j1 = 1
repeat{
    print(j1*j1)
    j1+=1
}while(j1<=n)

var arr = [76,65,34,32,21,11]
func maximum(){
    
    for i in 0..<arr.count{
        for j in 0...i{
            if (arr[i]<arr[j]){
        
        print("\(i) value is \(arr[i])")
    }
        }
}
                }
maximum()



enum DivisionError: Error{
    case divideByZero
    case divideBySameNumber
}
func Division(numerator:Int,denominator:Int)throws{
    if denominator == 0{
        throw DivisionError.divideByZero
    }
    else if denominator == numerator{
        throw DivisionError.divideBySameNumber
    }
    else{
        let div = numerator/denominator
        print(div)
    }
}
do{
    try Division(numerator: 10, denominator: 10)
    print("Division is valid")
}
catch DivisionError.divideByZero{
    print("Denominator cannot be 0")
    
}
catch DivisionError.divideBySameNumber{
    print("same number")
}
