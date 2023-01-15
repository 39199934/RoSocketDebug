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
    let clientViewModel = ClientViewModel()

    var body: some Scene {
        WindowGroup {
//            ContentView()
            ClientView(client: clientViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
