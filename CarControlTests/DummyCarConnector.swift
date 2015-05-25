//
//  DummyCarConnector.swift
//  CarControl
//
//  Created by Javier Lanatta on 5/24/15.
//  Copyright (c) 2015 Quadion Techologies. All rights reserved.
//

import Foundation

class DummyCarConnector: CarConnector {
    var data:NSMutableData? = nil
    
    func connect() -> Bool {
        self.data = NSMutableData()
        return true
    }
    
    func isConnected() -> Bool {
        return self.data != nil
    }
    
    func send(#data: NSData) {
        if (self.isConnected()) {
            if let myData = self.data {
                myData.appendData(data)
            }
        }
    }
    
    func disconnect() {
        self.data = nil
    }
    
    func write(value val:UInt8) {
        var value:UInt8 = val
        self.data?.appendBytes(&value, length: 1)
    }
}
