//
//  ServersViewModel.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/17.
//

import Foundation

class ServersViewModel: NSObject,ObservableObject{
    @Published var servers: [ServerViewModel]
    
    override init(){
        servers = []
        super.init()
    }
}
extension ServersViewModel{
    public func appendNewServer(on port: UInt16){
        
        servers.append( ServerViewModel(on: port))
    }
    public func remove(server : ServerViewModel){
        if let index = servers.getIndex(of: server){
            servers[index].stopListen()
            servers.remove(at: index)
        }
    }
    
    
}
