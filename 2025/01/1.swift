import Foundation
var input = (try! String(contentsOfFile: CommandLine.arguments[1]))

var dial = 50
var answer = 0

for var line in input.split(separator: "\n") {
	let direction = line.popFirst()!
	let amt = Int(line)!
	if direction == "L" {
		dial = dial - amt
		while dial < 0 {
			dial = 100 - abs(dial)
		}
	} else {
		dial = dial + amt
		while dial > 99 {
			dial = dial - 100
		}
	}
	if dial == 0 {
		answer += 1
	}
}
print(answer)
