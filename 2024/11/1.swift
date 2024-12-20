import Foundation
var input = (try! String(contentsOfFile: CommandLine.arguments[1])).replacingOccurrences(of: "\n", with: "").split(separator: " ").map { Int(String($0))! }

func blink() {
	var i = 0
	while i < input.count {
		if input[i] == 0 {
			input[i] = 1
		} else if String(input[i]).count % 2 == 0 {
			let str = String(input[i])
			let halfindex = String.Index(encodedOffset: str.count / 2)
			input[i] = Int(str[str.startIndex..<halfindex])!
			input.insert(Int(str[halfindex..<str.endIndex])!, at: i+1)
			i += 1
		} else {
			input[i] = input[i] * 2024
		}
		i += 1
	}
}

for _ in 1...25 {
	blink()
}
print(input.count)
