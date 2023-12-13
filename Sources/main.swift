// The Swift Programming Language
// https://docs.swift.org/swift-book

var entrada: [String:(left: String, right: String)] = [:]

var instrucciones: [Substring] = []

while let input = readLine() {
    if input == "" { continue }
    if input.split(separator: " ").count == 1 {
        instrucciones = input.split(separator: "")
        continue
    }
    let nodeMap = input.split(separator: " = ")
    entrada[String(nodeMap[0])] = (
        left: String(nodeMap[1].split(separator: ", ")[0].replacing("(", with: "")),
        right: String(nodeMap[1].split(separator: ", ")[1].replacing(")", with: ""))
    )
}

var currentLocations: [String] = entrada.keys.filter { $0.last == "A" }

var steps = Array(repeating: 0, count: currentLocations.count)

for i in 0..<currentLocations.count {
    var location = currentLocations[i]
    while location.last != "Z" {
        if instrucciones[steps[i] % instrucciones.count] == "L" {
            location = entrada[location]!.left
        }
        if instrucciones[steps[i] % instrucciones.count] == "R" {
            location = entrada[location]!.right
        }
        steps[i] += 1
    }
}

func greatestCommonDivisor(num1: Int, num2: Int) -> Int {
    var i: Int

    var j = max(num1, num2)

    var k = min(num1, num2)

    while k != 0 {
        i = j
        j = k
        k = i % j
    }

    return j
}

func leastCommonMultiple(num1: Int, num2: Int) -> Int {
    return (num1 * num2 / greatestCommonDivisor(num1: num1, num2: num2))
}

print(steps.reduce(1, { m, n in leastCommonMultiple(num1: m, num2: n)}))