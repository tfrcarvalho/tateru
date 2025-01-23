//
//  Vocabulary.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/22/25.
//
import SwiftUI

struct Vocabulary {
    let id = UUID()
    
    let word: String
    let reading: String
    let meaning: String
    let partOfSpeech: String
    let level: Int?
    let examples: [String]
    let notes: String?
}

