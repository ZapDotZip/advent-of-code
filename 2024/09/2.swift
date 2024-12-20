import Foundation
var input = (try! String(contentsOfFile: CommandLine.arguments[1])).split(separator: "\n").first!
var blocks = [Int]()
var freeSpace = false
var inode = 0
for char in input {
	if freeSpace {
		blocks.append(contentsOf: [Int].init(repeating: -1, count: Int(String(char))!))
	} else {
		blocks.append(contentsOf: [Int].init(repeating: inode, count: Int(String(char))!))
		inode += 1
	}
	freeSpace = !freeSpace
}

func findContiguousSize(item: Int, startPos: Int) -> Int {
	for i in stride(from: startPos, to: 0, by: -1) {
		if blocks[i] != item { return startPos - i }
	}
	return -1
}

func findEnoughFreeSpace(size: Int, item: Int, upTo: Int) -> Bool {
	var freeSpace = 0
	var freeSpaceStart = -1
	for (index, i) in blocks.enumerated().prefix(upTo) {
		if i == -1 {
			freeSpace += 1
			if freeSpaceStart == -1 {
				freeSpaceStart = index
			}
			if freeSpace >= size {
				for j in freeSpaceStart...(freeSpaceStart + size - 1) {
					blocks[j] = item
				}
				return true
			}
		} else {
			freeSpace = 0
			freeSpaceStart = -1
		}
	}
	return false
}


var index = blocks.endIndex - 1
while index > 0 {
	let srcBlockLen = findContiguousSize(item: blocks[index], startPos: index)
	if srcBlockLen == -1 {
		break
	}
	if findEnoughFreeSpace(size: srcBlockLen, item: blocks[index], upTo: index) {
		for j in stride(from: index, to: index-srcBlockLen, by: -1) {
			blocks[j] = -1
		}
	}
	index -= srcBlockLen
}

var result = 0
for (index, i) in blocks.enumerated() {
	if i != -1 {
		result += index * i
	}
}
// print(blocks.reduce(into: "") { $0 = "\($0)\($1)" })
print(result)
