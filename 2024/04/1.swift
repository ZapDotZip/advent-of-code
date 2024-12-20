import Foundation

let input = try! String(contentsOfFile: CommandLine.arguments[1])
let lineLen = input.split(separator: "\n").first!.count
let regexes = [
	"XMAS", // horizonal
	"SAMX", // horizonal reverse
	"(?=X.{\(lineLen)}M.{\(lineLen)}A.{\(lineLen)}S)", // vertical
	"(?=S.{\(lineLen)}A.{\(lineLen)}M.{\(lineLen)}X)", // vertical reverse
	"(?=X.{\(lineLen+1)}M.{\(lineLen+1)}A.{\(lineLen+1)}S)", // diagonal forwards
	"(?=S.{\(lineLen+1)}A.{\(lineLen+1)}M.{\(lineLen+1)}X)", // diagonal forwards reverse
	"(?=X.{\(lineLen-1)}M.{\(lineLen-1)}A.{\(lineLen-1)}S)", // diagonal backwards
	"(?=S.{\(lineLen-1)}A.{\(lineLen-1)}M.{\(lineLen-1)}X)", // diagonal backwards reverse
]

let result = regexes.reduce(0) {
	$0 + (try! NSRegularExpression.init(pattern: $1, options: [.dotMatchesLineSeparators])).matches(in: input, options: [], range: NSRange(input.startIndex..., in: input)).count
}

print(result)
