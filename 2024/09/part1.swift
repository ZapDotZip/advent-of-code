import Foundation
var input = (try! String(contentsOfFile: CommandLine.arguments[1])).split(separator: "\n").first!
var blocks = [Int]()
var freeSpace = false
var inode = 0

for char in input {
	if freeSpace {
		if let i = Int(String(char)) {
			blocks.append(contentsOf: [Int].init(repeating: -1, count: i))
		}
	} else {
		if let i = Int(String(char)) {
			blocks.append(contentsOf: [Int].init(repeating: inode, count: i))
			inode += 1
		}
	}
	freeSpace = !freeSpace
}

func contiguousFreeSpace(_ arr: [Int]) -> Bool {
	var seen = false
	for i in arr {
		if seen && i != -1 { return false } else if i == -1 { seen = true }
	}
	return true
}
while !contiguousFreeSpace(blocks) {
	let firstIndex = {
		for (index, i) in blocks.enumerated() {
			if i == -1 { return index }
		}
		return blocks.count
	}()
	let lastBlock = {
		for i in stride(from: blocks.endIndex - 1, to: 0, by: -1) {
			if blocks[i] != -1 {
				let res = blocks[i]
				blocks[i] = -1
				return res
			}
		}
		return -1
	}()
	blocks[firstIndex] = lastBlock
}

var result = 0
for (index, i) in blocks.enumerated() {
	if i != -1 {
		result += index * i
	}
}
print(result)
