//
//  StudyProgress.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/23/25.
//


struct StudyProgress {
   let totalCards: Int
   let learnedCards: Int
   
   var percentComplete: Double {
       Double(learnedCards) / Double(totalCards)
   }
}