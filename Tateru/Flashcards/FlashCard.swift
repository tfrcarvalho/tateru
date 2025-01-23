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
        
        init(prompt: String, context: String? = nil) {
            self.prompt = prompt
            self.context = context
        }
    }
    
    struct BackContent {
        let answer: String
        let details: [String: String]
        
        init(answer: String, details: [String: String] = [:]) {
            self.answer = answer
            self.details = details
        }
    }
    
    let frontContent: FrontContent
    let backContent: BackContent
    @State private var isFlipped = false
    let debugLayout: Bool
    
    init(frontContent: FrontContent, backContent: BackContent, debugLayout: Bool = false) {
        self.frontContent = frontContent
        self.backContent = backContent
        self.debugLayout = debugLayout
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
        .if(debugLayout) { view in
            view.border(.red)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                isFlipped.toggle()
            }
        }
    }
    
    private var frontView: some View {
        VStack(spacing: 0) {
            // Main content area
            VStack {
                Text(frontContent.prompt)
                    .font(.system(size: 72))
                    .frame(maxWidth: .infinity)
                    .if(debugLayout) { view in
                        view.border(.blue)
                    }
                
                // Context area
                if let context = frontContent.context {
                    Text(context)
                        .font(.system(size: 20))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .if(debugLayout) { view in
                            view.border(.green)
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .if(debugLayout) { view in
                view.border(.purple)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 5)
    }
    
    private var backView: some View {
        VStack(spacing: 0) {
            // Answer section (1/3)
            VStack {
                Text(backContent.answer)
                    .font(.system(size: 36))
                    .multilineTextAlignment(.center)
            }
            .frame(height: 150)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .if(debugLayout) { view in
                view.border(.orange)
            }
            
            Divider()
            
            // Details section (2/3)
            VStack(alignment: .leading, spacing: 10) {
                ForEach(Array(backContent.details.keys.sorted()), id: \.self) { key in
                    if let value = backContent.details[key] {
                        VStack(alignment: .leading) {
                            Text(key)
                                .font(.headline)
                            Text(value)
                                .font(.body)
                        }
                        .if(debugLayout) { view in
                            view.border(.yellow)
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.white)
            .if(debugLayout) { view in
                view.border(.purple)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 5)
    }
}

// Helper extension for conditional modifiers
extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// Preview Provider
struct FlashCard_Previews: PreviewProvider {
    static var previews: some View {
        FlashCard(
            frontContent: FlashCard.FrontContent(
                prompt: "木",
                context: "(noun)"
            ),
            backContent: FlashCard.BackContent(
                answer: "木 (き)",
                details: [
                    "Meaning": "tree",
                    "JLPT Level": "N5",
                    "Pronunciation": "ki",
                    "Example": "木曜日 (もくようび) - Thursday"
                ]
            ),
            debugLayout: false
        )
        .padding()
    }
}
