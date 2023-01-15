//
//  RecevieMessagesView.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/14.
//

import SwiftUI

struct RecevieMessagesView: View {
    @Binding var reciveMessage: [MessageModel<Data>]
    @Binding var stringEncoding: String.Encoding
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading){
            Text("接收的消息")
                .font(.title3)
                .foregroundColor(.primary)
                .padding()
            ScrollViewReader{ proxy in
                ScrollView{
                    ForEach(reciveMessage,id:\.id){item in
                        ReciveMessageItemView(msg: item.getMessageForView(stringEncoding: stringEncoding)).id(item.id)
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
        RecevieMessagesView(reciveMessage: .constant([]), stringEncoding: .constant(.utf8))
    }
}
