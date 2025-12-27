//
//  CharacterSelectionView.swift
//  GameProject
//
//  Created by Nick Gordon on 12/26/25.
//

import SwiftUI


struct CharacterModel: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var name: String
    var assetName: String
    var specificCharacter: CharacterSelect
}

struct CharacterSelectionView: View {
    
    let characters: [CharacterModel] = [
        CharacterModel(name: "Man", assetName: "player1", specificCharacter: .man),
        CharacterModel(name: "Woman", assetName: "girlFrame1", specificCharacter: .woman)
    ]

    @State private var selectedCharacter: CharacterModel? = nil
    var gameManager: GameManager
    @Environment(\.dismiss) var dismiss

    // Grid layout
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        VStack(spacing: 16) {
            Text("Select Your Character")
                .font(.largeTitle).bold()
                .padding(.top, 8)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(characters) { character in
                        CharacterCard(assetName: character.assetName, name: character.name, isSelected: selectedCharacter?.name == character.name)
                            .onTapGesture {
                                self.selectedCharacter = character
                            }
                    }
                
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }

      
            VStack(spacing: 8) {
                if let selectedCharacter {
                    Text("Selected: \(selectedCharacter.name)")
                        .font(.headline)
                } else {
                    Text("Tap a character to select")
                        .foregroundStyle(.secondary)
                }

                Button {
                    if let selectedCharacter {
                        gameManager.currentCharacterSelection = selectedCharacter.specificCharacter
                        dismiss()
                    }
                } label: {
                    Text("Confirm")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedCharacter == nil ? Color.gray.opacity(0.3) : .green)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                .disabled(selectedCharacter == nil)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }
}

private struct CharacterCard: View {
    let assetName: String
    let name: String
    let isSelected: Bool

    var body: some View {
        ZStack {
            // Card background
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(isSelected ? Color.accentColor : Color.white.opacity(0.15), lineWidth: isSelected ? 3 : 1)
                )
                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)

            VStack(spacing: 8) {
                // Character image
                Image(assetName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .padding(.top, 12)

                // Name label
                Text(name)
                    .font(.subheadline).bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .padding(.horizontal, 8)
                    .padding(.bottom, 12)
            }
        }
        .frame(height: 160)
        .overlay(alignment: .topTrailing) {
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, Color.accentColor)
                    .padding(8)
                    .background(
                        Circle().fill(Color.accentColor.opacity(0.2))
                    )
                    .padding(6)
            }
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isSelected)
    }
}

#Preview {
    ContentView()
}
