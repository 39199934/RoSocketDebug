//
//  FormatMessageView.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/15.
//

import SwiftUI
import SwiftyJSON
enum FormatMessageType: Int,CaseIterable,Hashable{
    case text = 1 ,image,command
    var description: String{
        switch self{
        case .text:
            return "文字消息"
        case .image:
            return "示例图片"
        case .command:
            return "json式格式化文本"
        }
    }
    var content: String{
        switch(self){
        case .text:
            return "Test text Message,中文测试"
        case .image:
            let img = NSImage(named: "test2.png")
            if let imgData = img!.tiffRepresentation{
                let img64data = imgData.base64EncodedData()
                
                let imgStr = String(data: img64data,encoding: String.Encoding.utf8) ?? ""
                return imgStr
            }else{
                return ""
            }
        case .command:
            let j : JSON = ["command":"gogogo"]
            return j.description
        }
    }
}

struct FormatMessageView: View {
    @ObservedObject var client: ClientViewModel
    @Binding var isShow: Bool
    var id: UUID = UUID()
    @State var type: FormatMessageType = .text
    @State var content: String = ""
    @State var viewString: String = ""
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading){
            Text("id:\(id.uuidString)")
                .onAppear{
                    refreshJsonString()
                }
            Picker("请选择消息类型", selection: $type) {
                ForEach(FormatMessageType.allCases,id: \.self){ item in
                    Text("\(item.description)").tag(item)
                }
                
            }.onChange(of: type) { newValue in
                refreshJsonString()
            }
            TextEditor(text: $viewString)
//            Text("待发送内容：\(viewString)")
//                .lineLimit(0)
//                .frame(width: 100)
            HStack{
                Button("关闭")
                {
                    isShow = false
                }
                Button("发送")
                {
                    client.send(message: viewString)
                    isShow = false
                }
                Button("添加消息头分段发送")
                {
                    let msgHead: JSON = [
                        "messageLength": viewString.count,
                        "messageId": id.uuidString,
                        "messageType": type.rawValue
                    ]
                    let msgHeadString = msgHead.description
                    DispatchQueue.global().async {
                        client.send(message: msgHeadString)
                        sleep(1)
                        
                        client.send(message: viewString)
                    }
                    
                    isShow = false
                }
            }
        }.padding()
    }
    func refreshJsonString(){
        let json : JSON = [
            "id": id.uuidString,
            "date": Date.now.timeIntervalSince1970,
            "msgType": type.rawValue,
            "content": type.content
        
        ]
        viewString = json.description
        
    }
}

struct FormatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        FormatMessageView(client: ClientViewModel(), isShow: .constant(false))
    }
}
