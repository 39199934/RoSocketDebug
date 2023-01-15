//
//  File.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/14.
//

import Foundation
import CocoaAsyncSocket

struct ClientModel: Identifiable,Hashable{
    var socket: GCDAsyncSocket
    var id: UUID
    
    init(socket: GCDAsyncSocket) {
        self.socket = socket
        self.id = UUID()
    }
}
