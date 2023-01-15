//
//  JsonMakerView.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/15.
//

import SwiftUI
import SwiftyJSON


struct JsonMakerView: View {
    @ObservedObject var client: ClientViewModel
    @Binding var isShow:Bool
    @State var json: JSON = JSON(stringLiteral: "{}")
    @State var originString: String = ""
    @State var jsonString: String = ""
    @State private var wordCount : Int = 0
    var body: some View {
        VStack{
            HStack{
                ZStack(alignment: .topLeading) {
                    
                    ZStack(alignment: .bottomTrailing) {
                        TextEditor(text: $originString)
                            .font(.title3)
                            .lineSpacing(20)
                        
                        //                            .disableAutocorrection(true)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        //                            .replaceDisabled(true)
                        
                        
                        
                        // 改变时
                            .onChange(of: originString) { _ in
                                //                                let words = originString.split { $0 == " " || $0.isNewline }
                                self.wordCount = originString.count
                            }
                        
                        // 字数统计
                        Text("\(wordCount)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding(.trailing)
                            .padding()
                    }
                    
                    //边框
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    
                    // 注释文字
                    if originString.isEmpty {
                        Text("请输入文本内容")
                            .foregroundColor(Color.secondary)
                            .padding(25)
                    }
                }
                .padding()
                
                
                ZStack(alignment: .topLeading) {
                    
                    ZStack(alignment: .bottomTrailing) {
                        TextEditor(text: $jsonString)
                            .font(.title3)
                            .lineSpacing(20)
                        
                        
                        
                            .disableAutocorrection(true)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        
                        // 改变时
                            .onChange(of: jsonString) { _ in
                                //                                let words = jsonString.split { $0 == " " || $0.isNewline }
                                self.wordCount = jsonString.count
                            }
                        
                        // 字数统计
                        Text("\(wordCount)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding(.trailing)
                            .padding()
                    }
                    
                    //边框
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    
                    // 注释文字
                    if jsonString.isEmpty {
                        Text("显示解析结果")
                            .foregroundColor(Color.secondary)
                            .padding(25)
                    }
                }
                .padding()
                
            }
            HStack{
                Spacer()
                
                Label("检测JSON合格", systemImage: "arrow.right")
                    .onTapGesture {
                        let js = originString
                        if let jsonDataToVerify = js.data(using: String.Encoding.utf8)
                        {
                            do {
                                _ = try JSONSerialization.jsonObject(with: jsonDataToVerify)
                                jsonString = "检测通过\n"
                                jsonString += JSON(originString).description
                                jsonString += "\n\nData:"
                                jsonString += String(data: jsonDataToVerify, encoding: String.Encoding.utf8) ?? ""
                            } catch {
                                jsonString = "Error deserializing JSON: \(error.localizedDescription)"
                            }
                        }
                        
                    }
                    .padding()
                    .background(.gray.opacity(0.5))
                
                Label("检测JSON合格后发送", systemImage: "paperplane.circle")
                    .onTapGesture {
                        let js = originString
                        if let jsonDataToVerify = js.data(using: String.Encoding.utf8)
                        {
                            do {
                                _ = try JSONSerialization.jsonObject(with: jsonDataToVerify)
                                jsonString = "检测通过\n"
                                jsonString += JSON(originString).description
                                jsonString += "\n\nData:"
                                jsonString += String(data: jsonDataToVerify, encoding: String.Encoding.utf8) ?? ""
                                client.send(message: originString)
                            } catch {
                                jsonString = "Error deserializing JSON: \(error.localizedDescription)"
                            }
                        }
                        
                    }
                    .padding()
                    .background(.gray.opacity(0.5))
                
                Spacer()
                Label("关闭", systemImage: "xmark.circle")
                    .onTapGesture{
                        isShow = false
                    }.padding()
                    .background(.gray.opacity(0.5))
                
                Label("发送并关闭", systemImage: "paperplane")
                    .onTapGesture{
                        client.send(message: originString)
                        isShow = false
                    }.padding()
                    .background(.gray.opacity(0.5))
                Spacer()
            }
        }
        .padding()
    }
}

struct JsonMakerView_Previews: PreviewProvider {
    static var previews: some View {
        JsonMakerView(client: ClientViewModel(), isShow: .constant(false))
    }
}
