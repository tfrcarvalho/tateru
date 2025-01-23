//
//  FlashCard.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/22/25.
//
import SwiftUI

enum FlashCard {
    case character(Character)
    case vocabulary(Vocabulary)
    
    var id: UUID {
        switch self {
            case .character(let char): return char.id
            case .vocabulary(let vocab): return vocab.id
        }
    }
}
