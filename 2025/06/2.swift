import Foundation
let input = (try! String(contentsOfFile: CommandLine.arguments[1])).split(separator: "\n")

let operations: [Substring] = input.last!.split(separator: " ").reversed()
let inputGrid: [[Substring.Element]] = input.dropLast().map({ $0.map({ $0 }).reversed() })
var rotated = Array(repeating: Array(repeating: Character("#"), count: inputGrid.count), count: inputGrid.first!.count)

for i in 0..<inputGrid.count {
	for j in 0..<inputGrid[i].count {
		rotated[j][i] = inputGrid[i][j]
	}
}

let numbersGrid = rotated.map({ line in
	Int(String(line).replacingOccurrences(of: " ", with: ""))
}).split(separator: nil).map({ $0.compactMap({ $0 }) })

var grandTotal = 0

for (i, operation) in operations.enumerated() {
	if operation == "+" {
		let columnTotal = numbersGrid[i].reduce(0, { $0 + $1 })
		grandTotal += columnTotal
	} else if operation == "*" {
		let columnTotal = numbersGrid[i].reduce(1, { $0 * $1 })
		grandTotal += columnTotal
	}
}

print(grandTotal)
