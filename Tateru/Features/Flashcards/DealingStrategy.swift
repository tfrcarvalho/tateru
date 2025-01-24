//
//  DealingStrategy.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/23/25.
//


protocol DealingStrategy {
    typealias T = Any
    
    func selectNext<T>(from cards: [FlashCard<T>]) -> FlashCard<T>?
    func updateWeight<T>(for card: FlashCard<T>, wasCorrect: Bool)
    func isSessionComplete<T>(cards: [FlashCard<T>]) -> Bool
    func getProgress<T>(cards: [FlashCard<T>]) -> StudyProgress
    func getCardProgress<T>(for card: FlashCard<T>) -> Int
}
