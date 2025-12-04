import Foundation
var input = (try! String(contentsOfFile: CommandLine.arguments[1]))

enum tile: CustomStringConvertible {
	case empty, roll, accessible
	var description: String {
		switch self {
		case .empty: return "."
		case .roll: return "@"
		case .accessible: return "x"
		}
	}
}

var grid = input.split(separator: "\n").map { $0.compactMap { c in
	switch c {
	case ".": return tile.empty
	case "@": return tile.roll
	default: return nil
	}
} }

func validatePosition(row: Int, col: Int) -> Bool {
	guard row >= 0 && col >= 0 else { return false }
	guard row < grid.count && col < grid[row].count else { return false }
	return true
}

func numberOfAdjacentRolls(row: Int, col: Int) -> Int {
	var num = 0
	var checkRow = row - 1
	var checkCol = col - 1
// row above
	if validatePosition(row: checkRow, col: checkCol),
		grid[checkRow][checkCol] != .empty {
		num += 1
	}
	checkCol = col
	if validatePosition(row: checkRow, col: checkCol),
		grid[checkRow][checkCol] != .empty {
		num += 1
	}
	checkCol = col + 1
	if validatePosition(row: checkRow, col: checkCol),
		grid[checkRow][checkCol] != .empty {
		num += 1
	}
// current row
	checkRow = row
	checkCol = col - 1
	if validatePosition(row: checkRow, col: checkCol),
		grid[checkRow][checkCol] != .empty {
		num += 1
	}
	checkCol = col + 1
	if validatePosition(row: checkRow, col: checkCol),
		grid[checkRow][checkCol] != .empty {
		num += 1
	}
// row below
	checkRow = row + 1
	checkCol = col - 1
	if validatePosition(row: checkRow, col: checkCol),
		grid[checkRow][checkCol] != .empty {
		num += 1
	}
	checkCol = col
	if validatePosition(row: checkRow, col: checkCol),
		grid[checkRow][checkCol] != .empty {
		num += 1
	}
	checkCol = col + 1
	if validatePosition(row: checkRow, col: checkCol),
		grid[checkRow][checkCol] != .empty {
		num += 1
	}
	return num
}

var total = 0
var lastRemoved = 0

repeat {
	lastRemoved = 0
	for (row, rows) in grid.enumerated() {
		for (col, item) in rows.enumerated() {
			if item == .roll || item == .accessible {
				if numberOfAdjacentRolls(row: row, col: col) < 4 {
					lastRemoved += 1
					total += 1
					grid[row][col] = .accessible
				}
			}
		}
	}
	grid = grid.map({ row in
		row.map { tile in
			if tile == .accessible {
				return .empty
			} else {
				return tile
			}
		}
	})
} while lastRemoved != 0

print(total)
