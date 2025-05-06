import SwiftUI

struct GameOverView: View {
    var playerScore: Int
    var computerScore: Int
    var replayGame: () -> Void
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.2)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text ("Game Over!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Text ("Player: \(playerScore) - Computer: \(computerScore)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Text (playerScore > computerScore ? "You Win!" : playerScore == computerScore ? "It's a Tie!" : "You Lose!")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Button(action: {
                    self.replayGame()
                }) {
                    Image("replayButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width:100, height:100)
                }
                
                Text ("Replay")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
            }
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(playerScore: 0, computerScore: 0, replayGame: {})
    }
}
