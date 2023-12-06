// The Swift Programming Language
// https://docs.swift.org/swift-book

var entrada: Array<Array<String>> = []

while let input = readLine() {
    var stepped = ""
    for character in input.split(separator: "") {
        stepped += character
        stepped.replace("one", with: "1e")
        stepped.replace("two", with: "2o")
        stepped.replace("three", with: "3e")
        stepped.replace("four", with: "4r")
        stepped.replace("five", with: "5e")
        stepped.replace("six", with: "6x")
        stepped.replace("seven", with: "7n")
        stepped.replace("eight", with: "8t")
        stepped.replace("nine", with: "9e")
    }

    // print(stepped)
    
    let numbers = stepped.filter {["1","2","3","4","5","6","7","8","9"].contains( $0 )}
    entrada.append( [String(numbers.first ?? " "), String(numbers.last ?? " ")] )
}

// print(entrada)

var salida: Int = 0

for par in entrada {
    salida += Int(par[0] + par[1]) ?? 0
}

print(salida)