//
//  SendMessagesView.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/14.
//

import SwiftUI

struct SendMessagesView: View {
    @Binding var sendMessage: [MessageModel<String>]
    @Binding var sendStringEncoding: String.Encoding
    var body: some View {
        
//            Text("send messages")
            VStack(alignment: HorizontalAlignment.trailing){
                
                HStack{
                    Text("发送的消息，共计\(sendMessage.count)条")
                        .font(.title3)
                        .foregroundColor(.primary)
                        .padding()
                    Picker("字符编码", selection: $sendStringEncoding) {
                        Group{
                            Text("\(String.Encoding.utf8.description)").tag(String.Encoding.utf8)
                            Text("\(String.Encoding.ascii.description)").tag(String.Encoding.ascii)
                            Text("\(String.Encoding.utf16.description)").tag(String.Encoding.utf16)
                            Text("\(String.Encoding.utf16BigEndian.description)").tag(String.Encoding.utf16BigEndian)
                            Text("\(String.Encoding.utf16LittleEndian.description)").tag(String.Encoding.utf16LittleEndian)
                            Text("\(String.Encoding.utf32.description)").tag(String.Encoding.utf32)
                            Text("\(String.Encoding.utf32BigEndian.description)").tag(String.Encoding.utf32BigEndian)
                            Text("\(String.Encoding.utf32LittleEndian.description)").tag(String.Encoding.utf32LittleEndian)
                            Text("\(String.Encoding.unicode.description)").tag(String.Encoding.unicode)
                        }
                        Group{
                            Text("\(String.Encoding.windowsCP1250.description)").tag(String.Encoding.windowsCP1250)
                            Text("\(String.Encoding.windowsCP1251.description)").tag(String.Encoding.windowsCP1251)
                            Text("\(String.Encoding.windowsCP1252.description)").tag(String.Encoding.windowsCP1252)
                            Text("\(String.Encoding.windowsCP1253.description)").tag(String.Encoding.windowsCP1253)
                            Text("\(String.Encoding.windowsCP1254.description)").tag(String.Encoding.windowsCP1254)
                        }
                        
                       
                        
                        
                    }.onChange(of: sendStringEncoding) { newValue in
                        sendStringEncoding = newValue
                    }
                    Button("清除所有记录"){
                        sendMessage = []
                    }.padding()
                    
                    Spacer()
                }
                .background(Color.green.opacity(0.3))
                ScrollViewReader{proxy in
                    ScrollView{
                        ForEach(sendMessage,id:\.id){msg in
                            SendMessageItemView(msg: "\(msg.getMessageForView(stringEncoding: sendStringEncoding))")
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
        SendMessagesView(sendMessage: .constant([]), sendStringEncoding:.constant(.utf8) )
    }
}
