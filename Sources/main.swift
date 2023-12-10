// The Swift Programming Language
// https://docs.swift.org/swift-book

enum Maps: Int {
case tierras = 0,
fertilizantes,
aguas,
luces,
temperaturas,
humedades,
lugares
}

var entrada: [[[Int]]] = [
    [],[],[],[],[],[],[]
]

var seedsToPlant: Set<Int> = []

while let input = readLine() {
    if input == "" { continue }
    let line = input.split(separator: " ")
    switch(line[0]) {
        case "seeds:":
            for i in 1..<line.count {
                seedsToPlant.update(with: Int(line[i])!)
            }
        case "seed-to-soil":
            while let subInput = readLine() {
                if subInput == "" {
                    break
                }
                let values = subInput.split(separator: " ")
                entrada[Maps.tierras.rawValue].append([Int(values[0])!,Int(values[1])!,Int(values[2])!])
            }
        case "soil-to-fertilizer":
            while let subInput = readLine() {
                if subInput == "" { break }
                let values = subInput.split(separator: " ")
                entrada[Maps.fertilizantes.rawValue].append([Int(values[0])!,Int(values[1])!,Int(values[2])!])

            }
        case "fertilizer-to-water":
            while let subInput = readLine() {
                if subInput == "" { break }
                let values = subInput.split(separator: " ")
                entrada[Maps.aguas.rawValue].append([Int(values[0])!,Int(values[1])!,Int(values[2])!])

            }
        case "water-to-light":
            while let subInput = readLine() {
                if subInput == "" { break }
                let values = subInput.split(separator: " ")
                entrada[Maps.luces.rawValue].append([Int(values[0])!,Int(values[1])!,Int(values[2])!])

            }
        case "light-to-temperature":
            while let subInput = readLine() {
                if subInput == "" { break }
                let values = subInput.split(separator: " ")
                entrada[Maps.temperaturas.rawValue].append([Int(values[0])!,Int(values[1])!,Int(values[2])!])

            }
        case "temperature-to-humidity":
            while let subInput = readLine() {
                if subInput == "" { break }
                let values = subInput.split(separator: " ")
                entrada[Maps.humedades.rawValue].append([Int(values[0])!,Int(values[1])!,Int(values[2])!])

            }
        case "humidity-to-location":
            while let subInput = readLine() {
                if subInput == "" { break }
                let values = subInput.split(separator: " ")
                entrada[Maps.lugares.rawValue].append([Int(values[0])!,Int(values[1])!,Int(values[2])!])

            }
        default:
            continue
    }
}

var semilla = (-1,0)

for seed in seedsToPlant {
    var lugar = seed
    var trace: [Int] = [seed]
    for map in entrada {
        for rule in (map.sorted {
            $0[1] > $1[1]
        }) {
            if lugar < rule[1] { continue }
            if lugar > rule[1] + rule[2] { break }
            lugar = lugar - rule[1] + rule[0]
            break
        }
        trace.append(lugar)
    }

    if semilla.0 < 0 {
        semilla = (lugar,seed)
    }

    if lugar < semilla.0 { semilla = (lugar,seed) }
}

print(semilla.0)