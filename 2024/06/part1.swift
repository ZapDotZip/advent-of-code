import Foundation

enum direction { case up, right, down, left }
enum tile { case none, obj, `guard`(_ d: direction), visited }

var input = (try! String(contentsOfFile: CommandLine.arguments[1])).split(separator: "\n").map { (str) -> [tile] in
	return str.map { (c) -> tile in
		switch (c) {
		case ".": return tile.none
		case "#": return tile.obj
		case "^": return tile.guard(.up)
		case ">": return tile.guard(.right)
		case "V": return tile.guard(.down)
		case "<": return tile.guard(.left)
		default: return tile.none
		}
	}
}

func printInput() {
	var s = ""
	input.forEach {
		$0.forEach {
			switch($0) {
			case .none: s += "."
			case .obj: s += "#"
			case .visited: s += "X"
			case .guard(let d):
				switch(d) {
				case .up: s += "^"
				case .right: s += ">"
				case .down: s += "V"
				case .left: s += "<"
				}
			}
		}
		s += "\n"
	}
	print(s)
}

func getMoveCoords(_ d: direction, _ coords: (Int, Int)) -> (Int, Int) {
	if d == .up { return (coords.0 - 1, coords.1) }
	else if d == .down { return (coords.0 + 1, coords.1) }
	else if d == .left { return (coords.0, coords.1 - 1) }
	else if d == .right { return (coords.0, coords.1 + 1) }
	return (0,0)
}

func move(from: (Int, Int), to: (Int, Int), d: direction) {
	input[from.0][from.1] = .visited
	input[to.0][to.1] = .guard(d)
}

var pos: (Int, Int) = {
	for (i, list) in input.enumerated() {
		for (j, tile) in list.enumerated() {
			if case .guard = tile { return (i, j) }
		}
	}
	exit(1)
}()

var d: direction = {
	switch(input[pos.0][pos.1]) {
	case .guard(let a):
		return a
	default:
		exit(1)
	}
}()

while true {
	let next = getMoveCoords(d, pos)
	if next.0 >= input.count || next.0 < 0 || next.1 >= input[0].count || next.1 < 0 {
		break
	} else if case .obj = input[next.0][next.1] {
		d = {
			switch(d) {
			case .up: return .right
			case .right: return .down
			case .down: return .left
			case .left: return .up
			}
		}()
	} else {
		move(from: pos, to: next, d: d)
		pos = next
	}
}

print(input.reduce(1) {
	$0 + $1.reduce(0) {
		if case .visited = $1 {
			return $0 + 1
		} else {
			return $0
		}
	}
})
