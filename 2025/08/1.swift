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
for distance in distances.prefix(list.count == 1000 ? 1000 : 10) {
	let circuitA = circuits[distance.boxA]
	let circuitB = circuits[distance.boxB]
	if let circuitA, let circuitB, circuitA !== circuitB {
		circuitA.connectedBoxes.formUnion(circuitB.connectedBoxes)
		circuitA.connectedBoxes.forEach { box in
			circuits[box] = circuitA
		}
	} else if let circuitA {
		circuitA.connectedBoxes.insert(distance.boxB)
		circuits[distance.boxB] = circuitA
	} else if let circuitB {
		circuitB.connectedBoxes.insert(distance.boxA)
		circuits[distance.boxA] = circuitB
	} else {
		let circuit = Circuit()
		circuit.connectedBoxes.insert(distance.boxA)
		circuit.connectedBoxes.insert(distance.boxB)
		circuits[distance.boxA] = circuit
		circuits[distance.boxB] = circuit
	}
}

var seen = Set<ObjectIdentifier>()
let biggestCircuits: [Circuit] = circuits.values.compactMap { circuit in
	let id = ObjectIdentifier(circuit)
	guard !seen.contains(id) else { return nil }
	seen.insert(id)
	return circuit
}.sorted().reversed()

let result = biggestCircuits.prefix(3).reduce(1) { partialResult, circuit in
	return partialResult * circuit.connectedBoxes.count
}

print(result)
