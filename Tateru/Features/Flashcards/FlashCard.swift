//
//  FlashCard.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/22/25.
//
import SwiftUI

struct FlashCard<T>: Identifiable {
    let id: UUID
    let prompt: String
    let context: String?
    let answer: String
    let details: [String: String]
    let source: T  // Original item (Character or Vocabulary)
}
