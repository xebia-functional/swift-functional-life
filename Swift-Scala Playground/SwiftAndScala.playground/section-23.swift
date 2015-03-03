// Scala: 
// val maxNumber: (Int, Int) => Int = (m: Int, n: Int) => if(m > n) m else n

// Swift:
let maxNumber = { (m: Int, n: Int) -> (Int) in m > n ? m : n }
maxNumber(3, 5)