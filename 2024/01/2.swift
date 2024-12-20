import Cocoa

let data = try! String(contentsOfFile: CommandLine.arguments[1])
let lines = data.split(separator: "\n")

let left = lines.map { (substr) -> Int in
	return Int(substr.split(separator: " ").first!)!
}

var rightCounts: [Int: Int] = [:]
lines.forEach { (str) in
	let num = Int(str.split(separator: " ").last!)!
	rightCounts[num, default: 0] += 1
}

var sum = 0;
for lval in left {
	if let rightCount = rightCounts[lval] {
		sum += (lval * rightCount)
	}
}

print(sum)
