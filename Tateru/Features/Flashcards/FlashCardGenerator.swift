//
//  FlashCardGenerator.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/23/25.
//

protocol FlashCardGenerator {
    associatedtype Source
    associatedtype Mode: StudyMode
    func generateCard(from source: Source, mode: Mode) -> FlashCard<Source>
}
