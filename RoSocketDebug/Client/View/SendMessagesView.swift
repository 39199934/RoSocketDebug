//
//  SendMessagesView.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/14.
//

import SwiftUI

struct SendMessagesView: View {
    @Binding var sendMessage: [MessageModel<String>]
    @Binding var stringEncoding: String.Encoding
    var body: some View {
        
//            Text("send messages")
            VStack(alignment: HorizontalAlignment.trailing){
                Text("发送的消息")
                    .font(.title3)
                    .foregroundColor(.primary)
                    .padding()
                ScrollViewReader{proxy in
                    ScrollView{
                        ForEach(sendMessage,id:\.id){msg in
                            SendMessageItemView(msg: "\(msg.getMessageForView(stringEncoding: stringEncoding))")
                                .onAppear{
                                    proxy.scrollTo(msg.id)
                                }
                        }
                    }
                }
            }
        
    }
}

struct SendMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        SendMessagesView(sendMessage: .constant([]), stringEncoding:.constant(.utf8) )
    }
}
