import UIKit

var balance = 1200

func withdraw(value: Int, tag: String) {
    print("\(tag): checking if balance containing sufficent money")
    if balance > value {
        print("\(tag): Balance is sufficent, please wait while processing withdrawal")
        // sleeping for some random time, simulating a long process
        Thread.sleep(forTimeInterval: Double.random(in: 0...2))
        balance -= value
        print("\(tag): Done: \(value) has been withdrawed")
        print("\(tag): current balance is \(balance)")
    } else {
        print("\(tag): Can't withdraw: insufficent balance")
    }
}

let queue = DispatchQueue(label: "WithdrawalQueue", attributes: .concurrent)

// Value 1 indicated maximum concurrent operations - at time how many thread sharing a resource
let semaphore = DispatchSemaphore(value: 1)

queue.async {
    
    //semaphore.wait() //No other thread using our global variable balance
    withdraw(value: 1000, tag: "firstATM")
    //semaphore.signal() // Now anyone can use global variable balance
    
}

queue.async {
    //semaphore.wait() //No other thread using our global variable balance
    withdraw(value: 800, tag: "SecondATM")
    //semaphore.signal() // Now anyone can use global variable balance
}
