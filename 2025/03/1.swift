import Foundation
var input = (try! String(contentsOfFile: CommandLine.arguments[1]))

let total = input.split(separator: "\n").reduce(0, { total, bank in
	let batteries = Array(bank)
	var largest = 0
	var startIndex = 0
	for (index, battery) in batteries.dropLast().enumerated() {
		let bat = Int("\(battery)")!
		if bat > largest {
			largest = bat
			startIndex = index
		}
	}
	var nextLargest = 0
	for battery in batteries.dropFirst(startIndex + 1) {
		let bat = Int("\(battery)")!
		if bat > nextLargest {
			nextLargest = bat
		}
	}
	let bankTotal = Int(String(largest) + String(nextLargest))!
	return total + bankTotal
})

print(total)
