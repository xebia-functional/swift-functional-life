func isPrime(x: Int) -> Bool {
    let sqr : Int = Int(sqrt(Double(x))) + 1
    for i in 2...sqr {
        if x % i == 0 {
            return false
	  }
    }
    return true;
}

func discriminateNumber(x: Int) -> String {
    switch (x, isPrime(x)) {
    case (0..<10, false): return "This is a really small number"
    case (42, _): return "Meaning of life!"
    case (47, _): return "Best number EVER"
    case (0..<10, true): return "This is a small but cool prime number"
    case (10..<1000, _): return "This is a middle-class number"
    case (_, false): return "This is a big big number, not to mess with"
    default: return "You can't beat Optimus prime!"
   }
}

discriminateNumber(1)     // "This is a small but cool prime number"
discriminateNumber(9)     // "This is a really small number"
discriminateNumber(20)    // "This is a middle-class number"
discriminateNumber(1000)  // "This is a big big number, not to mess with"
discriminateNumber(3571)  // "You can't beat Optimus prime!"