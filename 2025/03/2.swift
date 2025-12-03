import Foundation
var input = (try! String(contentsOfFile: CommandLine.arguments[1]))

let count = 12

let total = input.split(separator: "\n").reduce(0, { partialResult, bank in
	let batteries: [Substring.Element] = Array(bank)
	var largest = Array(repeating: 0, count: count)
	var startIndex = Array(repeating: 0, count: count + 1)
	var i = 0
	for limit in stride(from: count-1, to: -1, by: -1) {
		for (index, battery) in batteries.dropLast(limit).dropFirst(startIndex[i]).enumerated() {
			let bat = Int("\(battery)")!
			if bat > largest[i] {
				largest[i] = bat
				startIndex[i+1] = index + startIndex[i] + 1
			}
		}
		i += 1
	}
	let bankTotal = Int(largest.reduce("", { String($0) + String($1) }))!
	return total + bankTotal
})

print(total)
