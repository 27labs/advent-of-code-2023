// The Swift Programming Language
// https://docs.swift.org/swift-book

var entrada: [[Int]] = []

while let input = readLine() {
    entrada.append((input.split(separator: " ").map {
        Int($0)!
    }))
}

func extrapolate(history: [Int]) -> Int {
    if (history.filter {
        $0 != 0
    }).count > 0 {
        var difference: [Int] = []
        for i in 1..<history.count {
            difference.append(history[i] - history[i - 1])
        }
        return difference.first! - extrapolate(history: difference)
    }
    return 0
}

var sumOfValues = 0

for history in entrada {
    sumOfValues += history.first! - extrapolate(history: history)
}

print(sumOfValues)