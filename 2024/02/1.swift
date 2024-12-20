import Foundation

let data = try! String(contentsOfFile: CommandLine.arguments[1])
let lines: [[Int]] = data.split(separator: "\n").map { (str) -> [Int] in
	return str.split(separator: " ").map { (slice) -> Int in
		Int(slice)!
	}
}

/// Returns true if it's unsafe
func check(_ a: Int, _ b: Int, _ isIncreasing: Bool) -> Bool {
	let diff = abs(a - b)
	return diff < 1 || diff > 3 || (a - b > 0) == isIncreasing
}

/// Returns true if it's unsafe
func isSafe(_ arr: [Int]) -> Bool {
	var last = arr.first!
	let isIncreasing = last - arr[1] > 0
	for i in arr[1...arr.count-1] {
		if check(i, last, isIncreasing) {
			return false
		}
		last = i
	}
	return true
}

var safeCount = 0
for line in lines {
	if isSafe(line) {
		safeCount += 1
	}
}

print(safeCount)
