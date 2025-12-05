import Foundation
let input = (try! String(contentsOfFile: CommandLine.arguments[1])).split(separator: "\n\n")

var freshRanges = input.first!.split(separator: "\n").map({ line in
	let rangeParts = line.split(separator: "-")
	return Int(rangeParts.first!)!...Int(rangeParts.last!)!
})

freshRanges.sort { rangeA, rangeB in
	guard rangeA.lowerBound != rangeB.lowerBound else {
		return rangeA.upperBound < rangeB.upperBound
	}
	return rangeA.lowerBound < rangeB.lowerBound
}

var lastRange = freshRanges.first!
var total = lastRange.count
freshRanges.dropFirst().forEach({ range in
	if lastRange.overlaps(range) {
		guard !(lastRange.lowerBound >= range.lowerBound && lastRange.upperBound >= range.upperBound) else { return }
		if lastRange.upperBound < range.upperBound {
			let subrange = (lastRange.upperBound+1)...range.upperBound
			total += subrange.count
			lastRange = range
		}
	} else {
		total += range.count
		lastRange = range
	}
})

print(total)
