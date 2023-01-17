//
//  MainView.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/17.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var clients: ClientsViewModel
    @ObservedObject var servers: ServersViewModel
    var body: some View {
        TabView {
            ClientsView(clientsViewModel: clients)
                .tabItem {
                    Text("客户端")
                        .font(.title)
                }
            ServersView(serversViewModel: servers)
                .tabItem {
                    Text("服务器端")
                        .font(.title)
                }
        }.tabViewStyle(DefaultTabViewStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(clients: ClientsViewModel(), servers: ServersViewModel())
    }
}
