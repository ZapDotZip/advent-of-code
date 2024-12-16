import Foundation
var input = (try! String(contentsOfFile: CommandLine.arguments[1])).split(separator: "\n").first!
var blocks = [String]()
var freeSpace = false
var inode = 0

for char in input {
	if freeSpace {
		if let i = Int(String(char)) {
			blocks.append(contentsOf: [String].init(repeating: ".", count: i))
		} else {
			print("NaN: \(char)")
		}
	} else {
		if let i = Int(String(char)) {
			blocks.append(contentsOf: [String].init(repeating: String(inode), count: i))
			inode += 1
		} else {
			print("NaN: \(char)")
		}
	}
	freeSpace = !freeSpace
}

func contiguousFreeSpace(_ arr: [String]) -> Bool {
	var seen = false
	for i in arr {
		if seen && i != "." { return false } else if i == "." { seen = true }
	}
	return true
}
while !contiguousFreeSpace(blocks) {
	let firstIndex = {
		for (index, i) in blocks.enumerated() {
			if i == "." { return index }
		}
		return blocks.count
	}()
	let lastBlock = {
		for (index, i) in blocks.enumerated().reversed() {
			if i != "." {
				blocks[index] = "."
				return i
			}
		}
		return "!"
	}()
	blocks[firstIndex] = lastBlock
}

var result = 0
for (index, i) in blocks.enumerated() {
	if let id = Int(i) {
		result += index * id
	} else {
		break
	}
}
print(result)
