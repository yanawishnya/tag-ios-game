import SwiftUI

@main
struct iOS_exam_BarbashinaApp: App {
    var body: some Scene {
        WindowGroup {
            GameView(viewModel: SpotViewModel())
        }
    }
}
