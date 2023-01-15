//
//  RoSocketDebugApp.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/15.
//

import SwiftUI

@main
struct RoSocketDebugApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
