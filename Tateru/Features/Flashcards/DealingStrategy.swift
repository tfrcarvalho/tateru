//
//  DealingStrategy.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/23/25.
//


protocol DealingStrategy {
    func selectNext(from cards: [FlashCard]) -> FlashCard?
    func updateWeight(for card: FlashCard, wasCorrect: Bool)
    func isSessionComplete(cards: [FlashCard]) -> Bool
    func getProgress(cards: [FlashCard]) -> StudyProgress
    func getCardProgress(for card: FlashCard) -> Int
}
