//
//  CarConnector.swift
//  CarControl
//
//  Created by Javier Lanatta on 5/24/15.
//  Copyright (c) 2015 Quadion Techologies. All rights reserved.
//

import Foundation

protocol CarConnector {
    func connect() -> Bool
    func isConnected() -> Bool
    func disconnect()
    func write(#value:UInt8)
}