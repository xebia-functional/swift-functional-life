result = discriminateNumberByFunction(8, "Even", { (value: Int) -> Bool in return value % 2 == 0})
result = discriminateNumberByFunction(8, "Even", {$0 % 2 == 0})
result = discriminateNumberByFunction(8, "Even") {$0 % 2 == 0}
println(result)