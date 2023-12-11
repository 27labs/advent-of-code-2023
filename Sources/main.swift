// The Swift Programming Language
// https://docs.swift.org/swift-book

var entrada: [[Int]] = []

while let input = readLine() {
    entrada.append(input.split(separator: " ")[1...].map { Int($0)! })
}

var waysToWin: [Int] = []

for raceIndex in 0..<entrada[0].count {
    var times: [Int] = []
    for millisecond in 1..<entrada[0][raceIndex] {
        let distance = millisecond * ( entrada[0][raceIndex] - millisecond )
        if distance > entrada[1][raceIndex] { times.append(distance) }
    }
    waysToWin.append(times.count)
}

print(waysToWin.reduce(1, { m, n in m * n }))