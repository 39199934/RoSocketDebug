//
//  SendMessageView.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/14.
//

import SwiftUI

struct SendMessageControllerView: View {
    @ObservedObject var client: ClientViewModel
    @State var draft: String = ""
    var body: some View {
        HStack{
            TextField("发送消息", text: $draft)
            Button("发送")
            {
                client.send(message: draft)
                draft = ""
            }
        }.padding()
    }
}

struct SendMessageControllerView_Previews: PreviewProvider {
    static var previews: some View {
        SendMessageControllerView(client: ClientViewModel())
    }
}
