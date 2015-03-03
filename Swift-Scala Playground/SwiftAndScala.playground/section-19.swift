func isPerfectNumber(x: Int) -> Bool {
    let max = Int(sqrt(Double(x))) + 1
    var total = 1
    
    func acumulator(x: Int, i: Int) {
        if x % i == 0 {
            total += i
            let q = x / i
            if q > i {
                total += q
	      }
	  }
    }
    
    for i in 2..<max {
        acumulator(x, i)
    }	    
    return total == x
}

discriminateNumberByFunction(6, "perfect", isPerfectNumber)     // "This is a small but cool perfect number"
discriminateNumberByFunction(28, "Perfect", isPerfectNumber)    // "Perfect class hero is something to be..."
discriminateNumberByFunction(47, "perfect", isPerfectNumber)    // "Best number EVER"