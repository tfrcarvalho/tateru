//
//  ContentView.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/22/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        TabView {
            CharactersView()
                .tabItem {
                    Image(uiImage: TextImage.generate(from: "もじ"))
                    Text("Characters")
                }
            
            VocabularyView()
                .tabItem {
                    Image(uiImage: TextImage.generate(from: "ことば"))
                    Text("Vocabulary")
                }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
