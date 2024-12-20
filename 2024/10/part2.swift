import Foundation
var input = (try! String(contentsOfFile: CommandLine.arguments[1])).split(separator: "\n").map { $0.map { Int(String($0))! } }

struct foundPos: Hashable { let x: Int, y: Int}
enum Direction { case up, down, left, right }

func hike(x: Int, y: Int, foundPeaks: inout [[foundPos] : Bool], partialPath: [foundPos]) {
	var partialPathCopy = partialPath
	partialPathCopy.append(foundPos(x: x, y: y))
	if input[x][y] == 9 {
		foundPeaks[partialPathCopy] = true
		return
	}
	if x + 1 < input.count && input[x+1][y] == input[x][y] + 1 {
		hike(x: x + 1, y: y, foundPeaks: &foundPeaks, partialPath: partialPathCopy)
	}
	if x - 1 >= 0 && input[x-1][y] == input[x][y] + 1 {
		hike(x: x - 1, y: y, foundPeaks: &foundPeaks, partialPath: partialPathCopy)
	}
	if y - 1 >= 0 && input[x][y-1] == input[x][y] + 1 {
		hike(x: x, y: y - 1, foundPeaks: &foundPeaks, partialPath: partialPathCopy)
	}
	if y + 1 < input[x].count && input[x][y+1] == input[x][y] + 1 {
		hike(x: x, y: y + 1, foundPeaks: &foundPeaks, partialPath: partialPathCopy)
	}
}



var score = 0
for (x, line) in input.enumerated() {
	for (y, point) in line.enumerated() {
		if point == 0 { // is a trailhead
			var foundPeaks: [[foundPos] : Bool] = [:]
			hike(x: x, y: y, foundPeaks: &foundPeaks, partialPath: [foundPos]())
			score += foundPeaks.count
		}
	}
}
print(score)
