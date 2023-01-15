//
//  SendMessageItemView.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/15.
//

import SwiftUI

struct SendMessageItemView: View {
    var msg: String
    var body: some View {
        HStack(){
            Spacer()
            VStack(alignment: HorizontalAlignment.trailing){
                Text(msg)
                    .padding(5)
                    .font(.body)
                    .background(.gray.opacity(0.4))
                    .padding(.bottom,5)
                
            }
        }
    }
}

struct SendMessageItemView_Previews: PreviewProvider {
    static var previews: some View {
        SendMessageItemView(msg: "sendMesage")
    }
}
