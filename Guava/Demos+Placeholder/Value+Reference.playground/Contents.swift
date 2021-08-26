import UIKit

let a = 1

//memory: heap & stack
//stack: int string array diction struct
//heap: function class closure object

struct Person {
    var name = "wang"
    var age = 20
}

let p1 = Person()
var p2 = p1
p2.age = 30
p1.age

class PersonC {
    var name = "wang"
    var age = 20
}

let p3 = PersonC()
let p4 = p3
p4.age = 30
p3.age
