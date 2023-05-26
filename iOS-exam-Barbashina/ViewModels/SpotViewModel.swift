import Foundation

class SpotViewModel: ObservableObject {
    
    // MARK: - Properties
    
    /// Tiles themselves.
    @Published public var tiles: [Tile] = [Tile]()
    
    /// Moves user made.
    @Published public var moves: Int = 0
    
    /// Boolean value that says if game is over.
    @Published public var isGameOver: Bool = false
    
    /// Size of grid.
    public let gridSize: Int = 4
    
    // MARK: - Actions
    
    /// Method that starts game. Sets moves to zero, creates tiles and shuffles them.
    func startNewGame() {
        tiles.removeAll()
        moves = 0
        isGameOver = false

        for number in 1..<(gridSize * gridSize) {
            tiles.append(Tile(id: number, number: number))
        }
        tiles.shuffle()
        tiles.append(Tile(id: gridSize * gridSize, number: gridSize * gridSize))
    }
    
    /// Method that checks if tile should be moved or not. Checks if game is not finished.
    func tileTapped(_ tile: Tile) {
        guard !isGameOver else { return }
        
        let emptyTileIndex = tiles.firstIndex { $0.number == gridSize * gridSize }

        if let emptyIndex = emptyTileIndex, let tappedIndex = tiles.firstIndex(of: tile) {
            if isAdjacent(tappedIndex, emptyIndex) {
                moves += 1
                tiles.swapAt(tappedIndex, emptyIndex)
                checkGameOver()
            }
        }
    }

    // MARK: - Checkers
    
    /// Method that checks if the tile user tapped on is adjacent to active tile.
    func isAdjacent(_ index1: Int, _ index2: Int) -> Bool {
        let row1 = index1 / gridSize
        let column1 = index1 % gridSize
        let row2 = index2 / gridSize
        let column2 = index2 % gridSize

        return (row1 == row2 && abs(column1 - column2) == 1) ||
               (column1 == column2 && abs(row1 - row2) == 1)
    }
    
    /// Method checks if tiles are in the right order and if so finishes game.
    func checkGameOver() {
        let sortedTiles = tiles.sorted { $0.number < $1.number }

        if sortedTiles == tiles {
            isGameOver = true
        }
    }
}
