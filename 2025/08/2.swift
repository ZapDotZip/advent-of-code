import Foundation

struct Point: Equatable {
	let x, y, z: Int
	func distanceTo(other: Point) -> Double {
		let dimX = pow(Double(x - other.x), 2)
		let dimY = pow(Double(y - other.y), 2)
		let dimZ = pow(Double(z - other.z), 2)
		return sqrt(dimX + dimY + dimZ)
	}
}

class Circuit: Comparable {
	var connectedBoxes: Set<Int> = .init()
	static func < (lhs: Circuit, rhs: Circuit) -> Bool {
		return lhs.connectedBoxes.count < rhs.connectedBoxes.count
	}
	static func == (lhs: Circuit, rhs: Circuit) -> Bool {
		return lhs === rhs
	}
}

struct StoredDistance: Comparable {
	let distance: Double
	let boxA, boxB: Int
	static func < (lhs: StoredDistance, rhs: StoredDistance) -> Bool {
		return lhs.distance < rhs.distance
	}
}


let list = (try! String(contentsOfFile: CommandLine.arguments[1])).split(separator: "\n").map { box in
	let xyz = box.split(separator: ",")
	return Point(x: Int(xyz[0])!, y: Int(xyz[1])!, z: Int(xyz[2])!)
}

var distances: [StoredDistance] = []
distances.reserveCapacity(list.count * (list.count - 1) / 2)
for (i, boxA) in list.enumerated() {
	for (j, boxB) in list.dropFirst(i + 1).enumerated() {
		distances.append(.init(distance: boxA.distanceTo(other: boxB), boxA: i, boxB: j + i + 1))
	}
}
distances.sort()

var circuits: [Int: Circuit] = [:]
var lastX: [Int] = .init(repeating: 0, count: 2)
for distance in distances {
	let circuitA = circuits[distance.boxA]
	let circuitB = circuits[distance.boxB]
	if let circuitA, let circuitB {
		if circuitA !== circuitB {
			circuitA.connectedBoxes.formUnion(circuitB.connectedBoxes)
			circuitA.connectedBoxes.forEach { box in
				circuits[box] = circuitA
			}
			lastX[0] = list[distance.boxA].x
			lastX[1] = list[distance.boxB].x
		}
	} else if let circuitA {
		circuitA.connectedBoxes.insert(distance.boxB)
		circuits[distance.boxB] = circuitA
		lastX[0] = list[distance.boxA].x
		lastX[1] = list[distance.boxB].x
	} else if let circuitB {
		circuitB.connectedBoxes.insert(distance.boxA)
		circuits[distance.boxA] = circuitB
		lastX[0] = list[distance.boxA].x
		lastX[1] = list[distance.boxB].x
	} else {
		let circuit = Circuit()
		circuit.connectedBoxes.insert(distance.boxA)
		circuit.connectedBoxes.insert(distance.boxB)
		circuits[distance.boxA] = circuit
		circuits[distance.boxB] = circuit
		lastX[0] = list[distance.boxA].x
		lastX[1] = list[distance.boxB].x
	}
}

let result = lastX.reduce(1) { $0 * $1 }

print(result)
