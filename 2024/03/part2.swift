import Foundation

let input = try! String(contentsOfFile: CommandLine.arguments[1])
var enabled = true
let result = (try! NSRegularExpression.init(pattern: "(?<do>do\\(\\))|(?<dont>don't\\(\\))|(mul\\((?<a>\\d+),(?<b>\\d+)\\))", options: [])).matches(in: input, options: [], range: NSRange(input.startIndex..., in: input)).reduce(0) {
	if let _ = Range.init($1.range(withName: "do"), in: input) {
		enabled = true
	}
	if let _ = Range.init($1.range(withName: "dont"), in: input) {
		enabled = false
	}
	
	if enabled, let a = Range.init($1.range(withName: "a"), in: input) {
		if let b = Range.init($1.range(withName: "b"), in: input) {
			return $0 + Int(input[a])! * Int(input[b])!
		}
	}
	return $0
}

print(result)
