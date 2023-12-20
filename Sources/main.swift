// The Swift Programming Language
// https://docs.swift.org/swift-book

var entrada: [Int: [[Substring]?]] = [:]

enum MirrorOrientation {
    case vertical
    case horizontal
}

var i = 0
var note = 0
var matches = 0
var matchList: [Int:(MirrorOrientation,Int)?] = [:]
while let input = readLine() {
    let line = input.split(separator: "")
    if line.count == 0 {
        if matches > 0 {
            matchList[note] = (MirrorOrientation.horizontal, i - matches)
        }
        note += 1
        i = 0
        matches = 0
        continue
    }
    if i - (matches * 2 + 1) >= 0 {
        if entrada[note]![i - (matches * 2 + 1)] == line {
            matches += 1
        } else {
            matches = 0
        }
    } else if i > 0 {
        matches += 1
    }
    if entrada[note] != nil {
        entrada[note]!.append(line)
    } else {
        entrada[note] = [line]
    }
    i += 1
}

if matches > 0 {
    matchList[note] = (MirrorOrientation.horizontal, i - matches)
}

for noteIndex in 0..<entrada.count {
    if matchList[noteIndex] != nil { continue }
    var transpuesta: [[Substring]?] = []
    var matches2 = 0
    for column in 0..<entrada[noteIndex]![0]!.count {
        var columna: [Substring] = []
        for line in entrada[noteIndex]! {
            columna.append(line![column])
        }
        if column - matches2 * 2 - 1 >= 0 {
            if transpuesta[column - matches2 * 2 - 1]! == columna {
                matches2 += 1
            } else {
                matches2 = 0
            }
        } else if column > 0 {
            matches2 += 1
        }
        transpuesta.append(columna)
    }
    if matches2 > 0 {
        matchList[noteIndex] = (MirrorOrientation.vertical, entrada[noteIndex]![0]!.count - matches2)
    }
}

print(matchList.reduce(0, { r, kv in
    kv.value!.0 == MirrorOrientation.horizontal ? r + kv.value!.1 * 100 : r + kv.value!.1
}
))