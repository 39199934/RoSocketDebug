//
//  ServersView.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/17.
//

import SwiftUI



struct ServersView: View {
    @ObservedObject var serversViewModel: ServersViewModel
    @State var serverViewModel: ServerViewModel? = nil
    @State var selectedServerViewModel: ServerViewModel? = nil
    @State var isShowAppendNewServerSheet: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
               
                ToolBarItemView(title: "新增服务器", imageName: "plus.rectangle")
                    .padding(.top,20)
                    .onTapGesture {
                        isShowAppendNewServerSheet = true
                    }
                    .sheet(isPresented: $isShowAppendNewServerSheet) {
                        AppendNewServerSetting(servers: serversViewModel, isShowSheet: $isShowAppendNewServerSheet)
                    }
                Divider()
                    .padding(5)
                ScrollView{
                    ForEach(serversViewModel.servers){server in
                        ServersListItemView(serverViewModel: server, selectedServerViewModel: $selectedServerViewModel)
                            .tag(server.id)
                            .onTapGesture {
                                serverViewModel = server
                                selectedServerViewModel = server
                            }
                            .contextMenu(menuItems: {
                                Button("关闭并删除")
                                    {
                                        serversViewModel.remove(server: server)
                                    }
                            })
                            
                            
                    }
                    
                }
                
            }
            VStack{
                if(serverViewModel != nil){
                    ServerView(serverViewModel: selectedServerViewModel!)
                }
            }
        }
    }
}

struct ServersView_Previews: PreviewProvider {
    static var previews: some View {
        ServersView(serversViewModel: ServersViewModel())
    }
}
