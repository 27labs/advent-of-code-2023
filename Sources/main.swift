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

var tuberiasXY: [String:(Direcciones,Direcciones)] = [:]

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
            tuberiasXY["\(j) \(i)"] = (conexiones[0],conexiones[1])
            continue
        }
        switch(entrada[i][j]) {
            case "|": tuberiasXY["\(j) \(i)"] = (Direcciones.norte,Direcciones.sur)
            case "-": tuberiasXY["\(j) \(i)"] = (Direcciones.este, Direcciones.oeste)
            case "L": tuberiasXY["\(j) \(i)"] = (Direcciones.norte, Direcciones.este)
            case "J": tuberiasXY["\(j) \(i)"] = (Direcciones.norte, Direcciones.oeste)
            case "7": tuberiasXY["\(j) \(i)"] = (Direcciones.sur, Direcciones.oeste)
            case "F": tuberiasXY["\(j) \(i)"] = (Direcciones.este, Direcciones.sur)
            default: continue
        }
    }
}

var paso = (inicioXY,inicioXY)

var navegadas: Set<String> = []

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

print(paso)
print("----")

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

    print(paso)

    if navegadas.contains(siguienteA) || navegadas.contains(siguienteB) { break }

    navegadas.update(with: siguienteA)
    navegadas.update(with: siguienteB)

    pasos += 1
}

print(pasos)