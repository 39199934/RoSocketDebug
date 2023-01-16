//
//  ClientsView.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/16.
//

import SwiftUI

struct ClientsView: View {
    @ObservedObject var clientsViewModel: ClientsViewModel
    @State var clientViewModel: ClientViewModel? = nil
    @State var selectedClientViewModel: ClientViewModel? = nil
    
    var body: some View {
        NavigationView{
            VStack{
               
                ToolBarItemView(title: "新增客户端", imageName: "plus.rectangle")
                    .padding(.top,20)
                    .onTapGesture {
                        clientsViewModel.appendNewClient()
                    }
                Divider()
                    .padding(5)
                ScrollView{
                    ForEach(clientsViewModel.clients){client in
                        ClientsListItemView(clientViewModel: client, selectedClientViewModel: $selectedClientViewModel)
                            .tag(client.id)
                            .onTapGesture {
                                clientViewModel = client
                                selectedClientViewModel = client
                            }
                            .contextMenu(menuItems: {
                                Button("关闭并删除")
                                    {
                                        clientsViewModel.remove(client: client)
                                    }
                            })
                            
                            
                    }
                    
                }
                
            }
            VStack{
                if(clientViewModel != nil){
                    ClientView(client: clientViewModel!)
                }
            }
        }
    }
}

struct ClientsView_Previews: PreviewProvider {
    static var previews: some View {
        ClientsView(clientsViewModel: ClientsViewModel())
    }
}
