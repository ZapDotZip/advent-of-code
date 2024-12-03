import Foundation

let input = try! String(contentsOfFile: CommandLine.arguments[1])
let result = (try! NSRegularExpression.init(pattern: "mul\\((\\d+),(\\d+)\\)")).matches(in: input, options: [], range: NSRange(input.startIndex..., in: input)).reduce(0) {
	$0 + Int(input[Range($1.range(at: 1), in: input)!])! * Int(input[Range($1.range(at: 2), in: input)!])!
}
print(result)
