//
//  VocabularyView.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/22/25.
//


import SwiftUI

struct VocabularyView: View {
   @State private var selectedMode: VocabularyStudyMode?
   @State private var isStudySessionActive = false
   private let cardGenerator = VocabularyCardGenerator()
   
   var body: some View {
       NavigationStack {
           VStack(spacing: 20) {
               Text("Choose study mode")
                   .font(.title2)
                   .padding(.top)
               
               ForEach(VocabularyStudyMode.allCases, id: \.self) { mode in
                   Button(action: {
                       selectedMode = mode
                       isStudySessionActive = true
                   }) {
                       HStack {
                           Text(mode.rawValue)
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
               
               Spacer()
           }
           .padding()
           .navigationDestination(isPresented: $isStudySessionActive) {
               if let mode = selectedMode {
                   let cards = VocabularySets.getVocabulary().map { vocab in
                       cardGenerator.generateCard(from: vocab, mode: mode)
                   }
                   StudySessionView(
                       title: mode.rawValue,
                       cards: cards,
                       dealer: CountBasedDealer()
                   )
               }
           }
       }
   }
}
