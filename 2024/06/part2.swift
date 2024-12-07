import Foundation

enum direction { case up, right, down, left }
enum tile { case none, obj(_ placed: Bool), `guard`(_ d: direction), visited(_ d: direction) }

var input = (try! String(contentsOfFile: CommandLine.arguments[1])).split(separator: "\n").map { (str) -> [tile] in
	return str.map { (c) -> tile in
		switch (c) {
			case ".": return tile.none
			case "#": return tile.obj(false)
			case "^": return tile.guard(.up)
			case ">": return tile.guard(.right)
			case "V": return tile.guard(.down)
			case "<": return tile.guard(.left)
			default: return tile.none
		}
	}
}

func pr(_ i: [[tile]]) {
	print("\u{001B}[H\u{1b}\u{5b}\u{33}\u{4a}", terminator: "")
	var s = ""
	i.forEach {
		$0.forEach {
			switch($0) {
			case .none: s += "."
			case .obj(let p): s += p ? "O" : "#"
			case .visited(let d):
				switch(d) {
				case .up: s += "↑"
				case .right: s += "→"
				case .down: s += "↓"
				case .left: s += "←"
				}
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

func move(from: (Int, Int), to: (Int, Int), d: direction, o: direction, arr: inout [[tile]]) {
	arr[from.0][from.1] = .visited(o)
	arr[to.0][to.1] = .guard(d)
}



func checkLoop(i: inout [[tile]]) -> Bool {
	var pos: (Int, Int) = {
		for (i, list) in i.enumerated() {
			for (j, tile) in list.enumerated() {
				if case .guard = tile { return (i, j) }
			}
		}
		return (-1, -1)
	}()
	if pos == (-1, -1) {
		return false
	}
	
	var d: direction = {
		switch(i[pos.0][pos.1]) {
		case .guard(let a):
			return a
		default:
			exit(1)
		}
	}()
		
//	var n = 0;
	var lastDir = d
	while true {
//		n += 1
//		if n % 10000 == 0 {
//			pr(i)
//		}
		let next = getMoveCoords(d, pos)
		if next.0 >= i.count || next.0 < 0 || next.1 >= i[0].count || next.1 < 0 {
			return false
		} else if case .visited(let pd) = i[next.0][next.1], case d = pd {
			return true
		} else if case .obj = i[next.0][next.1] {
			d = {
				switch(d) {
				case .up: return .right
				case .right: return .down
				case .down: return .left
				case .left: return .up
				}
			}()
		} else {
			move(from: pos, to: next, d: d, o: lastDir, arr: &i)
			pos = next
			lastDir = d
		}
	}
}

var count = 0
for (i, list) in input.enumerated() {
	for (j, _) in list.enumerated() {
		var copy = input
		copy[i][j] = .obj(true)
		if checkLoop(i: &copy) {
			count += 1
		}
	}
}

print(count)
