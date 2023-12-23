// The Swift Programming Language
// https://docs.swift.org/swift-book

var entrada: [Int: [[Substring]]] = [:]

enum MirrorOrientation {
    case vertical
    case horizontal
}

func compareLines(actual: [Substring], smudged: [Substring]) -> Bool? {
    if actual == smudged { return false }
    for index in 0..<smudged.count {
        let possible: [Substring]
        if smudged[index] == "." {
            if index <= 0 {
                possible = ["#"] + smudged[1...]
            } else if index >= smudged.count - 1 {
                possible = smudged[..<index] + ["#"]
            } else {
                possible = smudged[0..<index] + ["#"] + smudged[(index + 1)...]
            }
        } else {
            if index <= 0 {
                possible = ["."] + smudged[1...]
            } else if index >= smudged.count - 1 {
                possible = smudged[..<index] + ["."]
            } else {
                possible = smudged[0..<index] + ["."] + smudged[(index + 1)...]
            }
        }
        if actual == possible { return true }
    }
    return nil
}

var note = 0
while let input = readLine() {
    if input == "" {
        note += 1
        continue
    }
    if entrada[note] == nil {
        entrada[note] = [input.split(separator: "")]
    } else {
        entrada[note]!.append(input.split(separator: ""))
    }
}

func fixSmudge(_ note: [[Substring]]) -> Int? {
    var i = 1
    var savepoints: [(Int, Int, Bool)] = [(0,0,false)]
    var deadends: Set<Int> = [0]

    while i < note.count {
        if !deadends.contains(i) && !savepoints.last!.2 {
            if let smudgeFound = compareLines(actual: note[i - 1], smudged: note[i]) {
                savepoints.append((i,1,smudgeFound))
                i += 1
                continue
            }
        }

        if i - (savepoints.last!.1 * 2 + 1) >= 0 {
            if savepoints.last!.1 > 0 {
                if let smudgeFound = compareLines(actual: note[i - (savepoints.last!.1 * 2 + 1)], smudged: note[i]) {
                    if savepoints.last!.2 && smudgeFound {
                        let indexOfSplit = savepoints.last!.0
                        deadends.update(with: indexOfSplit)
                        if savepoints.count > 1 {
                            i = indexOfSplit
                            savepoints.removeLast()
                        } else {
                            savepoints = [(i,0,false)]
                        }
                        continue
                    }
                    savepoints[savepoints.count - 1].1 += 1
                    savepoints[savepoints.count - 1].2 = savepoints.last!.2 || smudgeFound
                } else {
                    let indexOfSplit = savepoints.last!.0
                    deadends.update(with: indexOfSplit)
                    if savepoints.count > 1 {
                        i = indexOfSplit
                        savepoints.removeLast()
                    } else {
                        savepoints = [(i,0,false)]
                    }
                    continue
                }
            } else {
                savepoints[savepoints.count - 1].0 = i
            }
        } else if i > 0 {
            if savepoints[savepoints.count - 1].2 {
                savepoints[savepoints.count - 1].1 += 1
            } else {
                savepoints[savepoints.count - 1].1 = 0
                savepoints[savepoints.count - 1].0 = i
            }
        }
        i += 1
        if i >= note.count && !savepoints.last!.2 {
            let indexOfSplit = savepoints.last!.0
            deadends.update(with: indexOfSplit)
            if savepoints.count > 1 {
                i = indexOfSplit
                savepoints.removeLast()
            }
        }
    }

    return savepoints.last!.2 ? i - savepoints.last!.1 : nil
}

func transpose(_ note: [[Substring]]) -> [[Substring]] {
    if note.count == 0 { return note }
    if note[0].count == 0 { return [[]] }

    var transposed: [[Substring]] = []

    for m in 0..<note[0].count {
        var column: [Substring] = []

        for n in 0..<note.count {
            column.append(note[n][m])
        }

        transposed.append(column)
    }

    return transposed
}

var summary = 0

for note in entrada {
    if let rowsAbove = fixSmudge(note.value) {
        summary += 100 * rowsAbove
    } else if let columnsLeft = fixSmudge(transpose(note.value)) {
        summary += columnsLeft
    }
}

print(summary)