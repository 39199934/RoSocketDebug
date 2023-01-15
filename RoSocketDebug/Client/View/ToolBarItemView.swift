//
//  ToolBarItemView.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/15.
//

import SwiftUI

struct ToolBarItemView: View {
    var title: String
    var imageName: String
    
    var body: some View {
        VStack{
            Image(systemName: imageName)
                .resizable()
                .frame(width: 25,height: 25)
                .foregroundColor(.green)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.primary)
            
        }.padding()
            .background(Color.yellow.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

struct ToolBarItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToolBarItemView(title: "测试", imageName: "arrowtriangle.up.square.fill")
    }
}
