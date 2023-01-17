//
//  AppendNewServerSetting.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/17.
//

import SwiftUI

struct AppendNewServerSetting: View {
    @ObservedObject var servers: ServersViewModel
    @State var port: UInt16 = 5666
    @Binding var isShowSheet: Bool
    @State var draft : String = ""
    var body: some View {
        VStack{
            
                Text("请输入服务器端监听端口号：")
                TextField("端口", text: $draft)
                .onChange(of: draft) { newValue in
                    if let newport = UInt16(draft) {
                        port = newport
                    }else{
                        draft = String(port)
                    }
                }
           
            HStack{
                Button("取消")
                {
                    isShowSheet = false
                }
                Button("确定")
                {
                    servers.appendNewServer(on: port)
                    isShowSheet = false
                }
            }
            
        }.onAppear{
            draft = String(port)
        }
        .padding(20)
    }
}

struct AppendNewServerSetting_Previews: PreviewProvider {
    static var previews: some View {
        AppendNewServerSetting(servers: ServersViewModel(), isShowSheet: .constant(true))
    }
}
