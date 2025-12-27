//
//  MainMenuView.swift
//  GameProject
//
//  Created by Nick Gordon on 12/18/25.
//
import SwiftUI
import SpriteKit



struct MainMenuView: View {
    @State var gameManager: GameManager
    @State private var isShowingCharacterSelection: Bool = true
    var body: some View {

        NavigationStack {
            ZStack {
                SpriteView(scene: gameManager.scene)
                    .ignoresSafeArea()
                    .onAppear {
                       // gameManager.configureScene()
                          }
                    .onChange(of: gameManager.currentCharacterSelection) { value in
                    //    gameManager.scene.updateCharacter(to: value)
                    }
//                    .onChange(of: gameManager.gameState) { value in
//                        gameManager.scene.updateGameState(to: value)
//                    }
                
                VStack(spacing: 32) {
                    Text("Project 313")
                        .font(.system(size: 42, weight: .heavy, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .shadow(color: .black.opacity(1), radius: 8, x: 0, y: 4)
                        .foregroundStyle(.green)
                        .background {
                            Rectangle()
                                .cornerRadius(16)
                        }
                
               
                    
                    
                    Spacer()
                    
                 
                    VStack(spacing: 16) {
                        
                        Button {
//                            gameManager.scene.updateGameState(to: .playingGame)
                            gameManager.playAgain()
                            gameManager.gameState = .playingGame
                        } label: {
                            Text("Play")
                                .font(.title2.bold())
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                        .controlSize(.large)
                        .padding(.horizontal, 24)
                        .shadow(color: .black.opacity(0.25), radius: 18, x: 4, y: 4)
                        
                        
                    }
                    
                    //  Spacer()
                    Text("© 2025 DevsCreate313")
                        .font(.footnote)
                        .foregroundStyle(.white)
                        .padding(.bottom, 24)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "gear")
                        .font(.title3)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                  
                    
                    Button {
                        isShowingCharacterSelection.toggle()
                    } label: {
                        Image(systemName: "person")
                            .font(.title3)
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingCharacterSelection) {
            CharacterSelectionView(gameManager: gameManager)
                .presentationDetents([.medium])
               // .glassEffect(isEnabled: false)
               
              
        }
        
    }
}

#Preview {
    ContentView()
}
