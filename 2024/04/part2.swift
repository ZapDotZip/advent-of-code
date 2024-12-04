import Foundation

let input = try! String(contentsOfFile: CommandLine.arguments[1])
let lineLen = input.split(separator: "\n").first!.count

print([
	"(?=M.S.{\(lineLen-1)}A.{\(lineLen-1)}M.S)",
	"(?=S.M.{\(lineLen-1)}A.{\(lineLen-1)}S.M)",
	"(?=M.M.{\(lineLen-1)}A.{\(lineLen-1)}S.S)",
	"(?=S.S.{\(lineLen-1)}A.{\(lineLen-1)}M.M)",
	].reduce(0) {
		$0 + (try! NSRegularExpression.init(pattern: $1, options: [.dotMatchesLineSeparators])).matches(in: input, options: [], range: NSRange(input.startIndex..., in: input)).count
})
