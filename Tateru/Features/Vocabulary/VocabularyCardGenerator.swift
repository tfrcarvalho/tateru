//
//  VocabularyCardGenerator.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/23/25.
//


struct VocabularyCardGenerator: FlashCardGenerator {
    typealias Source = Vocabulary
    typealias Mode = VocabularyStudyMode
    
    func generateCard(from vocabulary: Vocabulary, mode: VocabularyStudyMode) -> FlashCard<Vocabulary> {
        let (prompt, context) = makePromptAndContext(from: vocabulary, mode: mode)
        let details = makeDetails(from: vocabulary)
        
        return FlashCard(
            id: vocabulary.id,
            prompt: prompt,
            context: context,
            answer: vocabulary.word,
            details: details,
            source: vocabulary
        )
    }
    
    private func makePromptAndContext(from vocabulary: Vocabulary, mode: VocabularyStudyMode) -> (String, String?) {
        switch mode {
        case .japanese:
            return (vocabulary.word, vocabulary.partOfSpeech)
        case .japaneseWithRomaji:
            return (vocabulary.word, "\(vocabulary.romaji) • \(vocabulary.partOfSpeech)")
        case .english:
            return (vocabulary.meaning, vocabulary.partOfSpeech)
        }
    }
    
    private func makeDetails(from vocabulary: Vocabulary) -> [String: String] {
        var details: [String: String] = [
            "Hiragana": vocabulary.hiragana,
            "Katakana": vocabulary.katakana,
            "Rōmaji": vocabulary.romaji,
            "Meaning": vocabulary.meaning
        ]
        
        if let kanji = vocabulary.kanji {
            details["Kanji"] = kanji
        }
        
        return details
    }
}
