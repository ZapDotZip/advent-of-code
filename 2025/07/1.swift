import Foundation
let input = (try! String(contentsOfFile: CommandLine.arguments[1])).split(separator: "\n")

enum tiles { case empty, start, splitter, beam }

var grid: [[tiles]] = input.map { line in
	line.map { c in
		switch c {
		case "S": return .start
		case "^": return .splitter
		case "|": return .beam
		default: return .empty
		}
	}
}


for (t, tile) in grid.first!.enumerated() {
	if tile == .start {
		grid[1][t] = .beam
		break
	}
}

var splits = 0
var posRow = 1
while posRow < (grid.count - 1) {
	for (col, tile) in grid[posRow].enumerated() {
		if tile == .beam {
			if grid[posRow + 1][col] == .splitter {
				grid[posRow + 1][col - 1] = .beam
				grid[posRow + 1][col + 1] = .beam
				splits += 1
			} else {
				grid[posRow + 1][col] = .beam
			}
		}
	}
	posRow += 1
}

print(splits)
