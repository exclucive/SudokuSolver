//: Playground - noun: a place where people can play

import UIKit

var sudoku = [[3,0,6,5,0,8,4,0,0],
              [5,2,0,0,0,0,0,0,0],
              [0,8,7,0,0,0,0,3,1],
              [0,0,3,0,1,0,0,8,0],
              [9,0,0,8,6,3,0,0,5],
              [0,5,0,0,9,0,6,0,0],
              [1,3,0,0,0,0,2,5,0],
              [0,0,0,0,0,0,0,7,4],
              [0,0,5,2,0,6,3,0,0]]


var sudoku2 = [[9,0,0,0,4,2,0,0,0],
               [0,3,5,0,9,0,0,0,6],
               [0,0,8,0,6,0,0,0,7],
               [0,0,0,0,0,7,0,5,0],
               [0,8,9,0,0,0,4,3,0],
               [0,0,3,0,0,1,0,6,2],
               [0,1,0,3,2,0,9,0,0],
               [0,7,4,8,0,0,0,0,0],
               [0,0,0,0,0,0,1,0,5]]

let rows = 9
let columns = 9

func findEntryPoint(grid: [[Int]]) -> (row: Int, column: Int)? {
    for row in 0..<rows {
        for col in 0..<columns {
            if grid[row][col] == 0 {
                return (row, col)
            }
        }
    }
    
    return nil
}

func isRowSafe(grid: [[Int]], row: Int, number: Int) -> Bool {
    for value in grid[row] {
        if value == number  {
            return false
        }
    }
    return true
}

func isColSafe(grid: [[Int]], col: Int, number: Int) -> Bool {
    for row in grid {
        if row[col] == number {
            return false
        }
    }
    return true
}

func isSquareSafe(grid: [[Int]], row: Int, col: Int, number: Int) -> Bool {
    let squareSize = 3
    
    let sqareStartRow = Int(Double(row / squareSize).rounded(.down)) * squareSize
    let sqareStartCol = Int(Double(col / squareSize).rounded(.down)) * squareSize
    
    for r in sqareStartRow..<sqareStartRow+squareSize {
        for c in sqareStartCol..<sqareStartCol+squareSize {
            if grid[r][c] == number {
                return false
            }
        }
    }

    return true
}

func isSafePosition(grid: [[Int]], row: Int, col: Int, number: Int) -> Bool {
    return isRowSafe(grid: grid, row: row, number: number) &&
            isColSafe(grid: grid, col: col, number: number) &&
            isSquareSafe(grid: grid, row: row, col: col, number: number)
}

func solveSudoku(array: inout [[Int]]) -> Bool {
    if array.isEmpty {
        return false
    }
    
    //
    guard let entryPoint = findEntryPoint(grid: array) else {
        return true
    }
    
    for number in 1...9 {
        if isSafePosition(grid: array, row: entryPoint.row, col: entryPoint.column, number: number) {
            array[entryPoint.row][entryPoint.column] = number
            
            if solveSudoku(array: &array) {
                return true
            }
            
            array[entryPoint.row][entryPoint.column] = 0
        }
    }
    
    return false
}


solveSudoku(array: &sudoku)
print(grid: sudoku)

//
func print(grid: [[Int]]) {
    for row in grid {
        let str = "\(row)"
        print(str)
    }

    print("\n")
}
