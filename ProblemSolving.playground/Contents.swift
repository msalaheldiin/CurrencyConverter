import UIKit

var str = "Hello, playground"

func calculate(first:Double, second:Double,third:Double , fourth: Double)->Double {
    
    return (second * fourth) + (first + third) + (first - third)
}

calculate(first: 2.25, second: 4.50, third: 1.25 , fourth: 5)

func checkForAnagram(firstString: String, secondString: String) -> Bool {
    
    let firstStringWithNoduplication = firstString.reduce("") { $0.range(of: String($1)) == nil ? $0.appending(String($1)) : $0}
    
    let secondStringWithNoduplication = firstString.reduce("") { $0.range(of: String($1)) == nil ? $0.appending(String($1)) : $0}
    
    return  firstStringWithNoduplication.replacingOccurrences(of: " ", with: "").lowercased().sorted() == secondStringWithNoduplication.replacingOccurrences(of: " ", with: "").lowercased().sorted()
}

checkForAnagram(firstString: "punishments", secondString: "nine thumpsssssss")

func fibonacci(_ n: Int) -> Int {
    var a = 1
    var b = 1
    guard n > 1 else { return a }
    
    (2...n).forEach { _ in
        (a, b) = (a + b, a)
    }
    return a
}

fibonacci(6)

func fib(_ n: Int) -> Int {
    var fibs: [Int] = [1, 1]
    (2...n).forEach { i in
        fibs.append(fibs[i - 1] + fibs[i - 2])
    }
    return fibs.last!
}
fib(6)
