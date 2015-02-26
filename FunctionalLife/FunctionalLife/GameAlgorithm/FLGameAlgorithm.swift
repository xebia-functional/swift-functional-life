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

class FLGameAlgorithm: NSObject {
   
    class func evolveListOfAliveCells(aliveCells: Array<CGPoint>) -> Array<CGPoint> {
        let candidates = FLGameAlgorithm.candidateCellsForCells(aliveCells)
        let candidatesInfo = candidates.map({ FLGameAlgorithm.cellInfoForCell($0, currentlyAliveCells: aliveCells) })
        return candidatesInfo.filter({ FLGameAlgorithm.shouldLive($0) }).map({ $0.cell })
    }
    
    // MARK: - Accessory methods
    
    class func cellInfoForCell(cell: CGPoint, currentlyAliveCells: Array<CGPoint>) -> (cell: CGPoint, neighboursCount: Int, isAlive: Bool) {
        return (cell, neighboursCount: FLGameAlgorithm.neighboursOfCell(cell).filter({ contains(currentlyAliveCells, $0) }).count, isAlive: contains(currentlyAliveCells, cell))
    }
    
    class func shouldLive(cellInfo: (cell: CGPoint, neighboursCount: Int, isAlive: Bool)) -> Bool {
        switch cellInfo {
        case (_, 0..<2, true): return false
        case (_, 4..<Int.max, true): return false
        case (_, _, true): return true
        case (_, 3, false): return true
        default: return false
        }
    }
    
    class func candidateCellsForCells(cells: Array<CGPoint>) -> Array<CGPoint> {
        let result = FLFunctionalHelper.flatMap(cells, f: { FLGameAlgorithm.neighboursOfCell($0) })
        
        let filteredResult = result.reduce([CGPoint]()) {
            if !contains($0, $1) {
                return $0.immutableAppend($1)
            }
            return $0
        }
        return filteredResult
    }
    
    class func neighboursOfCell(cell: CGPoint) -> Array<CGPoint> {
        var neighboursList = Array<CGPoint>()
        
        for indexY in (Int(cell.y) - 1)...(Int(cell.y) + 1) {
            for indexX in (Int(cell.x) - 1)...(Int(cell.x) + 1) {
                if indexX >= 0 && indexY >= 0 {
                    let neighbour = CGPoint(x: CGFloat(indexX), y: CGFloat(indexY))
                    if cell != neighbour {
                        neighboursList.append(neighbour)
                    }
                }                
            }
        }
        return neighboursList
    }
    
    class func listOfSorroundingAliveCellsOfCell(currentCell: CGPoint, listOfCells: Array<CGPoint>) -> Array<CGPoint> {
        return listOfCells.filter({ (cell) in
            FLGameAlgorithm.checkCellAdjacency(currentCell, cellB: cell)
        })
    }
    
    class func checkCellAdjacency(cellA: CGPoint, cellB: CGPoint) -> Bool {
        if cellA == cellB {
            return false
        } else {
            return abs(Int(cellA.x) - Int(cellB.x)) <= 1 &&
                    abs(Int(cellA.y) - Int(cellB.y)) <= 1
        }
    }

}
