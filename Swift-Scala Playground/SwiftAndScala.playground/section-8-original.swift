let potentiallyDangerousUrl = NSURL(string: "troll://not an url")
let niceUrl = NSURL(string: "http://www.47deg.com")

var result : String

func upperCaseStringFromUrl(url: NSURL?) -> String? {
    if let safeUrl = url {
        if let safeUrlString = safeUrl.absoluteString {
            return safeUrlString.uppercaseString
	  }
    }
    return nil
}

let aNilResult = upperCaseStringFromUrl(potentiallyDangerousUrl)
let aNiceResult = upperCaseStringFromUrl(niceUrl)
