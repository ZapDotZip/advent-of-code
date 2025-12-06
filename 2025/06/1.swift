import Foundation
let input = (try! String(contentsOfFile: CommandLine.arguments[1])).split(separator: "\n")

let operations = input.last!.split(separator: " ")
let numbersGrid = input.dropLast().map { line in
	line.split(separator: " ").map({ Int($0)! })
}

var grandTotal = 0

for (i, operation) in operations.enumerated() {
	var columnTotal = 0
	var doOp = { (num: Int) -> Void in
		columnTotal += num
	}
	if operation == "*" {
		columnTotal = 1
		doOp = { (num: Int) -> Void in
			columnTotal *= num
		}
	}
	numbersGrid.forEach { line in
		doOp(line[i])
	}
	grandTotal += columnTotal
}

print(grandTotal)
