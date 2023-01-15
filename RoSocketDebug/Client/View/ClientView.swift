//
//  ClientView.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/14.
//

import SwiftUI

struct ClientView: View {
    @ObservedObject var client: ClientViewModel
    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
                HStack{
                    Text(client.isConnected ? "已连接":"未连接")
                        .font(.title)
                        .foregroundColor(client.isConnected ? Color.green:Color.red)
                    Image(systemName: client.isConnected ? "waveform":"waveform.slash")
                        .resizable()
                        .frame(width: 25,height: 25)
                        .foregroundColor(client.isConnected ? Color.green:Color.red)
                    
                    
                }
                Text("服务器地址")
                    .font(.headline)
                    .foregroundColor(.secondary)
                TextField("地址", text: $client.hostIp)
                Text("服务器端口")
                    .font(.headline)
                    .foregroundColor(.secondary)
                TextField("端口", text: $client.hostPort)
                Text("字符编码：\(client.stringEncoding.description)")
                Button(client.isConnected ? "断开连接":"连接"){
                    client.onClickedLink()
                    
                }
//                if(!client.notificatiton.isEmpty){
//                    Text(client.notificatiton)
//                        .font(.title2)
//                        .foregroundColor(.red)
//                }
                Spacer()
            }.padding()
            VStack{
                
                RecevieMessagesView(reciveMessage: $client.reciveMessage, stringEncoding: $client.stringEncoding)
                    
                Divider()
                SendMessagesView(sendMessage: $client.sendMessage, stringEncoding: $client.stringEncoding)
                SendMessageControllerView(client: client, draft: "")
                
            }.padding()
        }
    }
}

struct ClientView_Previews: PreviewProvider {
    static var previews: some View {
        ClientView(client: ClientViewModel())
    }
}
