// The Swift Programming Language
// https://docs.swift.org/swift-book

var entrada: [Any] = []

func esValida(_ resortes: [Substring], _ grupos: [Int]) -> Int {
    var blocks: [Int] = []
    var dañados = 0
    for resorte in resortes {
        if resorte == "." {
            if dañados > 0 {
                blocks.append(dañados)
                dañados = 0
            }
        } else {
            dañados += 1
        }
    }
    if dañados > 0 { blocks.append(dañados) }
    if blocks == grupos {
        return 1
    } else {
        return 0
    }
}

func calcularPosibles(_ springLine: [Substring], _ blockList: [Int], _ index: Int) -> Int {
    if index == springLine.count {
        return esValida(springLine,blockList)
    }

    if springLine[index] == "?" {
        return calcularPosibles(Array(springLine[..<index] + ["."] + springLine[(index + 1)...]), blockList, index + 1) + calcularPosibles(Array(springLine[..<index] + ["#"] + springLine[(index + 1)...]), blockList, index + 1)
    }

    return calcularPosibles(springLine, blockList, index + 1)
}

var arreglos = 0

while let input = readLine() {
    let splitted = input.split(separator: " ")
    let springs = splitted[0].split(separator: "")
    let blocks = splitted[1].split(separator: ",").map {
        Int($0)!
    }
    arreglos += calcularPosibles(springs,blocks,0)
}

print(arreglos)