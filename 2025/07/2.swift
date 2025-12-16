import Foundation
let input = (try! String(contentsOfFile: CommandLine.arguments[1])).split(separator: "\n")

enum tiles: Equatable {
	case empty, start, splitter, beam(timelines: Int)
}

var grid: [[tiles]] = input.map { line in
	line.map { c in
		switch c {
		case "S": return .start
		case "^": return .splitter
		default: return .empty
		}
	}
}

func updateTimelines(row: Int, col: Int, newCount: Int) {
	if case .beam(let timelines) = grid[row][col] {
		grid[row][col] = .beam(timelines: timelines + newCount)
	} else {
		grid[row][col] = .beam(timelines: newCount)
	}
}

for (t, tile) in grid.first!.enumerated() {
	if tile == .start {
		grid[1][t] = .beam(timelines: 1)
		break
	}
}

var posRow = 1
while posRow < (grid.count - 1) {
	for (col, tile) in grid[posRow].enumerated() {
		if case .beam(let timelines) = tile {
			if grid[posRow + 1][col] == .splitter {
				updateTimelines(row: posRow + 1, col: col - 1, newCount: timelines)
				updateTimelines(row: posRow + 1, col: col + 1, newCount: timelines)
			} else {
				updateTimelines(row: posRow + 1, col: col, newCount: timelines)
			}
		}
	}
	posRow += 1
}

let result = grid.last!.reduce(0) { partialResult, tiles in
	switch tiles {
		case .beam(let timelines): return partialResult + timelines
		default: return partialResult
	}
}

print(result)
