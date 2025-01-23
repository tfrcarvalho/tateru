//
//  StudySessionView.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/22/25.
//
import SwiftUI

struct StudySessionView: View {
    let title: String
    let cards: [FlashCard]
    let dealer: DealingStrategy
    
    @State private var currentCard: FlashCard?
    @State private var correctCount = 0
    @State private var incorrectCount = 0
    @State private var showingResults = false
    @Environment(\.dismiss) private var dismiss
    
    init(title: String, cards: [FlashCard], dealer: DealingStrategy) {
        self.title = title
        self.cards = cards
        self.dealer = dealer
        _currentCard = State(initialValue: dealer.selectNext(from: cards))
    }
    
    var body: some View {
        if showingResults {
            StudyResultsView(correctCount: correctCount, incorrectCount: incorrectCount, onDismiss: { dismiss() })
        } else if let card = currentCard {
            VStack {
                let progress = dealer.getProgress(cards: cards)
                Text("\(progress.learnedCards)/\(progress.totalCards)")
                    .font(.caption)
                    .padding(.top)
                
                FlashCardView(content: card)
                    .gesture(DragGesture().onEnded { gesture in
                        if gesture.translation.width > 50 {
                            markCorrect()
                        } else if gesture.translation.width < -50 {
                            markIncorrect()
                        }
                    })
                    .overlay(alignment: .topTrailing) {
                        HStack {
                            ForEach(0..<dealer.getCardProgress(for: card), id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                            ForEach(0..<(3 - dealer.getCardProgress(for: card)), id: \.self) { _ in
                                Image(systemName: "star")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(8)
                    }
                
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
            .onAppear { dealNextCard() }
        }
    }
    
    private func markCorrect() {
        correctCount += 1
        dealer.updateWeight(for: currentCard!, wasCorrect: true)
        dealNextCard()
    }
    
    private func markIncorrect() {
        incorrectCount += 1
        dealer.updateWeight(for: currentCard!, wasCorrect: false)
        dealNextCard()
    }
    
    private func dealNextCard() {
        if dealer.isSessionComplete(cards: cards) {
            showingResults = true
        } else {
            currentCard = dealer.selectNext(from: cards)
        }
    }
}
