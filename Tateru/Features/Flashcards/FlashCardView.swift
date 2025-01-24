//
//  FlashCardView.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/22/25.
//

import SwiftUI

struct FlashCardView<T>: View {
    let card: FlashCard<T>
    @State private var isFlipped = false
    
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
        VStack(spacing: 8) {
            Text(card.prompt)
                .font(.system(size: 72))
            
            if let context = card.context {
                Text(context)
                    .font(.system(size: 20))
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 5)
    }
    
    private var backView: some View {
        VStack(spacing: 0) {
            Text(card.answer)
                .font(.system(size: 36))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
            
            Divider()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(Array(card.details.keys.sorted()), id: \.self) { key in
                        if let value = card.details[key] {
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
}
