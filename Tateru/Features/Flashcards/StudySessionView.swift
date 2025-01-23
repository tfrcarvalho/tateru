//
//  StudySessionView.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/22/25.
//
import SwiftUI

// Views/StudySessionView.swift
struct StudySessionView: View {
    let title: String
    let cards: [FlashCardContent]
    
    @State private var currentIndex = 0
    @State private var correctCount = 0
    @State private var incorrectCount = 0
    @State private var showingResults = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        if showingResults {
            StudyResultsView(
                correctCount: correctCount,
                incorrectCount: incorrectCount,
                onDismiss: { dismiss() }
            )
        } else if !cards.isEmpty {
            VStack {
                Text("\(currentIndex + 1) / \(cards.count)")
                    .font(.caption)
                    .padding(.top)

                
                FlashCard(content: cards[currentIndex])
                    .gesture(
                        DragGesture()
                            .onEnded { gesture in
                                if gesture.translation.width > 50 {
                                    markCorrect()
                                } else if gesture.translation.width < -50 {
                                    markIncorrect()
                                }
                            }
                    )
                    .id(currentIndex)
                
                HStack(spacing: 40) {
                    Button(action: markIncorrect) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 44))
                    }
                    
                    Button(action: markCorrect) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.system(size: 44))
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(title)
        } else {
            Text("No cards available")
                .foregroundColor(.secondary)
        }
    }
    
    private func markCorrect() {
        correctCount += 1
        moveToNext()
    }
    
    private func markIncorrect() {
        incorrectCount += 1
        moveToNext()
    }
    
    private func moveToNext() {
        if currentIndex + 1 < cards.count {
            withAnimation {
                currentIndex += 1
            }
        } else {
            showingResults = true
        }
    }
}
