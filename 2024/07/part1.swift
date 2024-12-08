import Foundation

class Equation {
	let nums: [Int]
	var ops: [Bool]!
	init(_ a: [Int]) {
		nums = a
		ops = [Bool].init(repeating: true, count: nums.count - 1)
	}
	func reduce() -> Int {
		var result = nums.first!
		for i in 1..<nums.count {
			if ops[i-1] {
				result += nums[i]
			} else {
				result *= nums[i]
			}
		}
		return result
	}
}

var input = (try! String(contentsOfFile: CommandLine.arguments[1])).split(separator: "\n").map { (line) -> (Int, Equation) in
	let parts = line.split(separator: ":")
	return (Int(parts.first!)!, Equation(parts[1].split(separator: " ").map { Int($0)! }))
}.filter { (eq) -> Bool in
	let combinations = 2 << (eq.1.nums.count - 1)
	if eq.0 == eq.1.reduce() { return true }
	for i in 0..<combinations {
		for j in 0..<(eq.1.nums.count - 1) {
			eq.1.ops[j] = (i & (1 << j)) != 0
		}
		if eq.0 == eq.1.reduce() { return true }
	}
	return false
}

print(input.reduce(0) { $0 + $1.0 })
