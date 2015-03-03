func discriminateNumberByFunction(x: Int, functionDescription: String, function: (Int) -> Bool) -> String {
    switch x {
    case 0..<10 where !function(x): return "This is a really small number"
    case 0..<10: return "This is a small but cool \(functionDescription) number"
    case 42: return "Meaning of life!"
    case 47: return "Best number EVER"
    case 10..<1000 where !function(x): return "This is a middle-class number"
    case 10..<1000: return "\(functionDescription) class hero is something to be..."
    case _ where !function(x): return "Fat bottomed numbers they make the rocking world go round!"
    default: return "Big \(functionDescription) numbers sure are some wonder to behold!"
	}
}
