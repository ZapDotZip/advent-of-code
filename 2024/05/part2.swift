import Foundation

let input = try! String(contentsOfFile: CommandLine.arguments[1])
let tmp = input.components(separatedBy: "\n\n")
let rules = tmp[0].split(separator: "\n").map { (str) -> [Int] in
	return str.split(separator: "|").map { Int($0)! }
}

func check(rule: (Int, Int), update: [Int]) -> Bool {
	var safe = false
	for i in update {
		if (!safe && update.contains(rule.0)) && i == rule.1 {
			return false
		} else if i == rule.0 {
			safe = true
		}
	}
	return true
}

print(tmp[1].split(separator: "\n").map { (str) -> [Int] in
	return str.split(separator: ",").map { Int($0)! }
}.reduce(0) {
	for rule in rules {
		if !check(rule: (rule[0], rule[1]), update: $1) {
			return $0 + $1.sorted { (a, b) -> Bool in
				return !rules.contains(where: { $0[0] == b && $0[1] == a })
				}[$1.count/2]
		}
	}
	return $0
})
