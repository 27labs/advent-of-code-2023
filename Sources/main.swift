// The Swift Programming Language
// https://docs.swift.org/swift-book

var entrada: [Any] = []

var memoizer: [[Int]: Int] = [:]

func calcularPosibles(_ springLine: [Substring], _ blockList: [Int], _ springIndex: Int, _ blockIndex: Int, _ broken: Int) -> Int {
    let key = [springIndex, blockIndex, broken]
    if let storedResult = memoizer[key] {
        return storedResult
    }

    if springIndex == springLine.count {
        if blockIndex == blockList.count && broken == 0 {
            return 1
        } else if blockIndex == (blockList.count - 1) && blockList[blockIndex] == broken {
            return 1
        } else {
            return 0
        }
    }

    var answer = 0
    for springType: Substring in [".","#"] {
        if [springType,"?"].contains(springLine[springIndex]) {
            if springType == "." {
                if broken == 0 {
                    answer += calcularPosibles(springLine, blockList, springIndex + 1, blockIndex, 0)
                } else if blockIndex < blockList.count && blockList[blockIndex] == broken {
                    answer += calcularPosibles(springLine, blockList, springIndex + 1, blockIndex + 1, 0)
                }
            } else {
                answer += calcularPosibles(springLine, blockList, springIndex + 1, blockIndex, broken + 1)
            }
        }
    }
    memoizer[key] = answer
    return answer
}

var arreglos = 0

while let input = readLine() {
    let splitted = input.split(separator: " ")
    let springs = splitted[0].split(separator: "")
    var springList = springs
    for _ in 1..<5 {
        springList += ["?"] + springs
    }
    let blocks = splitted[1].split(separator: ",").map {
        Int($0)!
    }
    var blockList = blocks
    for _ in 1..<5 {
        blockList += blocks
    }
    memoizer = [:]
    arreglos += calcularPosibles(springList,blockList,0,0,0)
}

print(arreglos)