//
//  Vocabulary.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/22/25.
//
import SwiftUI

struct Vocabulary {
   let id = UUID()
   let meaning: String
   let romaji: String
   let hiragana: String
   let katakana: String
   let kanji: String?
   let word: String // Most common
   let partOfSpeech: String
   let category: Category
   let level: Int?
   let examples: [String]
   let notes: String?
   
   enum Category: String {
       case greetings = "Greetings"
       case calendar = "Calendar"
   }
}
