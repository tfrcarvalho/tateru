//
//  CharacterCardGenerator.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/23/25.
//


struct CharacterCardGenerator: FlashCardGenerator {
    typealias Source = Character
    typealias Mode = CharacterStudyMode
    
    func generateCard(from character: Character, mode: CharacterStudyMode) -> FlashCard<Character> {
        let details = makeDetails(from: character)
        
        // Answer is always romaji for consistency
        return FlashCard(
            id: character.id,
            prompt: makePrompt(from: character, mode: mode),
            context: character.type.rawValue,
            answer: character.romaji,
            details: details,
            source: character
        )
    }
    
    private func makePrompt(from character: Character, mode: CharacterStudyMode) -> String {
        return character.symbol
    }
    
    private func makeDetails(from character: Character) -> [String: String] {
        var details: [String: String] = [:]
        
        if let pronunciation = character.pronunciation {
            details["Pronunciation"] = pronunciation
        }
        
        if !character.examples.isEmpty {
            details["Examples"] = character.examples.joined(separator: "\n")
        }
        
        if character.type == .kanji {
            if let meaning = character.meaning {
                details["Meaning"] = meaning
            }
            if let onReading = character.onReading {
                details["On Reading"] = onReading
            }
            if let kunReading = character.kunReading {
                details["Kun Reading"] = kunReading
            }
        }
        
        if let notes = character.notes {
            details["Notes"] = notes
        }
        
        return details
    }
}
