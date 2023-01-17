//
//  ServerViewModel.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/17.
//


import Foundation
import CocoaAsyncSocket

class ServerViewModel: NSObject,ObservableObject,Identifiable{
    @Published var server: GCDAsyncSocket
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
    @Published  var serverDescription: String
    @Published  var connectedDescription: String
    @Published var clients: [ClientViewModel]
    @Published var isListening: Bool
    let READTAG = 0x99
    var sendMessageDraft: [MessageModel<String>]
    
    override init(){
        id = UUID()
        isListening = false
        sendStringEncoding = .utf8
        reciveStringEncoding = .utf8
        sendMessage = []
        reciveMessage = []
        sendMessageDraft = []
        server =  GCDAsyncSocket()
        connectIp = "0.0.0.0"
        connectPort = "5777"
        localIp = "0.0.0.0"
        localPort = "5778"
        notificatiton = ""
        serverDescription = "新的服务器端"
        connectedDescription = "新的服务器端"
        isConnected = false
        clients = []
        super.init()
        let socket = GCDAsyncSocket(socketQueue: DispatchQueue.init(label: id.uuidString))
        socket.delegateQueue = DispatchQueue.main
        socket.delegate = self
        serverDescription = "\(localIp):\(localPort)"
        connectedDescription = "\(connectIp):\(connectPort)"
        
        server = socket
        
        server.readData(withTimeout: -1, tag: READTAG)
        
    }
    convenience init(on port: UInt16){
        self.init()
        localPort = String(port)
        serverDescription = "\(localIp):\(localPort)"
        connectedDescription = "\(connectIp):\(connectPort)"
    }
//    infix operator  == : AdditionPrecedence
    static func == (lhs: ServerViewModel,rhs: ServerViewModel) -> Bool{
        
        return lhs.id == rhs.id
    }
}
extension ServerViewModel{
    func changePort(to port: UInt16){
        localPort = String(port)
    }
    func startListen(){
        if let p = UInt16(localPort){
            do{
                try server.accept(onPort:  p)
                isListening = true
            }catch{
                notificatiton = error.localizedDescription
            }
        }
    }
    func stopListen(){
        for client in clients{
            client.client.disconnect()
            
        }
        server.disconnect()
    }
}


extension ServerViewModel: GCDAsyncSocketDelegate{
    func socket(_ sock: GCDAsyncSocket, didAcceptNewSocket newSocket: GCDAsyncSocket) {
        serverDescription = "\(sock.connectedHost ?? "0.0.0.0"):\(sock.connectedPort)"
        localIp = sock.localHost ?? "0.0.0.0"
        localPort = String(sock.localPort)
        connectIp = newSocket.connectedHost ?? "0.0.0.0"
        connectPort = String(newSocket.connectedPort)
        serverDescription = "\(localIp):\(localPort)"
        connectedDescription = "\(connectIp):\(connectPort)"
        
        let client = ClientViewModel(socket: newSocket)
        client.isConnected = true
        clients.append(client)
    }
    /*
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
        server.readData(withTimeout: -1, tag: READTAG)
        isConnected = true
        self.connectIp = host
        self.connectPort = String(port)
        localIp = sock.localHost ?? "0.0.0.0"
        localPort = String(sock.localPort)
        notificatiton = "已连接上\(host):\(port)"
        serverDescription = "\(connectIp):\(connectPort)"
    }
     */
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        isConnected = false
        if let ed = err?.localizedDescription{
            notificatiton = "已断开连接：\(ed)"
        }
        notificatiton = "已断开连接,原因未知"
    }
    
    
    
}

extension ServerViewModel{
    func send(message : String){
        let msg = MessageModel(content: message)
        
        sendMessageDraft.append(msg)
        server.write(message.data(using: sendStringEncoding), withTimeout: -1, tag: msg.id.TAGINT)
    }
    func onClickedLink(){
        if server.isConnected{
            server.disconnect()
        }else{
            if let port = UInt16(connectPort){
                do{
                    try server.connect(toHost: connectIp, onPort: port)
                }catch{
                    notificatiton = error.localizedDescription
                }
            }
            
        }
    }
    public func remove(client : ClientViewModel){
        if let index = clients.getIndex(of: client){
            client.client.disconnect()
            clients.remove(at: index)
        }
    }
    
    
}
