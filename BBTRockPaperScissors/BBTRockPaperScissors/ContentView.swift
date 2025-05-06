import SwiftUI

struct ContentView: View {
    //vairables used to control which screen to show
    @State private var gameStarted: Bool = false
    @State private var showGameOver: Bool = false
    
    //variables for tracking player and computer choices and scores and rounds
    @State private var playerChoice: String = ""
    @State private var computerChoice: String = ""
    @State private var playerScore: Int = 0
    @State private var computerScore: Int = 0
    @State private var round: Int = 1
    
    //array of choices
    let choices = ["Rock", "Paper", "Scissors", "Lizard", "Spock"]
    
    //array of image names
    let images = ["rock", "paper", "scissors", "lizard", "spock"]
    
    //all the ui stuffs
    var body: some View {
        ZStack {
            Color.blue.opacity(0.2)
            .edgesIgnoringSafeArea(.all)
            
            //title screen
            if !gameStarted {
                VStack {
                    Text ("Rock Paper Scissors Lizard Spock")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 30)
                    
                    Spacer()
                    
                    Button(action: {
                        //start game
                        gameStarted = true
                    }) {
                         Image("playButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width:100, height:100)
                            .padding()
                    }
                    
                    Text("Press to Start!")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
            } else {
                VStack {
                    //round counter
                    if (round < 11) {
                        Text ("Round \(round)")
                            .font(.largeTitle)
                            .padding(.top, 50)
                    } else {
                        Text ("Game Over!")
                            .font(.largeTitle)
                            .padding(.top, 50)
                    }
                    
                    //player and computer choices
                    Text("Player:\(playerChoice)")
                        .font(.title)
                        .padding(.top, 10)
                    Text("Computer:\(computerChoice)")
                        .font(.title)
                    
                    VStack(spacing: 20) {
                        HStack(spacing:20) {
                            ForEach(0..<3, id:\.self){index in
                                Button(action: {
                                    self.tappedButton(choice: choices[index])
                                }) {
                                    Image(images[index])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:100, height:100)
                                        .padding()
                                }
                                .frame(width: 100, height:100)
                            }
                        }
                        
                        HStack(spacing: 20) {
                            ForEach (3..<5, id:\.self) { index in
                                Button(action: {
                                    self.tappedButton(choice: choices[index])
                                }) {
                                    Image(images[index])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:100, height:100)
                                        .padding()
                                }
                                .frame(width: 100, height: 100)
                            }
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    //after 10 rounds
                    if round > 10 {
                        Button(action: {
                            showGameOver = true
                        }) {
                            Image ("continueButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width:100, height:100)
                        }
                        
                        .sheet(isPresented: $showGameOver) {
                            GameOverView(playerScore: playerScore, computerScore: computerScore, replayGame: {
                                self.replayGame()
                                showGameOver = false
                            })
                        }
                    }
                    
                    //win counter
                    HStack{
                        Text("Player: \(playerScore)")
                            .font(.title)
                        Spacer()
                        Text("Computer: \(computerScore)")
                            .font(.title)
                    }
                    .padding()
                }
            }
        }
    }
    
    //function to determine the winner
    func determineWinner(playerChoice: String, computerChoice: String) {
        if playerChoice == computerChoice {
            playerScore += 1
            computerScore += 1
            return
        }
        
        switch playerChoice{
        case "Rock":
            if computerChoice == "Scissors" || computerChoice == "Lizard"{
                playerScore += 1
            } else {
                computerScore += 1
            }
        case "Paper":
            if computerChoice == "Rock" || computerChoice == "Spock"{
                playerScore += 1
            } else {
                computerScore += 1
            }
        case "Scissors":
            if computerChoice == "Paper" || computerChoice == "Lizard"{
                playerScore += 1
            } else {
                computerScore += 1
            }
        case "Lizard":
            if computerChoice == "Paper" || computerChoice == "Spock"{
                playerScore += 1
            } else {
                computerScore += 1
            }
        case "Spock":
            if computerChoice == "Rock" || computerChoice == "Scissors"{
                playerScore += 1
            } else {
                computerScore += 1
            }
        default:
            break
        }
    }
    
    //function for when player taps one of the buttons
    func tappedButton(choice: String) {
        if round <= 10 {
            playerChoice = choice
            computerChoice = choices.randomElement() ?? "Rock"
            
            determineWinner(playerChoice: playerChoice, computerChoice: computerChoice)
            
                round += 1
        }
    }
    
    //replay the game
    func replayGame(){
        playerScore = 0
        computerScore = 0
        round = 1
        playerChoice = ""
        computerChoice = ""
        gameStarted = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
