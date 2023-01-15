//
//  RecevieMessagesView.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/14.
//

import SwiftUI

struct RecevieMessagesView: View {
    @Binding var reciveMessage: [MessageModel<Data>]
    @Binding var reciveStringEncoding: String.Encoding
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading){
            HStack{
                Text("接收的消息，共计\(reciveMessage.count)条")
                    .font(.title3)
                    .foregroundColor(.primary)
                    .padding()
                Picker("字符编码", selection: $reciveStringEncoding) {
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
                    
                }.onChange(of: reciveStringEncoding) { newValue in
                    reciveStringEncoding = newValue
                }
                Button("清除所有记录"){
                    reciveMessage = []
                }.padding()
                Spacer()
            }
            .background(Color.gray.opacity(0.5))
            ScrollViewReader{ proxy in
                ScrollView{
                    ForEach(reciveMessage,id:\.id){item in
                        ReciveMessageItemView(msg: item.getMessageForView(stringEncoding: reciveStringEncoding)).id(item.id)
                            .onAppear{
                                proxy.scrollTo(item.id)
                            }
                    }
                }
            }
        }
    }
}

struct RecevieMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        RecevieMessagesView(reciveMessage: .constant([]), reciveStringEncoding: .constant(.utf8))
    }
}
