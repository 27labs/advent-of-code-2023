// The Swift Programming Language
// https://docs.swift.org/swift-book

var entrada: [Int] = []

while let input = readLine() {
    let cardNumbers = input.split(separator: ":")[1].split(separator: "|")

    let winning = cardNumbers[0].split(separator: " ")

    let scratched = cardNumbers[1].split(separator: " ")

    var matches = 0

    for number in scratched {
        if winning.contains(number) {
            matches += 1
        }
    }

    if matches > 0 {
        let value = 1 << (matches - 1)
        entrada.append(value)
    }
}

print(entrada.reduce(0, {m, n in m + n}))