//
//  CountBasedDealer.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/23/25.
//
import SwiftUI

class CountBasedDealer: DealingStrategy {
    private struct CardState {
        var repetitionsNeeded: Int = 3
        var correctStreak: Int = 0
        var weight: Double = 1.0
    }
    
    private var cardStates: [UUID: CardState] = [:]
    private let weightIncreaseMultiplier: Double = 1.5
    private let weightDecreaseMultiplier: Double = 0.7
    
    func updateWeight(for card: FlashCard, wasCorrect: Bool) {
        var state = cardStates[card.id, default: CardState()]
        
        if wasCorrect {
            state.correctStreak += 1
            state.weight *= weightDecreaseMultiplier
        } else {
            state.correctStreak = 0
            state.weight *= weightIncreaseMultiplier
        }
        
        cardStates[card.id] = state
    }
    
    func getProgress(cards: [FlashCard]) -> StudyProgress {
        let learned = cards.filter { cardStates[$0.id]?.correctStreak ?? 0 >= 3 }.count
        return StudyProgress(totalCards: cards.count, learnedCards: learned)
    }
    
    func selectNext(from cards: [FlashCard]) -> FlashCard? {
       let availableCards = cards.filter { card in
           cardStates[card.id]?.correctStreak ?? 0 < 3
       }
       
       let totalWeight = availableCards.reduce(0.0) { sum, card in
           sum + (cardStates[card.id]?.weight ?? 1.0)
       }
       
       let targetWeight = Double.random(in: 0...totalWeight)
       var currentWeight = 0.0
       
       for card in availableCards {
           currentWeight += cardStates[card.id]?.weight ?? 1.0
           if currentWeight >= targetWeight {
               return card
           }
       }
       
       return availableCards.first
    }

    func isSessionComplete(cards: [FlashCard]) -> Bool {
       cards.allSatisfy { card in
           cardStates[card.id]?.correctStreak ?? 0 >= 3
       }
    }
    
    func getCardProgress(for card: FlashCard) -> Int {
           cardStates[card.id]?.correctStreak ?? 0
       }
}
