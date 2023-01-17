//
//  ClientView.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/14.
//

import SwiftUI

struct ClientView: View {
    @ObservedObject var client: ClientViewModel
    var isForClientView: Bool = true
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
                Group{
                    if(isForClientView){
                        Text("本地地址:\(client.localIp)")
                            .font(.headline)
                            .foregroundColor(client.isConnected ? .primary : .secondary)
                        Text("本地端口:\(client.localPort)")
                            .font(.headline)
                            .foregroundColor(client.isConnected ? .primary : .secondary)
                        Divider()
                    }
                    Text(isForClientView ? "服务器地址": "客户端地址")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    TextField("地址", text: $client.connectIp )
//                    TextField("地址", text: isForClientView  ? $client.localIp: $client.connectIp )
                    Text(isForClientView ? "服务器端口": "客户端端口")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    TextField("端口", text:  $client.connectPort)
//                    TextField("端口", text: isForClientView ? $client.localPort : $client.connectPort)
                }
                Divider()
                Text("接收字符编码：\(client.reciveStringEncoding.description)")
                Text("发送字符编码：\(client.sendStringEncoding.description)")
                Divider()

                if( isForClientView){
                    Button(client.isConnected ? "断开连接":"连接"){
                        client.onClickedLink()
                        
                    }
                }else{
                    Button(client.isConnected ? "断开连接":"已断开"){
                        if client.isConnected{
                            client.client.disconnect()
                        }
                        
                    }
                }
//                if(!client.notificatiton.isEmpty){
//                    Text(client.notificatiton)
//                        .font(.title2)
//                        .foregroundColor(.red)
//                }
                Spacer()
            }.padding()
                .lineSpacing(10)
            VStack{
                
                RecevieMessagesView(reciveMessage: $client.reciveMessage, reciveStringEncoding: $client.reciveStringEncoding)
                    
                Divider()
                SendMessagesView(sendMessage: $client.sendMessage, sendStringEncoding: $client.sendStringEncoding)
                ClientToolBarView(client: client)
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
