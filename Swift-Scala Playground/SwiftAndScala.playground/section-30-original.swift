func curriedlyDiscriminateNumberByFunction(functionDescription: String, function: (Int) -> Bool)(x: Int) -> String {
    return discriminateNumberByFunction(x, functionDescription, function)
}

let discriminateByPrimes = curriedlyDiscriminateNumberByFunction("prime", isPrime)
discriminateByPrimes(x: 3)  // "This is a small but cool prime number"
