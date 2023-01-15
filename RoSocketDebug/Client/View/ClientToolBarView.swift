//
//  ClientToolBarView.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/15.
//

import SwiftUI

struct ClientToolBarView: View {
    @ObservedObject var client: ClientViewModel
    @State private var isShowJsonMaker: Bool = false
    @State private var isShowFormatMessage: Bool = false
    var body: some View {
        HStack{
            //            Image(systemName: <#T##String#>)
            Spacer()
                .frame(width: 10)
            ToolBarItemView(title: "JSON数据", imageName: "list.bullet.circle")
                .onTapGesture {
                    isShowJsonMaker = true
                }
                .sheet(isPresented: $isShowJsonMaker) {
                    JsonMakerView(client: client, isShow: $isShowJsonMaker)
                        .frame(width: 800,height: 640)
                        .frame( minWidth: 640,minHeight: 480)
                }
                .sheet(isPresented: $isShowFormatMessage) {
                    FormatMessageView(client: client, isShow:$isShowFormatMessage)
                        .frame(width: 640,height: 480)
                        .frame( minWidth: 640,minHeight: 480)
                }
            Spacer()
                .frame(width: 10)
//            Divider()
//                .foregroundColor(.red)
//                .fixedSize(horizontal: false, vertical: true)
//                .frame(height: 70)
//                .fontWeight(.bold)
            
            
            
            ToolBarItemView(title: "发送照片", imageName: "photo.circle")
                .onTapGesture {
                    let img = NSImage(named: "test2.png")
                    if let imgData = img!.tiffRepresentation{
                        let imgStr = imgData.base64EncodedString()
                        client.send(message: imgStr)
                    }
                }
            
            Spacer()
                .frame(width: 10)
//            Divider()
//                .foregroundColor(.red)
//                .fixedSize(horizontal: false, vertical: true)
//                .frame(height: 70)
//                .fontWeight(.bold)
            ToolBarItemView(title: "格式化数据", imageName: "wand.and.rays.inverse")
                .onTapGesture {
                    isShowFormatMessage = true
                }
                
//            Spacer()
//                .frame(width: 10)
//            Divider()
//                .foregroundColor(.red)
//                .fixedSize(horizontal: false, vertical: true)
//                .frame(height: 70)
//                .fontWeight(.bold)
//            Spacer()
            Spacer()
            
        }
        .background(.brown.opacity(0.5))
        .padding([.top,.bottom],5)
    }
}

struct ClientToolBarView_Previews: PreviewProvider {
    static var previews: some View {
        ClientToolBarView(client: ClientViewModel())
    }
}
