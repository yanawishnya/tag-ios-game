import SwiftUI

struct TileGrid: View {
    
    @ObservedObject var viewModel: SpotViewModel

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: viewModel.gridSize), spacing: Constants.tileSpacing) {
            ForEach(viewModel.tiles) { tile in
                Button(action: {
                    viewModel.tileTapped(tile)
                }) {
                    Text("\(tile.number)")
                        .font(.title)
                        .frame(width: Constants.tileSize, height: Constants.tileSize)
                        .background(tile.number == viewModel.gridSize * viewModel.gridSize ? Color.black : Color.white)
                        .foregroundColor(tile.number == viewModel.gridSize * viewModel.gridSize ? Color.white : Color.black)
                        .cornerRadius(Constants.tileCornerRadius)
                        .overlay(
                            RoundedRectangle(cornerRadius: Constants.tileCornerRadius)
                                .stroke(Color.black, lineWidth: Constants.tileStrokeWidth)
                        )
                }
            }
        }
    }
}

struct TileGrid_Previews: PreviewProvider {
    static var previews: some View {
        TileGrid(viewModel: SpotViewModel())
    }
}
