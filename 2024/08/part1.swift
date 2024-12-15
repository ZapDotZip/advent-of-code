import Foundation

enum Tile { case empty, antenna(String, Bool), antinode }
typealias coord = (Int, Int)
var input = (try! String(contentsOfFile: CommandLine.arguments[1])).split(separator: "\n").map { (line) -> ([Tile]) in
	return line.map { (c) -> Tile in
		switch (c) {
		case ".": return Tile.empty
		default: return Tile.antenna(String(c), false)
		}
	}
}
func pr() {
	var str = ""
	for line in input {
		for i in line {
			switch (i) {
			case .empty: str += "."
			case .antenna(let s, _): str += s
			case .antinode: str += "#"
			}
		}
		str += "\n"
	}
	print(str)
}

var count = 0
func placeAntinode(antinode: coord) {
	if (antinode.0 >= 0 && antinode.0 < input.count) && (antinode.1 >= 0 && antinode.1 < input[0].count) {
		switch (input[antinode.0][antinode.1]) {
		case .antenna(_, var hasBeenMarked):
			if !hasBeenMarked {
				count += 1
				hasBeenMarked = true
			}
		case .empty:
			input[antinode.0][antinode.1] = .antinode
			count += 1
		case .antinode: break
		}
	}
}

func findAllAntinodes(signal: String, x1: Int, y1: Int) {
	let p1 = (x1, y1)
	print("for p1: \(p1):")
	for (x2, line) in input.enumerated() {
		for (y2, i) in line.enumerated() {
			switch (i) { case .antenna(let sig, _):
				let p2 = (x2, y2)
				if signal == sig && p1 != p2 {
					let vec = ((x1 - x2), (y1 - y2))
					let an = ((x1 + vec.0), (y1 + vec.1))
					placeAntinode(antinode: an)
				} default: continue }
		}
	}
}

pr()
for (x, line) in input.enumerated() {
	for (y, i) in line.enumerated() {
		switch (i) {
		case .antenna(let sig, _): findAllAntinodes(signal: sig, x1: x, y1: y)
		default: continue
		}
	}
}

pr()
print(count)

