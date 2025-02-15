//
//  CharactersView.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/22/25.
//


import SwiftUI

struct CharactersView: View {
    @State private var selectedType: Character.CharacterType?
    @State private var selectedMode = CharacterStudyMode.symbolToRomaji
    @State private var isStudySessionActive = false
    @State private var isModeToggleOn = false
    private let cardGenerator = CharacterCardGenerator()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Choose character type to study")
                    .font(.title2)
                    .padding(.top)
        
                ForEach(Character.CharacterType.allCases, id: \.self) { type in
                    Button(action: {
                        selectedType = type
                        isStudySessionActive = true
                    }) {
                        HStack {
                            Text(type.rawValue)
                                .font(.headline)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
        
                Toggle("Reverse mode", isOn: $isModeToggleOn)
                    .onChange(of: isModeToggleOn) { _, newValue in
                        selectedMode = newValue ? CharacterStudyMode.romajiToSymbol : CharacterStudyMode.symbolToRomaji
                    }
                
                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $isStudySessionActive) {
                if let type = selectedType {
                    let cards = CharacterSets.getCharacterSet(type).map { chr in
                        cardGenerator.generateCard(from: chr, mode: selectedMode)
                    }
                    StudySessionView(
                        title: type.rawValue,
                        cards: cards,
                        dealer: CountBasedDealer()
                    )
                }
            }
        }
    }
}


