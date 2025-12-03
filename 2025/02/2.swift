import Foundation
var input = (try! String(contentsOfFile: CommandLine.arguments[1])).replacingOccurrences(of: "\n", with: "")

func isIDInvalid(id: Int) -> Bool {
	let arr = Array("\(id)")
	let halfway = arr.count / 2
	for sliceCount in stride(from: halfway, through: 1, by: -1) {
		if arr.count % sliceCount == 0 {
			let segments = stride(from: 0, to: arr.count, by: sliceCount).map { i in
				let segEnd = i + sliceCount
				return (arr[i..<(segEnd)])
			}
			let firstValue = segments.first!
			if segments.allSatisfy({ $0 == firstValue }) {
				return true
			}
		}
	}
	return false
}

var total = 0
for inputRange in input.split(separator: ",") {
	let inputRangeParts = inputRange.split(separator: "-")
	let range = Int(inputRangeParts.first!)!...Int(inputRangeParts.last!)!
	total += range.reduce(0) { partialResult, id in
		if isIDInvalid(id: id) {
			return partialResult + id
		}
		return partialResult
	}
}

print(total)
