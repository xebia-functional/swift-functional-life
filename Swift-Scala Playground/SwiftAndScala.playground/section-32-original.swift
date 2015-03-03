let beatles = ["John", "Paul", "George", "Ringo"]

// The old way:
var temp = [String]()
for beatle in beatles {
    temp.append("Good morning, \(beatle)")
}

// The brand-new-best way:
let beatGreetings = beatles.map({"Good morning, \($0)"})
