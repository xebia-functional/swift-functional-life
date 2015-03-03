func greetPerson(greeting: String)(name: String) -> String {
    return greeting + ", " + name
}

let informallyGreet = greetPerson("Hi")
informallyGreet(name: "Dolly")  // "Hi, Dolly"

let japaneseGreet = greetPerson("こんにちは")
japaneseGreet(name: "Dollyさん")  // "こんにちは, Dollyさん"
