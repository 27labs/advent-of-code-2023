// The Swift Programming Language
// https://docs.swift.org/swift-book

var symbolHitboxesXY: Set<String> = []
var numberHitboxesXY: [String:String] = [:]

var lineIndex = 0

var ocurrence = 0

while let input = readLine() {
    let splitted = input.split(separator: "")
    var index = 0
    var coordenadas: Set<String> = []
    var numero = ""
    for character in splitted {
        if !["0","1","2","3","4","5","6","7","8","9","."].contains(character) {
             symbolHitboxesXY.update(with: "\(index-1) \(lineIndex-1)")
             symbolHitboxesXY.update(with: "\(index) \(lineIndex-1)")
             symbolHitboxesXY.update(with: "\(index+1) \(lineIndex-1)")
             symbolHitboxesXY.update(with: "\(index-1) \(lineIndex)")
             symbolHitboxesXY.update(with: "\(index+1) \(lineIndex)")
             symbolHitboxesXY.update(with: "\(index-1) \(lineIndex+1)")
             symbolHitboxesXY.update(with: "\(index) \(lineIndex+1)")
             symbolHitboxesXY.update(with: "\(index+1) \(lineIndex+1)")
             numero = ""
             coordenadas = []
        } else if character != "." {
            coordenadas.update(with: "\(index) \(lineIndex)")
            if numero == "" {
                numero += "\(ocurrence) "
                ocurrence += 1
            }
            numero += character
            for par in coordenadas {
                numberHitboxesXY[par]=numero
            }
        } else {
            numero=""
            coordenadas=[]
        }
        index += 1
    }
    lineIndex += 1
}

var numeros: Set<String> = []

for hitbox in symbolHitboxesXY {
    numeros.update(with: numberHitboxesXY[hitbox] ?? "0 0")
}

print(numeros.reduce(0, {m, n in m + (Int(n.split(separator: " ")[1]) ?? 0)}))