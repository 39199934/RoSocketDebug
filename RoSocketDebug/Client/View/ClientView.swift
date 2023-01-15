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
                Picker("字符编码", selection: $client.stringEncoding) {
                    Text("\(String.Encoding.utf8.description)").tag(String.Encoding.utf8)
                    Text("\(String.Encoding.ascii.description)").tag(String.Encoding.ascii)
                    Text("\(String.Encoding.utf16.description)").tag(String.Encoding.utf16)
                    Text("\(String.Encoding.utf32.description)").tag(String.Encoding.utf32)
                    
                    Text("\(String.Encoding.windowsCP1250.description)").tag(String.Encoding.windowsCP1250)
                    Text("\(String.Encoding.windowsCP1251.description)").tag(String.Encoding.windowsCP1251)
                    Text("\(String.Encoding.windowsCP1252.description)").tag(String.Encoding.windowsCP1252)
                    Text("\(String.Encoding.windowsCP1253.description)").tag(String.Encoding.windowsCP1253)
                    Text("\(String.Encoding.windowsCP1254.description)").tag(String.Encoding.windowsCP1254)
                    
                }.onChange(of: client.stringEncoding) { newValue in
                    client.stringEncoding = newValue
                }
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
