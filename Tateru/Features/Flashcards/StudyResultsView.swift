//
//  StudyResultsView.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/22/25.
//
import SwiftUI

struct StudyResultsView: View {
    let correctCount: Int
    let incorrectCount: Int
    let onDismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Study Session Complete!")
                .font(.title)
                .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("Correct: \(correctCount)")
                }
                
                HStack {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                    Text("Incorrect: \(incorrectCount)")
                }
            }
            .font(.title2)
            
            Button("Done") {
                onDismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.top, 30)
        }
    }
}
