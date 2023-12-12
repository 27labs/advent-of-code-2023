// The Swift Programming Language
// https://docs.swift.org/swift-book

var entrada: [[Int]] = []

func getHandType(cards: [Substring]) -> Int {
    var cardRepeats: [Substring:Int] = [:]
    for card in cards {
        cardRepeats[card] = (cardRepeats[card] ?? 0) + 1
    }
    switch(cardRepeats.count) {
        case 1:
            return 7
        case 2:
            if (cardRepeats.sorted(by: {m, n in m.value > n.value}).first!.value) > 3 {
                return 6
            }
            return 5
        case 3:
            if (cardRepeats.sorted(by: {m, n in m.value > n.value}).first!.value) > 2 {
                return 4
            }
            return 3
        case 4:
            return 2
        default:
            return 1
    }
}

while let input = readLine() {
    let hand = input.split(separator: " ")
    let handCards = hand[0].split(separator: "")
    let handType = getHandType(cards: handCards)
    var handValue = Array(repeating: 100, count: handCards.count).reduce(handType, *)
    for i in 1...handCards.count {
        switch(handCards[i-1]) {
            case "A":
                handValue += Array(repeating: 100, count: (handCards.count - i)).reduce(14,*)
            case "K":
                handValue += Array(repeating: 100, count: (handCards.count - i)).reduce(13,*)
            case "Q":
                handValue += Array(repeating: 100, count: (handCards.count - i)).reduce(12,*)
            case "J":
                handValue += Array(repeating: 100, count: (handCards.count - i)).reduce(11,*)
            case "T":
                handValue += Array(repeating: 100, count: (handCards.count - i)).reduce(10,*)
            default:
                handValue += Array(repeating: 100, count: (handCards.count - i)).reduce((Int(handCards[i-1]) ?? 0),*)
        }
    }
    let bid = Int(hand[1]) ?? 0
    entrada.append([handValue, bid])
}

entrada.sort {
    m, n in m[0] > n[0]
}

var winnings = 0

for i in 0..<entrada.count {
    winnings += entrada[i][1] * (entrada.count - i)
}

print(winnings)