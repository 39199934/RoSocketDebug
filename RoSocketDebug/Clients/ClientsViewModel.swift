//
//  ClientsViewModel.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/16.
//

import Foundation


class ClientsViewModel: NSObject,ObservableObject{
    @Published var clients:[ClientViewModel]
    override init() {
        clients = []
        super.init()
    }
}
extension ClientsViewModel{
    public func appendNewClient(){
        clients.append( ClientViewModel())
    }
    public func remove(client : ClientViewModel){
        if let index = clients.getIndex(of: client){
            client.client.disconnect()
            clients.remove(at: index)
        }
    }
    
    
}
extension Array where Element: Identifiable{
    func getIndex(of item:Element) -> Int?{
        
        for index in 0..<self.count{
            if(self[index].id ==  item.id){
                return index
            }
        }
        return nil
    }
        
}
