// The Swift Programming Language
// https://docs.swift.org/swift-book

var entrada: Array<Array<String>> = []

while let input = readLine() {
    let numbers = input.split(separator: "").filter {["0","1","2","3","4","5","6","7","8","9"].contains( $0 )}
    entrada.append( [String(numbers.first ?? "0"), String(numbers.last ?? "0")] )
}

var salida: Int = 0

for par in entrada {
    salida += Int(par[0] + par[1]) ?? 0
}

print(salida)