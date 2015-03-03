let beatleMath = beatles.map({count($0)}).reduce(0, combine: +)    // 19
let beatleGreetings = beatInformalGreetings.reduce("", combine: {$0 + "\n" + $1 })
println(beatleMath)
println(beatleGreetings)
