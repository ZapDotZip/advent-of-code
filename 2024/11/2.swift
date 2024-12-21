import Foundation
var input = (try! String(contentsOfFile: CommandLine.arguments[1])).replacingOccurrences(of: "\n", with: "").split(separator: " ").map { Int(String($0))! }

func blink(_ counts: inout [Int : Int]) -> [Int : Int]{
	var counts2: [Int : Int] = [:]
	counts.forEach {
		let str = String($0.key)
		if $0.key == 0 {
			counts2[1, default: 0] += $0.value
		} else if str.count % 2 == 0 {
			let halfindex = String.Index(encodedOffset: str.count / 2)
			counts2[Int(str[str.startIndex..<halfindex])!, default: 0] += $0.value
			counts2[Int(str[halfindex..<str.endIndex])!, default: 0] += $0.value
		} else {
			counts2[$0.key * 2024, default: 0] += $0.value
		}
	}
	return counts2
}

var counts: [Int : Int] = [:]
input.forEach {
	counts[$0, default: 0] += 1
}
for _ in 1...75 {
	counts = blink(&counts)
}
print(counts.values.reduce(0) { $0 + $1 })
