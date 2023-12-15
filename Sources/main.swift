// The Swift Programming Language
// https://docs.swift.org/swift-book

var entrada: [[(Int,Int)?]] = []

var y = 0
var width = 0
var offset = 0
while let input = readLine() {
    if width == 0 {
        width = input.count
    }
    entrada.append(Array(repeating: nil, count: width))
    if !input.contains("#") {
        offset += 1000000 - 1
        y += 1
        continue
    }
    var x = 0
    for casilla in input.split(separator: "") {
        if casilla == "#" {
            entrada[y][x] = (x,y + offset)
        }
        x += 1
    }
    y += 1
}

var transpuesta: [(Int,Int)] = []

offset = 0
for indice in 0..<width {
    let columna = entrada.map {
        if $0[indice] != nil {
            ($0[indice]!.0 + offset,$0[indice]!.1)
        } else {
            $0[indice]
        }
    }
    let expandidas = columna.compactMap {
        $0
    }
    if expandidas.count > 0 {
        transpuesta.append(contentsOf: expandidas)
        continue
    }
    offset += 1000000 - 1
}

func calcularDistancia(_ galaxia1: (Int,Int), _ galaxia2: (Int,Int)) -> Int {
    let x1 = min(galaxia1.0,galaxia2.0)
    let x2 = max(galaxia1.0,galaxia2.0)

    let y1 = min(galaxia1.1,galaxia2.1)
    let y2 = max(galaxia1.1,galaxia2.1)

    return x2 - x1 + y2 - y1
}

var suma = 0

while transpuesta.count > 1 {
    for galaxia in transpuesta[1...] {
        suma += calcularDistancia(transpuesta[0],galaxia)
    }
    transpuesta = Array(transpuesta[1...])
}

print(suma)