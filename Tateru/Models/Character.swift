//
//  CharacterType.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/22/25.
//


import Foundation

struct Character: Identifiable {
    enum CharacterType: String, CaseIterable {
        case hiragana = "Hiragana"
        case katakana = "Katakana"
        case kanji = "Kanji"
    }
    
    let id = UUID()
    let symbol: String
    let romaji: String
    let type: CharacterType
    let examples: [String]
    let pronunciation: String?
    let strokeOrder: String?
    let notes: String?
    let jlptLevel: Int?      // For Kanji only
    let meaning: String?     // For Kanji only
    let onReading: String?   // For Kanji only
    let kunReading: String?  // For Kanji only
}

