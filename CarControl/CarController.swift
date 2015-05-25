//
//  CarController.swift
//  CarControl
//
//  Created by Javier Lanatta on 5/24/15.
//  Copyright (c) 2015 Quadion Techologies. All rights reserved.
//

import Foundation

class CarController: NSObject {
    var connector:CarConnector
    var leftByte:UInt8 = 100
    var rightByte:UInt8 = 100
    
    init(connector carConnector:CarConnector) {
        self.connector = carConnector
    }

    func isConnected() -> Bool {
        return self.connector.isConnected()
    }
    
    func connect() -> Bool {
        if self.connector.connect() {
            self.writeData()
        }
        
        return self.connector.isConnected()
    }
    
    func updateLeftWheel(#directionForward:Bool, speed: UInt8) {
        let newByte = self.byteFor(directionForward: directionForward, speed: speed)
        if newByte != self.leftByte {
            self.leftByte = newByte
            self.writeData()
        }
    }

    func updateRightWheel(#directionForward:Bool, speed: UInt8) {
        let newByte = self.byteFor(directionForward: directionForward, speed: speed)
        if newByte != self.rightByte {
            self.rightByte = newByte
            self.writeData()
        }
    }
    
    func stop() {
        
    }
    
    func byteFor(#directionForward:Bool, speed: UInt8) -> UInt8 {
        if (directionForward) {
            return 100 + speed
        } else {
            return 100 - speed
        }
    }
    
    func writeData() {
        self.connector.write(value: self.leftByte)
        self.connector.write(value: self.rightByte)
    }
}
