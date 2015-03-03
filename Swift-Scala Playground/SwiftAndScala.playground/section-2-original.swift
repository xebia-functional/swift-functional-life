import UIKit

func quadraticFunction(x: Double, a: Double, b: Double, c: Double) -> Double {
    // f(x) = ax2 + bx + c
    return a * pow(x, 2) + b * x + c
}

func cubicFunction(x: Double, a: Double) -> Double {
    // f(x) = x3 + a
    return pow(x, 3) + a
}

func sinFunction(angle: Double) -> Double {
    let radians = angle / 180.0 * M_PI
    return sin(radians)
}

for var i = -10.0; i < 10.0; i++ {
    let quadraticResult = quadraticFunction(i, 2, 2, 1)
    let cubicResult = cubicFunction(i, 1)
}

for var i : Double = 0; i <= 360; i += 10 {
    let sinResult = sinFunction(i)
}
