import Foundation

struct Point: Equatable {
	let x, y: Int
	func rect(with other: Point) -> Int {
		let len = abs(x - other.x) + 1
		let wid = abs(y - other.y) + 1
		return len * wid
	}
}

let list = (try! String(contentsOfFile: CommandLine.arguments[1])).split(separator: "\n").map { box in
	let xy = box.split(separator: ",")
	return Point(x: Int(xy[0])!, y: Int(xy[1])!)
}

var pointA = list.first!
var pointB = list.first!
var pointArea = 0
for (i, coordA) in list.enumerated() {
	for coordB in list.dropFirst(i + 1) {
		let newArea = coordA.rect(with: coordB)
		if newArea > pointArea {
			pointA = coordA
			pointB = coordB
			pointArea = newArea
		}
	}
}
print("\(pointA) with \(pointB) makes \(pointArea)")
