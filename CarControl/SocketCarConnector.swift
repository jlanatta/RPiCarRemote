//
//  SocketCarConnector.swift
//  CarControl
//
//  Created by Javier Lanatta on 5/24/15.
//  Copyright (c) 2015 Quadion Techologies. All rights reserved.
//

import Foundation

class SocketCarConnector: CarConnector {
    let address:String
    let port:NSInteger
    let client:TCPClient
    var connected:Bool = false
    
    init(address:String, andPort port:NSInteger) {
        self.address = address
        self.port = port
        self.client = TCPClient(addr: self.address, port: self.port)
    }

    func connect() -> Bool {
        var (success, errmsg) = self.client.connect(timeout: 1)
        self.connected = success
        return success
    }
    
    func isConnected() -> Bool {
        return self.connected
    }
    
    func disconnect() {
        self.client.close()
        self.connected = false
    }
    
    func write(#value:UInt8) {
        if self.isConnected() {
            self.client.send(data: [value])
        }
    }
}