//
//  ReciveMessageItem.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/15.
//

import SwiftUI

struct ReciveMessageItemView: View {
    var msg: String
    var body: some View {
        HStack(){
            
            VStack(alignment: HorizontalAlignment.leading){
                Text(msg)
                    .font(.body)
                    .padding(5)
                    .background(.green.opacity(0.3))
                    .padding([.bottom],5)
            }
            Spacer()
        }
    }
}

struct ReciveMessageItemView_Previews: PreviewProvider {
    static var previews: some View {
        ReciveMessageItemView(msg: "recive message")
    }
}
