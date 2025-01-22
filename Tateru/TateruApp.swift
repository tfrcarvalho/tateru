//
//  TateruApp.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/22/25.
//

import SwiftUI

@main
struct TateruApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
