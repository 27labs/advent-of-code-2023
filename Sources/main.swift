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

var currentLocation = "AAA"

var steps = 0

while currentLocation != "ZZZ" {
        if instrucciones[steps % instrucciones.count] == "L" {
            currentLocation = entrada[currentLocation]!.left
        }
        if instrucciones[steps % instrucciones.count] == "R" {
            currentLocation = entrada[currentLocation]!.right
        }
    steps += 1
}

print(steps)