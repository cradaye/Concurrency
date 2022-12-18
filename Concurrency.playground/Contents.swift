import UIKit

// shared resource
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

//Used to run method concurrently to produce race condition.
//Where more than one thread tries to access the shared resource
//here shared resource is balance
let queue = DispatchQueue(label: "WithdrawalQueue", attributes: .concurrent)

// Value 1 indicated maximum concurrent operations - at time how many thread sharing a resource
let semaphore = DispatchSemaphore(value: 1)

queue.async {
    
    semaphore.wait() //No other thread using our shared resource balance
    withdraw(value: 1000, tag: "Net Banking")
    semaphore.signal() // Now anyone can open to use shared resource balance
    
}

queue.async {
    semaphore.wait() //No other thread using our shared resource balance
    withdraw(value: 800, tag: "Atm Withdrawal")
    semaphore.signal() // Now anyone can open to use shared resource balance
}
