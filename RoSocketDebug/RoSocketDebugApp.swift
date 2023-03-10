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
    let clientsViewModel = ClientsViewModel()
    let serversViewModel = ServersViewModel()

    var body: some Scene {
        WindowGroup {
//            ContentView()
//            ClientView(client: clientViewModel)
//             ClientsView(clientsViewModel: clientsViewModel)
//            ServerView(serverViewModel: serverViewModel)
            MainView(clients: clientsViewModel, servers: serversViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
