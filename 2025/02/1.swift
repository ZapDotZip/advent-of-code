import Foundation
var input = (try! String(contentsOfFile: CommandLine.arguments[1])).replacingOccurrences(of: "\n", with: "")

var total = 0

for range in input.split(separator: ",") {
	let r = range.split(separator: "-")
	
	for id in Int(r.first!)!...Int(r.last!)! {
		let str = "\(id)"
		if str.count % 2 == 0 {
			let halfway = str.count / 2
			let firstHalf = Array(str.utf8CString[..<halfway])
			let secondHalf = Array(str.utf8CString[halfway...])
			if firstHalf == secondHalf.dropLast() {
				total += id
			}
		}
	}
}

print(total)
