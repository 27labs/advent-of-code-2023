// The Swift Programming Language
// https://docs.swift.org/swift-book

var numberHitboxesXY: [String:String] = [:]
var starsXY: [String:[String]] = [:]

var lineIndex = 0

var ocurrence = 0

while let input = readLine() {
    let splitted = input.split(separator: "")
    var index = 0
    var coordenadas: Set<String> = []
    var numero = ""
    for character in splitted {
        if !["0","1","2","3","4","5","6","7","8","9",".","*"].contains(character) {
             numero = ""
             coordenadas = []
        } else if ![".","*"].contains(character) {
            coordenadas.update(with: "\(index) \(lineIndex)")
            if numero == "" {
                numero += "\(ocurrence) "
                ocurrence += 1
            }
            numero += character
            for par in coordenadas {
                numberHitboxesXY[par]=numero
            }
        } else if character == "*" {
            // print("*")
            starsXY["\(index) \(lineIndex)"] = [
                "\(index-1) \(lineIndex-1)", 
                "\(index) \(lineIndex-1)", "\(index+1) \(lineIndex-1)", 
                "\(index-1) \(lineIndex)",
                "\(index+1) \(lineIndex)",
                "\(index-1) \(lineIndex+1)",
                "\(index) \(lineIndex+1)",
                "\(index+1) \(lineIndex+1)"
                ]
            numero=""
            coordenadas=[]
        } else {
            numero=""
            coordenadas=[]
        }
        index += 1
    }
    lineIndex += 1
}

var numeros: Set<String> = []

// print(starsXY)

// print("pre")

for star in starsXY {
    // print("in")
    let hitbox = Set(star.value)
    let posibles = hitbox.intersection(numberHitboxesXY.keys)
    // print(posibles)
    var numbers: Set<String> = []
    for box in posibles {
        numbers.update(with: numberHitboxesXY[box] ?? "0 0")
    }
    if numbers.count == 2 {
        let gearValues = Array(numbers)

        let id = gearValues[0].split(separator: " ")[0]

        let numero1 = Int(gearValues[0].split(separator: " ")[1]) ?? 1
        
        let numero2 = Int(gearValues[1].split(separator: " ")[1]) ?? 1

        numeros.update(with: "\(id) \(numero1 * numero2)")
    }
    // print("out")
}

// print("post")

print(numeros.reduce(0, {m, n in m + (Int(n.split(separator: " ")[1]) ?? 0)}))