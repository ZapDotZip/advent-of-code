import Cocoa

let path = CommandLine.arguments[1]
let data = try! String(contentsOfFile: path)
let lines = data.split(separator: "\n")
let left = lines.map { (substr) -> Int in
	return Int(substr.split(separator: " ").first!)!
}.sorted()
let right = lines.map { (substr) -> Int in
	return Int(substr.split(separator: " ").last!)!
}.sorted()

let list = zip(left, right)

let res = list.reduce(0) { (partial, current) in
	let (left, right) = current
	return partial + abs(left - right)
}

print(res)
