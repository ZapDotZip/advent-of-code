import Foundation
var input = (try! String(contentsOfFile: CommandLine.arguments[1]))

enum tile: CustomStringConvertible {
	case empty, roll
	var description: String {
		switch self {
		case .empty: return "."
		case .roll: return "@"
		}
	}
}

let grid = input.split(separator: "\n").map { $0.compactMap { c in
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
	   grid[checkRow][checkCol] == .roll {
		num += 1
	}
	checkCol = col
	if validatePosition(row: checkRow, col: checkCol),
	   grid[checkRow][checkCol] == .roll {
		num += 1
	}
	checkCol = col + 1
	if validatePosition(row: checkRow, col: checkCol),
	   grid[checkRow][checkCol] == .roll {
		num += 1
	}
	// current row
	checkRow = row
	checkCol = col - 1
	if validatePosition(row: checkRow, col: checkCol),
	   grid[checkRow][checkCol] == .roll {
		num += 1
	}
	checkCol = col + 1
	if validatePosition(row: checkRow, col: checkCol),
	   grid[checkRow][checkCol] == .roll {
		num += 1
	}
	// row below
	checkRow = row + 1
	checkCol = col - 1
	if validatePosition(row: checkRow, col: checkCol),
	   grid[checkRow][checkCol] == .roll {
		num += 1
	}
	checkCol = col
	if validatePosition(row: checkRow, col: checkCol),
	   grid[checkRow][checkCol] == .roll {
		num += 1
	}
	checkCol = col + 1
	if validatePosition(row: checkRow, col: checkCol),
	   grid[checkRow][checkCol] == .roll {
		num += 1
	}
	return num
}

var total = 0

for (row, rows) in grid.enumerated() {
	for (col, item) in rows.enumerated() {
		if item == .roll {
			if numberOfAdjacentRolls(row: row, col: col) < 4 {
				total += 1
			}
		}
	}
}

print(total)
