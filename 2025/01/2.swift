import Foundation
var input = (try! String(contentsOfFile: CommandLine.arguments[1]))

var dial = 50
var answer = 0

var lastDialWasZero = false
for var line in input.split(separator: "\n") {
	let direction = line.popFirst()!
	let amt = Int(line)!
	let spins = amt / 100
	let diff = amt % 100
	answer += spins
	if direction == "L" {
		dial = dial - diff
	} else {
		dial = dial + diff
	}
	if dial < 0 {
		if !lastDialWasZero {
			answer += 1
			lastDialWasZero = false
		}
		dial = 100 - -dial
	} else if dial > 99 {
		if !lastDialWasZero {
			answer += 1
			lastDialWasZero = false
		}
		dial = dial - 100
	} else if dial == 0 {
		answer += 1
	}
	if dial == 0 {
		lastDialWasZero = true
	} else {
		lastDialWasZero = false
	}
}
print(answer)
