import Foundation

let data = try! String(contentsOfFile: CommandLine.arguments[1])
let lines: [[Int]] = data.split(separator: "\n").map { (str) -> [Int] in
	return str.split(separator: " ").map { (slice) -> Int in
		Int(slice)!
	}
}

var safeCount = 0
for line in lines {
	var safe = true
	var last = line.first!
	let isIncreasing = last - line[1] > 0
	for i in line[1...line.count-1] {
		let incDec = i - last > 0
		let diff = abs(i - last)
		if diff < 1 || diff > 3 || incDec == isIncreasing {
			safe = false
		}
		last = i
	}
	if safe {
		safeCount += 1
	}
}

print(safeCount)
