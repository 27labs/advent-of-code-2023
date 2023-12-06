// The Swift Programming Language
// https://docs.swift.org/swift-book

var cubesRGB: [(Int,Int,Int)] = []

var index = 0

while let input = readLine() {
    let idSplit = input.split(separator: ":")

    // print(idSplit)

    let gameSplit = idSplit[1].split(separator: ";")

    // print(gameSplit)
    cubesRGB.append((0,0,0))
    for match in gameSplit {
        let cubeSplit = match.split(separator: ",")
        // print(cubeSplit)
        for cubeAmount in cubeSplit {
            let amountSplit = cubeAmount.split(separator: " ")
            // print(amountSplit)
            switch amountSplit[1] {
                case "red":
                    let amount = Int(amountSplit[0]) ?? 0
                    if amount > cubesRGB[index].0 { cubesRGB[index].0 = amount }
                case "green":
                    let amount = Int(amountSplit[0]) ?? 0
                    if amount > cubesRGB[index].1 { cubesRGB[index].1 = amount }
                case "blue":
                    let amount = Int(amountSplit[0]) ?? 0 
                    if amount > cubesRGB[index].2 { cubesRGB[index].2 = amount }
                default:
                    break
            }
        }
    }

    index += 1
}

print(cubesRGB.reduce(0, {x, y in x + y.0 * y.1 * y.2}))