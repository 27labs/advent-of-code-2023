// The Swift Programming Language
// https://docs.swift.org/swift-book

var entrada: [[String]] = []

while let input = readLine() {
    entrada.append(input.split(separator: "").map { String($0) })
}

enum Direcciones {
    case norte
    case este
    case sur
    case oeste
}

var inicioXY = "0 0"

var tuberiasXY: [String:(Direcciones,Direcciones,String)] = [:]

func directionMap(_ direcciones: [Direcciones]) -> String {
    if direcciones.contains(Direcciones.norte) && direcciones.contains(Direcciones.sur) { return "|" }
    if direcciones.contains(Direcciones.este) && direcciones.contains(Direcciones.oeste) { return "-" }
    if direcciones.contains(Direcciones.norte) && direcciones.contains(Direcciones.este) { return "L" }
    if direcciones.contains(Direcciones.norte) && direcciones.contains(Direcciones.oeste) { return "J" }
    if direcciones.contains(Direcciones.sur) && direcciones.contains(Direcciones.oeste) { return "7" }
    return "F"
}

for i in 0..<entrada.count {
    for j in 0..<entrada.first!.count {
        if entrada[i][j] == "S" {
            inicioXY = "\(j) \(i)"
            var conexiones: [Direcciones] = []
            if i > 0 {
                if ["|","F","7"].contains(entrada[i - 1][j]) {
                    conexiones.append(Direcciones.norte)
                }
            }
            if j < entrada.first!.count - 1 {
                if ["J","-","7"].contains(entrada[i][j + 1]) {
                    conexiones.append(Direcciones.este)
                }
            }
            if i < entrada.count - 1 {
                if ["L","|","J"].contains(entrada[i + 1][j]) {
                    conexiones.append(Direcciones.sur)
                }
            }
            if j > 0 {
                if ["L","F","-"].contains(entrada[i][j - 1]) {
                    conexiones.append(Direcciones.oeste)
                }
            }
            tuberiasXY["\(j) \(i)"] = (conexiones[0],conexiones[1],directionMap(conexiones))
            continue
        }
        switch(entrada[i][j]) {
            case "|": tuberiasXY["\(j) \(i)"] = (Direcciones.norte,Direcciones.sur, "|")
            case "-": tuberiasXY["\(j) \(i)"] = (Direcciones.este, Direcciones.oeste, "-")
            case "L": tuberiasXY["\(j) \(i)"] = (Direcciones.norte, Direcciones.este, "L")
            case "J": tuberiasXY["\(j) \(i)"] = (Direcciones.norte, Direcciones.oeste, "J")
            case "7": tuberiasXY["\(j) \(i)"] = (Direcciones.sur, Direcciones.oeste, "7")
            case "F": tuberiasXY["\(j) \(i)"] = (Direcciones.este, Direcciones.sur, "F")
            default: continue
        }
    }
}

var paso = (inicioXY,inicioXY)

var navegadas: Set<String> = [inicioXY]

var pasos = 0

func calculateNextPipe(_ connection: Direcciones, _ coordinates: (Int,Int)) -> String {
    switch(connection) {
        case Direcciones.norte:
            return "\(coordinates.0) \(coordinates.1 - 1)"
        case Direcciones.este:
            return "\(coordinates.0 + 1) \(coordinates.1)"
        case Direcciones.sur:
            return "\(coordinates.0) \(coordinates.1 + 1)"
        case Direcciones.oeste:
            return "\(coordinates.0 - 1) \(coordinates.1)"
    }
}

let direccionesOpuestas = [
    Direcciones.norte: Direcciones.sur,
    Direcciones.este: Direcciones.oeste,
    Direcciones.sur: Direcciones.norte,
    Direcciones.oeste: Direcciones.este
]

var direccionAnterior = (direccionesOpuestas[tuberiasXY[inicioXY]!.0]!, direccionesOpuestas[tuberiasXY[inicioXY]!.1]!)

while true {

    var siguienteA = ""
    var siguienteB = ""

    if tuberiasXY[paso.0]!.0 == direccionesOpuestas[direccionAnterior.0] {
        let coordenadas = paso.0.split(separator: " ").map {
            Int($0)!
        }
        siguienteA = calculateNextPipe(tuberiasXY[paso.0]!.1,(coordenadas[0],coordenadas[1]))
        direccionAnterior = (tuberiasXY[paso.0]!.1, direccionAnterior.1)
    } else {
        let coordenadas = paso.0.split(separator: " ").map {
            Int($0)!
        }
        siguienteA = calculateNextPipe(tuberiasXY[paso.0]!.0, (coordenadas[0],coordenadas[1]))
        direccionAnterior = (tuberiasXY[paso.0]!.0, direccionAnterior.1)
    }
    
    if tuberiasXY[paso.1]!.0 == direccionesOpuestas[direccionAnterior.1] {
        let coordenadas = paso.1.split(separator: " ").map {
            Int($0)!
        }
        siguienteB = calculateNextPipe(tuberiasXY[paso.1]!.1, (coordenadas[0], coordenadas[1]))
        direccionAnterior = (direccionAnterior.0, tuberiasXY[paso.1]!.1)
    } else {
        let coordenadas = paso.1.split(separator: " ").map {
            Int($0)!
        }
        siguienteB = calculateNextPipe(tuberiasXY[paso.1]!.0, (coordenadas[0], coordenadas[1]))
        direccionAnterior = (direccionAnterior.0, tuberiasXY[paso.1]!.0)
    }

    paso = (siguienteA,siguienteB)

    if navegadas.contains(siguienteA) || navegadas.contains(siguienteB) { break }

    navegadas.update(with: siguienteA)
    navegadas.update(with: siguienteB)

    pasos += 1
}

var tilesInside = 0

for m in 0..<entrada.count {
    let pipes = navegadas.filter {
        Int($0.split(separator: " ")[1])! == m
    }
    let validPipes = pipes.filter {
        ["|","7","F"].contains(tuberiasXY[$0]!.2)
    }
    var boundaries = [[0,0]]
    for pipe in (pipes.sorted {
        Int($0.split(separator: " ")[0])! < Int($1.split(separator: " ")[0])!
    }) {
        if validPipes.contains(pipe) {
            let boundary = Int(pipe.split(separator: " ")[0])!
            boundaries.append([boundary,0])
        } else {
            boundaries[boundaries.count - 1][1] = boundaries[boundaries.count - 1][1] + 1
        }
    }
    for l in stride(from: 1, to: boundaries.count - 1, by: 2) {
        tilesInside += boundaries[l+1][0] - boundaries[l][0] - boundaries[l][1] - 1
    }
}

print(tilesInside)