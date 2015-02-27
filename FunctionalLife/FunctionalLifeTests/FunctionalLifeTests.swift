/*
* Copyright (C) 2015 47 Degrees, LLC http://47deg.com hello@47deg.com
*
* Licensed under the Apache License, Version 2.0 (the "License"); you may
* not use this file except in compliance with the License. You may obtain
* a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import UIKit
import XCTest
import SpriteKit

class FunctionalLifeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Game rules
    
    func testGliderEvolution() {
        let firstGen = [CGPointMake(5, 5), CGPointMake(6, 5), CGPointMake(7, 5), CGPointMake(5, 6), CGPointMake(6, 7)]
        let fourthGen = evolveCells(firstGen, generations: 4)
        let eightGen = evolveCells(fourthGen, generations: 4)
        let expectedResult = [CGPointMake(4, 4), CGPointMake(5, 4), CGPointMake(6, 4), CGPointMake(4, 5), CGPointMake(5, 6)]
        XCTAssertTrue(self.areTheseGroupsOfCellsEqual(fourthGen, cellsB: expectedResult), "Gliders should glide (they keep themselves equal each 4 generations, only going up and left by 1 position")
        let translatedEightGen = eightGen.map({ CGPointMake($0.x + 1, $0.y + 1)})
        XCTAssertTrue(self.areTheseGroupsOfCellsEqual(fourthGen, cellsB: translatedEightGen), "Gliders should glide (they keep themselves equal each 4 generations, only going up and left by 1 position")
    }
    
    func testLandspeederShapeEvolution() {
        let firstGen = [CGPointMake(1, 1), CGPointMake(2, 2), CGPointMake(3, 2), CGPointMake(4, 2)]
        let fifthGen = evolveCells(firstGen, generations: 4)
        let expectedResult = [CGPointMake(3, 2), CGPointMake(4, 2)]
        XCTAssertTrue(self.areTheseGroupsOfCellsEqual(fifthGen, cellsB: expectedResult), "Evolution of Landspeeder-Shape didn't go as expected")
        
        let sixthDoomedGen = evolveCells(fifthGen, generations: 1)
        XCTAssertTrue(sixthDoomedGen.count == 0, "Evolution of Landspeeder-Shape didn't go as expected")
    }
    
    func testIShapeEvolution() {
        let firstGen = [CGPointMake(1, 1), CGPointMake(1, 2), CGPointMake(1, 3), CGPointMake(1, 4)]
        let evolution = evolveCells(firstGen, generations: 2)
        let expectedResult = [CGPointMake(1, 1), CGPointMake(0, 2), CGPointMake(2, 2), CGPointMake(0, 3), CGPointMake(2, 3), CGPointMake(1, 4)]
        
        XCTAssertTrue(self.areTheseGroupsOfCellsEqual(evolution, cellsB: expectedResult), "Evolution of L-Shape didn't go as expected")
    }
    
    func testLShapeEvolution() {
        let firstGen = [CGPointMake(1, 1), CGPointMake(2, 1), CGPointMake(3, 1), CGPointMake(1, 2)]
        let evolution = self.evolveCells(firstGen, generations: 3)
        let expectedResult = [CGPointMake(1, 0), CGPointMake(2, 0), CGPointMake(0, 1), CGPointMake(3, 1), CGPointMake(1, 2), CGPointMake(2, 2)]
        XCTAssertTrue(self.areTheseGroupsOfCellsEqual(evolution, cellsB: expectedResult), "Evolution of L-Shape didn't go as expected")
    }
    
    func testStableBlock() {
        let firstGen = [CGPointMake(1, 1), CGPointMake(1, 2), CGPointMake(2, 1), CGPointMake(2, 2)]
        let nextGen = FLGameAlgorithm.evolveListOfAliveCells(firstGen)
        XCTAssertTrue(self.areTheseGroupsOfCellsEqual(firstGen, cellsB: nextGen), "2x2 Block structures should be stable")
    }
    
    func testCellInfoGeneration() {
        let aliveCells = [CGPointMake(1, 1), CGPointMake(1, 2)]
        let cellInfoA = FLGameAlgorithm.cellInfoForCell(CGPointMake(0, 1), currentlyAliveCells: aliveCells)
        XCTAssertTrue(cellInfoA.neighboursCount == 2 && cellInfoA.isAlive == false, "Cell information for the subsequent generation should be generated according to rules")
        
        let cellInfoB = FLGameAlgorithm.cellInfoForCell(CGPointMake(1, 1), currentlyAliveCells: aliveCells)
        XCTAssertTrue(cellInfoB.neighboursCount == 1 && cellInfoB.isAlive == true, "Cell information for the subsequent generation should be generated according to rules")
        
        let cellInfoC = FLGameAlgorithm.cellInfoForCell(CGPointMake(5, 5), currentlyAliveCells: aliveCells)
        XCTAssertTrue(cellInfoC.neighboursCount == 0 && cellInfoC.isAlive == false, "Cell information for the subsequent generation should be generated according to rules")
    }
    
    func testShouldLive() {
        XCTAssertFalse(FLGameAlgorithm.shouldLive((CGPointZero, 0, true)), "Any live cell with fewer than two live neighbours dies, as if caused by under-population")
        XCTAssertFalse(FLGameAlgorithm.shouldLive((CGPointZero, 1, true)), "Any live cell with fewer than two live neighbours dies, as if caused by under-population")
        XCTAssertTrue(FLGameAlgorithm.shouldLive((CGPointZero, 2, true)), "Any live cell with two or three live neighbours lives on to the next generation")
        XCTAssertTrue(FLGameAlgorithm.shouldLive((CGPointZero, 3, true)), "Any live cell with two or three live neighbours lives on to the next generation")
        XCTAssertFalse(FLGameAlgorithm.shouldLive((CGPointZero, 4, true)), "Any live cell with more than three live neighbours dies, as if by overcrowding")
        XCTAssertTrue(FLGameAlgorithm.shouldLive((CGPointZero, 3, false)), "Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction")
    }
    
    func testNeighbours() {
        let mainCell = CGPointMake(1.0, 1.0)
        let neighboursOfMainCell = FLGameAlgorithm.neighboursOfCell(mainCell)
        XCTAssertEqual(neighboursOfMainCell.count, 8, "Neighbour list count of a cell at the middle of the board should be 8")
        XCTAssertEqual(neighboursOfMainCell, [CGPointMake(0, 0), CGPointMake(1, 0), CGPointMake(2, 0), CGPointMake(0, 1), CGPointMake(2, 1), CGPointMake(0, 2), CGPointMake(1, 2), CGPointMake(2, 2)], "Wrong list of neighbours")
        
        let cornerCell = CGPointZero
        let neighboursOfCornerCell = FLGameAlgorithm.neighboursOfCell(cornerCell)
        XCTAssertEqual(neighboursOfCornerCell.count, 3, "Neighbour list count of a cell at the corner of the board should be 3")
        XCTAssertEqual(neighboursOfCornerCell, [CGPointMake(1, 0), CGPointMake(0, 1), CGPointMake(1, 1)], "Wrong list of neighbours")
        
        let topCell = CGPointMake(1.0, 0.0)
        let neighboursOfTopCell = FLGameAlgorithm.neighboursOfCell(topCell)
        XCTAssertEqual(neighboursOfTopCell.count, 5, "Neighbour list count of a cell at the top of the board should be 5")
        XCTAssertEqual(neighboursOfTopCell, [CGPointMake(0, 0), CGPointMake(2, 0), CGPointMake(0, 1), CGPointMake(1, 1), CGPointMake(2, 1)], "Wrong list of neighbours")
    }
    
    func testCandidateCells() {
        let gameBoard = [CGPointMake(1, 1), CGPointMake(2, 1), CGPointMake(3, 1)]
        let candidateCells = FLGameAlgorithm.candidateCellsForCells(gameBoard)
        XCTAssertEqual(candidateCells.count, 15, "Candidate cells list count of these cells should be 15")
        XCTAssertEqual(candidateCells, [CGPointMake(0, 0), CGPointMake(1, 0), CGPointMake(2, 0), CGPointMake(0, 1), CGPointMake(2, 1), CGPointMake(0, 2), CGPointMake(1, 2), CGPointMake(2, 2), CGPointMake(3, 0), CGPointMake(1, 1), CGPointMake(3, 1), CGPointMake(3, 2), CGPointMake(4, 0), CGPointMake(4, 1), CGPointMake(4, 2)], "Wrong list of sorrounding cells")
    }
    
    func testAdjacency() {
        let mainCell = CGPointMake(1.0, 1.0)
        XCTAssertFalse(FLGameAlgorithm.checkCellAdjacency(mainCell, cellB: mainCell), "A cell cannot be adjacent to itself")
        
        let adjacentCells = [CGPointMake(0.0, 0.0), CGPointMake(1.0, 0.0), CGPointMake(2.0, 0.0), CGPointMake(0.0, 1.0), CGPointMake(2.0, 1.0), CGPointMake(0.0, 2.0), CGPointMake(1.0, 2.0), CGPointMake(2.0, 2.0)]
        
        for cell in adjacentCells {
            XCTAssertTrue(FLGameAlgorithm.checkCellAdjacency(mainCell, cellB: cell), "Adjacent cells should be detected")
        }
        
        for cell in adjacentCells {
            let farCell = CGPointMake(cell.x + 3, cell.x + 3)
            XCTAssertFalse(FLGameAlgorithm.checkCellAdjacency(mainCell, cellB: farCell), "Adjacent cells should be at 1 position from the main cell")
        }
        
        for cell in adjacentCells {
            let farCell = CGPointMake(cell.x - 3, cell.x - 3)
            XCTAssertFalse(FLGameAlgorithm.checkCellAdjacency(mainCell, cellB: farCell), "Adjacent cells should be at 1 position from the main cell")
        }
    }
    
    // MARK: Helper functions
    
    func areTheseGroupsOfCellsEqual(cellsA: Array<CGPoint>, cellsB: Array<CGPoint>) -> Bool {
        if cellsA.count == cellsB.count {
            for cell in cellsB {
                if !contains(cellsA, cell) {
                    return false
                }
            }
        } else {
            return false
        }
        return true
    }
    
    func evolveCells(firstGen: Array<CGPoint>, generations: Int) -> Array<CGPoint> {
        if generations > 0 {
            var evolution = FLGameAlgorithm.evolveListOfAliveCells(firstGen)
            for var i = 1; i < generations; i++ {
                evolution = FLGameAlgorithm.evolveListOfAliveCells(evolution)
            }
            return evolution
        }
        return firstGen
    }
    
}
