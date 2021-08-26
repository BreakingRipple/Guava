import UIKit

//{ (parameters) -> return type in
//    statements
//}

//MMARK: Scenario 1
//call directly
let label: UILabel = {
    let label = UILabel()
    label.text = "xxx"
    return label
}()

//define first, then call
let learn = { (lan: String) -> String in
    "learn \(lan)"
}
learn("iOS")

//different with function
func learn1(_ lan: String) -> String{
    "learn \(lan)"
}
learn1("iOS")

//define type
let aa: Int?
let bb: (() -> ())?
//line 29 is the same as line 31
let cc: (() -> Void)?

//Nested
func codingSwitf(day: Int, appName: () -> String){
    print("learn swift \(day) days, create \(appName()) App")
}

// 1
codingSwitf(day: 40, appName: { () -> String in
    return "Weather"
})

// 2
let appName = { () -> String in
    return "Todos"
}
codingSwitf(day: 60, appName: appName)

func appName1() -> String{
    "Counter"
}
codingSwitf(day: 100, appName: appName1)

//Trailing closure
codingSwitf(day: 130) { () -> String in
    return "machine learning"
}

//context
func codingSwift(day: Int, appName: String, res: (Int, String) -> String){
    print("learn swift \(day) days, creating \(appName) app, \(res(1, "Alamofire"))")
}

codingSwift(day: 40, appName: "Weather") { takeDay, use in
    "spend \(takeDay) days, using \(use) technique"
}

codingSwift(day: 40, appName: "Weather") {
    "spend \($0) days, using \($1) technique"
}

// MARK: System function - sorted
let arr = [3,5,1,2,4]
let sortedArr = arr.sorted(by: <)

// MARK: capture closures
func makeIncrementer(forIncrement amount: Int) -> ()->Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()

// MARK: @escaping
var completionHandlers = [() -> Void]()
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
