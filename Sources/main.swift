// The Swift Programming Language
// https://docs.swift.org/swift-book

var entrada: Array<Int> = []

let cubesRGB = (12,13,14)

while let input = readLine() {
    let idSplit = input.split(separator: ":")

    // print(idSplit)

    let gameSplit = idSplit[1].split(separator: ";")

    // print(gameSplit)

    var possible = true

    for match in gameSplit {
        let cubeSplit = match.split(separator: ",")
        // print(cubeSplit)
        for cubeAmount in cubeSplit {
            let amountSplit = cubeAmount.split(separator: " ")
            // print(amountSplit)
            switch amountSplit[1] {
                case "red":
                    if Int(amountSplit[0]) ?? 0 > cubesRGB.0 { possible = false }
                case "green":
                    if Int(amountSplit[0]) ?? 0 > cubesRGB.1 { possible = false }
                case "blue":
                    if Int(amountSplit[0]) ?? 0 > cubesRGB.2 { possible = false }
                default:
                    break
            }
        }
    }

    if possible { entrada.append(Int(idSplit[0].split(separator: " ")[1]) ?? 0)}
}

print(entrada.reduce(0, {x, y in x + y}))