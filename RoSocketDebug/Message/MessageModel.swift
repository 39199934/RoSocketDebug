//
//  MessageModel.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/14.
//

import Foundation
protocol MessageModelProtocol{

    func getMessageForView(stringEncoding: String.Encoding) -> String
}
struct MessageModel<T: Hashable>: Identifiable{
    static func == (lhs: MessageModel<T>, rhs: MessageModel<T>) -> Bool {
        return lhs.id == rhs.id
    }
    var delegate: MessageModelProtocol?
    var id: UUID
    var content: T
    var date: Date
    
    init(content: T) {
        self.id = UUID()
        self.content = content
        self.date = Date.now
        self.delegate = nil
    }
}

extension MessageModel: MessageModelProtocol{
    
    
    func getMessageForView(stringEncoding stringEncoding: String.Encoding) -> String {
        if (T.self == Data.self){
            return String(data: content as! Data, encoding: stringEncoding) ?? "DATA 转换失败"
            
        }
        if(T.self == String.self){
            return content as! String
        }
        
        return "未知类型无法转换"
    }
    
    
}
//extension Array<MessageModel>{
//    mutating func remove(message: MessageModel<T : Hashable>){
//        for index in 0..<self.count{
//            if((self[index] as! MessageModel<T> ).id == message.id){
//                self.remove(at: index)
//            }
//        }
//    }
//}
