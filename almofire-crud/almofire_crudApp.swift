//
//  almofire_crudApp.swift
//  almofire-crud
//
//  Created by Bholanath Barik on 03/08/24.
//

import SwiftUI

@main
struct almofire_crudApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
