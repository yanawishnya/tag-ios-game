import SwiftUI

struct GameView: View {
    
    @ObservedObject var viewModel: SpotViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.isGameOver ? "Игра окончена за \(viewModel.moves) ходов" : "Сделано ходов: \(viewModel.moves)")
                .padding()
            
            Spacer()
            
            TileGrid(viewModel: self.viewModel)
                .padding()
            
            Spacer()
            Button(action: {
                viewModel.startNewGame()
            }) {
                Text("Начать игру заново")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(Constants.buttonCornerRadius)
                    .font(.system(size: Constants.fontSize))
            }
            .padding(.horizontal, Constants.horizontalPadding)
            .padding()
            
        }
        .onAppear(perform: viewModel.startNewGame)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: SpotViewModel())
    }
}
