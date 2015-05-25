//
//  CarControllerTests.swift
//  CarControl
//
//  Created by Javier Lanatta on 5/24/15.
//  Copyright (c) 2015 Quadion Techologies. All rights reserved.
//

import Foundation
import XCTest
import CarControl


class CarControllerTests: XCTestCase {
    var connector:DummyCarConnector?
    var controller:CarController?
    
    override func setUp() {
        super.setUp()
        self.connector = DummyCarConnector()
        self.controller = CarController(connector: self.connector!)
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testNewController() {
        if let connected = self.controller?.isConnected() {
            XCTAssertEqual(false, connected)
        }
    }
    
    func testLeftForward() {
        self.controller!.connect()
        self.controller!.updateLeftWheel(directionForward: true, speed: 100)

        let data = self.connector!.data!
        var array:[UInt8] = [UInt8](count: data.length, repeatedValue: 0)
        data.getBytes(&array, length:data.length * sizeof(UInt8))

        XCTAssertEqual(4, data.length)
        XCTAssertEqual([100, 100, 200, 100], array)
    }
    
    func testLeftBackwards() {
        self.controller!.connect()
        self.controller!.updateLeftWheel(directionForward: false, speed: 100)
        
        let data = self.connector!.data!
        var array:[UInt8] = [UInt8](count: data.length, repeatedValue: 0)
        data.getBytes(&array, length:data.length * sizeof(UInt8))
        
        XCTAssertEqual(4, data.length)
        XCTAssertEqual([100, 100, 0, 100], array)
    }
    
    func testLeftForwardSameSpeedDoesntAppendMoreData() {
        self.controller!.connect()
        self.controller!.updateLeftWheel(directionForward: true, speed: 100)
        self.controller!.updateLeftWheel(directionForward: true, speed: 100)
        self.controller!.updateLeftWheel(directionForward: true, speed: 100)
        
        XCTAssertEqual(4, self.connector!.data!.length)
    }

    func testLeftVaryDirectionDoesAppendMoreData() {
        self.controller!.connect()
        self.controller!.updateLeftWheel(directionForward: true, speed: 100)
        self.controller!.updateLeftWheel(directionForward: false, speed: 100)
        self.controller!.updateLeftWheel(directionForward: true, speed: 100)
        
        XCTAssertEqual(8, self.connector!.data!.length)
    }

    
    func testLeftForwardVariingSpeed() {
        self.controller!.connect()
        self.controller!.updateLeftWheel(directionForward: true, speed: 10)
        self.controller!.updateLeftWheel(directionForward: true, speed: 50)
        self.controller!.updateLeftWheel(directionForward: true, speed: 100)

        let data = self.connector!.data!
        var array:[UInt8] = [UInt8](count: data.length, repeatedValue: 0)
        data.getBytes(&array, length:data.length * sizeof(UInt8))

        XCTAssertEqual(8, data.length)
        XCTAssertEqual([100, 100, 110, 100, 150, 100, 200, 100], array)
    }
    
    func testRightForwardAndBackwards() {
        self.controller!.connect()
        self.controller!.updateRightWheel(directionForward: true, speed: 10)
        self.controller!.updateRightWheel(directionForward: false, speed: 10)
        self.controller!.updateRightWheel(directionForward: true, speed: 10)
        
        let data = self.connector!.data!
        var array:[UInt8] = [UInt8](count: data.length, repeatedValue: 0)
        data.getBytes(&array, length:data.length * sizeof(UInt8))
        
        XCTAssertEqual(8, data.length)
        XCTAssertEqual([100, 100, 100, 110, 100, 90, 100, 110], array)
    }
}
