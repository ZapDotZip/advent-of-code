import Foundation
let input = (try! String(contentsOfFile: CommandLine.arguments[1])).split(separator: "\n\n")

let freshRanges = input.first!.split(separator: "\n").map({ line in
	let rangeParts = line.split(separator: "-")
	return Int(rangeParts.first!)!...Int(rangeParts.last!)!
})

let ingredientIDs = input.last!.split(separator: "\n").map({ Int($0)! })

let total = ingredientIDs.reduce(0, { partialResult, id in
	for range in freshRanges {
		if range.contains(id) {
			return partialResult + 1
		}
	}
	return partialResult
})

print(total)
