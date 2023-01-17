//
//  ClientViewModel.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/14.
//

import Foundation
import CocoaAsyncSocket

class ClientViewModel: NSObject,ObservableObject,Identifiable{
    @Published var client: GCDAsyncSocket
    @Published var connectIp: String
    @Published var connectPort: String
    @Published var localIp: String
    @Published var localPort: String
    @Published var sendStringEncoding: String.Encoding
    @Published var reciveStringEncoding: String.Encoding
    @Published var sendMessage: [MessageModel<String>]
    @Published var reciveMessage: [MessageModel<Data>]
    @Published var id: UUID
    @Published var notificatiton: String
    @Published var isConnected: Bool
    @Published  var clientDescription: String
    @Published  var localDescription: String
    @Published  var connectDescription: String
    let READTAG = 0x99
    var sendMessageDraft: [MessageModel<String>]
    
    override init(){
        id = UUID()
        sendStringEncoding = .utf8
        reciveStringEncoding = .utf8
        sendMessage = []
        reciveMessage = []
        sendMessageDraft = []
        client =  GCDAsyncSocket()
        connectIp = "0.0.0.0"
        connectPort = "5777"
        localIp = "0.0.0.0"
        localPort = "0"
        notificatiton = ""
        clientDescription = "新的客户端"
        localDescription = "新的客户端"
        connectDescription = "新的客户端"
        isConnected = false
        super.init()
        let socket = GCDAsyncSocket(socketQueue: DispatchQueue.init(label: id.uuidString))
        socket.delegateQueue = DispatchQueue.main
        socket.delegate = self
        client = socket
        client.readData(withTimeout: -1, tag: READTAG)
        
    }
    convenience init(socket: GCDAsyncSocket){
        self.init()
        localIp = socket.localHost ?? "0.0.0.0"
        localPort = String(socket.localPort)
        connectIp = socket.connectedHost ?? "0.0.0.0"
        
        connectPort = String(socket.connectedPort)
    
        localDescription = "\(localIp):\(localPort)"
        connectDescription = "\(connectIp):\(connectPort)"
        
        
        notificatiton = ""
        clientDescription = "\(connectIp):\(connectPort)"
        
        localIp = socket.localHost ?? "0.0.0.0"
        localPort = String(socket.localPort)
        connectIp = socket.connectedHost ?? "0.0.0.0"
        
        connectPort = String(socket.connectedPort)
    
        localDescription = "\(localIp):\(localPort)"
        connectDescription = "\(connectIp):\(connectPort)"
        
        
        socket.delegateQueue = DispatchQueue.main
        socket.delegate = self
        client = socket
        client.readData(withTimeout: -1, tag: READTAG)
    }
//    infix operator  == : AdditionPrecedence
    static func == (lhs: ClientViewModel,rhs: ClientViewModel) -> Bool{
        
        return lhs.id == rhs.id
    }
}

extension ClientViewModel: GCDAsyncSocketDelegate{
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        reciveMessage.append(MessageModel(content: data))
        sock.readData(withTimeout: -1, tag: READTAG)
    }
    
    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
        for  index in 0..<sendMessageDraft.count{
            if(sendMessageDraft[index].id.TAGINT == tag){
                sendMessage.append(sendMessageDraft[index])
                sendMessageDraft.remove(at: index)
                break
            }
        }
    }
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        client.readData(withTimeout: -1, tag: READTAG)
        isConnected = true
        self.connectIp = host
        self.connectPort = String(port)
        localIp = sock.localHost ?? "0.0.0.0"
        localPort = String(sock.localPort)
        notificatiton = "已连接上\(host):\(port)"
        clientDescription = "\(connectIp):\(connectPort)"
        localIp = sock.localHost ?? "0.0.0.0"
        localPort = String(sock.localPort)
        connectIp = sock.connectedHost ?? "0.0.0.0"
        
        connectPort = String(sock.connectedPort)
    
        localDescription = "\(localIp):\(localPort)"
        connectDescription = "\(host):\(port)"
        
        
        
    }
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        isConnected = false
        if let ed = err?.localizedDescription{
            notificatiton = "已断开连接：\(ed)"
        }
        notificatiton = "已断开连接,原因未知"
    }
    
    
    
}

extension ClientViewModel{
    func send(message : String){
        let msg = MessageModel(content: message)
        
        sendMessageDraft.append(msg)
        client.write(message.data(using: sendStringEncoding), withTimeout: -1, tag: msg.id.TAGINT)
    }
    func onClickedLink(){
        if client.isConnected{
            client.disconnect()
        }else{
            if let port = UInt16(connectPort){
                do{
                    try client.connect(toHost: connectIp, onPort: port)
                }catch{
                    notificatiton = error.localizedDescription
                }
            }
            
        }
    }
    
}

extension UUID{
    var TAGINT: Int{
        get{
            
            let uuid = self.uuid
            
            let c = uuid.0.hashValue // + uuid.1.hashValue + uuid.2.hashValue + uuid.3.hashValue + uuid.4.hashValue + uuid.5.hashValue + uuid.6.hashValue + uuid.7.hashValue //+ uuid.8.hashValue + uuid.9.hashValue + uuid.10.hashValue + uuid.11.hashValue +  uuid.12.hashValue + uuid.13.hashValue +  uuid.14.hashValue + uuid.15.hashValue
//            let count: Int  = Int(uuid.0 + uuid.1 + uuid.2 + uuid.3 + uuid.4 + uuid.5 + uuid.6 + uuid.7 + uuid.8 + uuid.9 + uuid.10 + uuid.11 +  uuid.12 + uuid.13 +  uuid.14 + uuid.15)
//            let count: Int  = Int(uuid.0 + uuid.1 + uuid.2 + uuid.3 + uuid.4 + uuid.5 + uuid.6 + uuid.7 + uuid.8 + uuid.9 + uuid.10 + uuid.11 +  uuid.12 + uuid.13 +  uuid.14 + uuid.15)
            
            return c
        }
    }
}
