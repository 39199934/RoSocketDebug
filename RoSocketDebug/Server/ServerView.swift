//
//  ServerView.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/17.
//

import SwiftUI

struct ServerView: View {
    @ObservedObject var serverViewModel: ServerViewModel
    @State var selectedClientViewModel: ClientViewModel? = nil
    var body: some View {
        NavigationView{
            VStack{
//                ToolBarItemView(title: "新增服务器端", imageName: "server.rack")
//                    .padding(.top,20)
//                    .onTapGesture {
//                        clientsViewModel.appendNewClient()
//                    }
                
                HStack{
                    Image(systemName: serverViewModel.isListening ? "ear.and.waveform": "ear.trianglebadge.exclamationmark")
                        .resizable()
                        .frame(width: 16,height: 16)
                        .foregroundColor(serverViewModel.isListening ? Color.green : .red)
                    Text(serverViewModel.serverDescription)
                        .foregroundColor(serverViewModel.clients.count > 0 ? .primary : .secondary)
                        .font(.title3)
                    
                }.contextMenu {
                    Button("开始监听"){
                        serverViewModel.startListen()
                    }
                }
                .padding(.top ,20)
                Button(!serverViewModel.isListening ? "开始监听" : "停止监听"){
                    !serverViewModel.isListening ? serverViewModel.startListen() : serverViewModel.stopListen()
                }
                Divider()
                    .padding(10)
                ScrollView{
                    ForEach(serverViewModel.clients){client in
                        ClientsListItemView(clientViewModel: client, selectedClientViewModel: $selectedClientViewModel,isForClientView: false)
                            .tag(client.id)
                            .onTapGesture {
//                                clientViewModel = client
                                selectedClientViewModel = client
                            }
                            .contextMenu(menuItems: {
                                Button("关闭并删除")
                                    {
                                        serverViewModel.remove(client: client)
                                    }
                            })
                            
                            
                    }
                    
                }
            }
            VStack{
                if(selectedClientViewModel != nil){
                    ClientView(client: selectedClientViewModel!,isForClientView:  false)
                }
            }
        }
    }
}

struct ServerView_Previews: PreviewProvider {
    static var previews: some View {
        ServerView(serverViewModel: ServerViewModel())
    }
}
