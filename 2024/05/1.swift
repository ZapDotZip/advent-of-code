import Foundation

let input = try! String(contentsOfFile: CommandLine.arguments[1])
let tmp = input.components(separatedBy: "\n\n")
let rules = tmp[0].split(separator: "\n").map { (str) -> [Int] in
	return str.split(separator: "|").map { Int($0)! }
}
let result = tmp[1].split(separator: "\n").map { (str) -> [Int] in
	return str.split(separator: ",").map { Int($0)! }
}.filter { (update) -> Bool in
	for rule in rules {
		let before = rule.first!
		let after = rule.last!
		var safe = false
		for i in update {
			if (!safe && update.contains(before)) && i == after {
				return false
			} else if i == before {
				safe = true
			}
		}
	}
	return true
}.reduce(0) {
	$0 + $1[$1.count/2]
}

print(result)

