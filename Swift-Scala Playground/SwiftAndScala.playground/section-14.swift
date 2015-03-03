func joinOptionalStrings(stringA: String?, stringB: String?) -> String {
    switch (stringA, stringB) {
    case let(.Some(a), .Some(b)):
        return a + b
    case let(.Some(a), _):
        return a
    case let(_, .Some(b)):
        return b
    default: return "The artist previosly known as Prince"
	}
}

joinOptionalStrings("John", " Lennon")
joinOptionalStrings("Chayanne", nil)
joinOptionalStrings(nil, "Shakira")
joinOptionalStrings(nil, nil)
