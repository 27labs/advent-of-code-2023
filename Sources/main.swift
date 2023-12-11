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

var seedsToPlant: [[Int]] = []

while let input = readLine() {
    if input == "" { continue }
    let line = input.split(separator: " ")
    switch(line[0]) {
        case "seeds:":
            for i in stride(from: 1, to: line.count - 1, by: 2) {
                seedsToPlant.append([Int(line[i])!, Int(line[i + 1])!])
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

// var semilla = (Int.max,0)

func mapInputsToRule(range: (start: Int, end: Int), rule: (source:Int, length: Int, destination: Int)) -> [(range:(start: Int, end: Int), inside: Bool)] {
    if range.start > rule.source + rule.length {
        return [(range: range, inside: false)]
    }
    if range.start >= rule.source && range.end <= rule.source + rule.length {
        // let newSource = range.0
        // let newLength = range.1 - range.0
        // let newDestination = rule.destination + range.0 - rule.source
        // return [(ranges: [range], rule: (source: newSource, length: newLength, destination: newDestination))]
        let newStart = rule.destination + range.start - rule.source
        let newEnd = newStart + range.end - range.start
        return [(range: (start: newStart, end: newEnd), inside: true)]
    }
    if range.start >= rule.source && range.end > rule.source + rule.length {
        let newStart = rule.destination + range.start - rule.source
        let newEnd = rule.destination + rule.length
        let spill = range.end - rule.source - rule.length
        return [(range: (start: newStart, end: newEnd), inside: true), (range: (start: range.end - spill, end: range.end), inside: false)]
    }
    if range.start < rule.source && range.end > rule.source + rule.length {
        let fill = rule.source - range.start
        let newStart = rule.destination
        let newEnd = rule.destination + rule.length
        let spill = range.end - rule.source - rule.length
        return [(range: (start: range.start, end: range.start + fill), inside: false), (range: (start: newStart, end: newEnd), inside: true), (range: (start: range.end - spill, end: range.end), inside: false)]
    }
    if range.start < rule.source && range.end >= rule.source {
        let fill = rule.source - range.start
        let newStart = rule.destination
        let newEnd = rule.destination + range.end - rule.source
        return [(range: (start: range.start, end: range.start + fill), inside: false), (range: (start: newStart, end: newEnd), inside: true)]
    }
    return [(range: range, inside: false)]
}

func spreadRange(range: (Int,Int), rules: [(source: Int, length: Int, destination: Int)]) -> [(Int,Int)] {
    var ranges = [(range: (start: range.0, end: range.1), inside: false)]
    
    for rule in rules {
        let ranges2 = (ranges.filter {
            !$0.inside
        }).map {
            $0.range
        }
        for i in 0..<ranges2.count {
            let subRange = ranges2[i]
            ranges.remove(at: ranges.firstIndex(where: {
                $0.range.start == subRange.start && $0.range.end == subRange.end && $0.inside == false
            })!)
            ranges += mapInputsToRule(range: subRange, rule: rule)
        }
    }

    return ranges.map {
        $0.range
    }
}

func rangeFilter(rules: [(source: Int, length: Int, destination: Int)], inputRange: [(start: Int, end: Int)]) -> [(start: Int,end: Int)] {

    var newInputs: [(start: Int, end: Int)] = []

    for range in inputRange {
        newInputs += spreadRange(range: range, rules: rules)
    }

    return newInputs
}

func locationFinder(seedRanges: [(start: Int, end: Int)]) -> Int {
    var input = seedRanges
    for mapIndex in 0...Maps.lugares.rawValue {
        input = rangeFilter(rules: (entrada[mapIndex].map {
            (source: $0[1], length: $0[2], destination: $0[0])
        }), inputRange: input)
    }
    return ((input.map {
        $0.start
    }).sorted {
        $0 < $1
    }).first ?? Int.max
}

print(locationFinder(seedRanges: seedsToPlant.map { (start: $0[0], end: $0[0] + $0[1]) }))