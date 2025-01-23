//
//  FlashCard.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/22/25.
//

import SwiftUI

struct FlashCard: View {
    struct FrontContent {
        let prompt: String
        let context: String?
    }
    
    struct BackContent {
        let answer: String
        let details: [String: String]
    }
    
    typealias FrontContentBuilder = (FlashCardContent) -> FrontContent
    typealias BackContentBuilder = (FlashCardContent) -> BackContent
    
    private let content: FlashCardContent
    private let frontBuilder: FrontContentBuilder
    private let backBuilder: BackContentBuilder
    @State private var isFlipped = false
    
    init(
        content: FlashCardContent,
        frontBuilder: FrontContentBuilder? = nil,
        backBuilder: BackContentBuilder? = nil
    ) {
        self.content = content
        self.frontBuilder = frontBuilder ?? Self.defaultFrontContent
        self.backBuilder = backBuilder ?? Self.defaultBackContent
    }
    
    var body: some View {
        ZStack {
            frontView
                .opacity(isFlipped ? 0 : 1)
                .rotation3DEffect(
                    .degrees(isFlipped ? 180 : 0),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
            
            backView
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(
                    .degrees(isFlipped ? 0 : -180),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
        }
        .frame(width: 300, height: 400)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.isFlipped.toggle()
            }
        }
    }
    
    private var frontView: some View {
        let content = frontBuilder(self.content)

        return VStack(spacing: 0) {
            Text(content.prompt)
                .font(.system(size: 72))
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                
            if let context = content.context {
                Text(context)
                    .font(.system(size: 20))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 5)
    }
    
    private var backView: some View {
        let content = backBuilder(self.content)
        return VStack(spacing: 0) {
            Text(content.answer)
                .font(.system(size: 36))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
            
            Divider()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(Array(content.details.keys.sorted()), id: \.self) { key in
                        if let value = content.details[key] {
                            VStack(alignment: .leading) {
                                Text(key)
                                    .font(.headline)
                                Text(value)
                                    .font(.body)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 5)
    }
    
    private static func defaultFrontContent(from content: FlashCardContent) -> FrontContent {
        switch content {
        case .character(let char):
            return FrontContent(
                prompt: char.symbol,
                context: char.type.rawValue
            )
        case .vocabulary(let vocab):
            return FrontContent(
                prompt: vocab.word,
                context: vocab.partOfSpeech
            )
        }
    }
    
    private static func defaultBackContent(from content: FlashCardContent) -> BackContent {
        switch content {
        case .character(let char):
            var details: [String: String] = [:]
            
            if let pronunciation = char.pronunciation {
                details["Pronunciation"] = pronunciation
            }
            
            if !char.examples.isEmpty {
                details["Examples"] = char.examples.joined(separator: "\n")
            }
            
            if char.type == .kanji {
                if let meaning = char.meaning {
                    details["Meaning"] = meaning
                }
                if let onReading = char.onReading {
                    details["On Reading"] = onReading
                }
                if let kunReading = char.kunReading {
                    details["Kun Reading"] = kunReading
                }
            }
            
            if let notes = char.notes {
                details["Notes"] = notes
            }
            
            return BackContent(
                answer: "\(char.symbol) • \(char.romaji)",
                details: details
            )
            
        case .vocabulary(let vocab):
            var details: [String: String] = [
                "Meaning": vocab.meaning,
                "Reading": vocab.reading
            ]
            
            if !vocab.examples.isEmpty {
                details["Examples"] = vocab.examples.joined(separator: "\n")
            }
            
            if let level = vocab.level {
                details["Level"] = "JLPT N\(level)"
            }
            
            if let notes = vocab.notes {
                details["Notes"] = notes
            }
            
            return BackContent(
                answer: "\(vocab.word) (\(vocab.reading))",
                details: details
            )
        }
    }
}
