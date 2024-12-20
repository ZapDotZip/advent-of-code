import Foundation

enum Operation { case add, multiply, combo }
class Equation {
	let nums: [Int]
	var ops: [Operation]!
	init(_ a: [Int]) {
		nums = a
		ops = [Operation].init(repeating: .add, count: nums.count - 1)
	}
	func reduce() -> Int {
		var result = nums.first!
		for i in 1..<nums.count {
			if case .add = ops[i-1] {
				result += nums[i]
			} else if case .multiply = ops[i-1] {
				result *= nums[i]
			} else {
				result = Int("\(result)\(nums[i])")!
			}
		}
		return result
	}
}

var input = (try! String(contentsOfFile: CommandLine.arguments[1])).split(separator: "\n").map { (line) -> (Int, Equation) in
	let parts = line.split(separator: ":")
	return (Int(parts.first!)!, Equation(parts[1].split(separator: " ").map { Int($0)! }))
}.filter { (eq) -> Bool in
	eq.1.pr(eq.0)
	let combinations = Int(pow(3.0, Double(eq.1.nums.count - 1)))
	if eq.0 == eq.1.reduce() { return true }
	for i in 0..<combinations {
		for j in 0..<(eq.1.nums.count - 1) {
			switch ((i / Int(pow(3.0, Double(j)))) % 3) {
			case 0:
				eq.1.ops[j] = .add
			case 1:
				eq.1.ops[j] = .multiply
			case 2:
				eq.1.ops[j] = .combo
			default:
				exit(1)
			}
		}
		if eq.0 == eq.1.reduce() { return true }
	}
	return false
}

print(input.reduce(0) { $0 + $1.0 })
