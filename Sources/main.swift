// The Swift Programming Language
// https://docs.swift.org/swift-book

var entrada: [Int:Int] = [:]

var indice = 1

while let input = readLine() {
    entrada[indice] = 1 + (entrada[indice] ?? 0)
    indice += 1
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
        for _ in 1...(entrada[indice-1] ?? 1) {
            for cardIndex in indice...(indice+matches-1) {
                entrada[cardIndex] = 1 + (entrada[cardIndex] ?? 0)
            }
        }
    }
}

print(entrada.sorted(by: { $0.key < $1.key }).prefix(indice-1).reduce(0, {m, n in m + n.value}))