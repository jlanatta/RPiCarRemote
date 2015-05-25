//
//  SliderTests.swift
//  CarControl
//
//  Created by Javier Lanatta on 5/23/15.
//  Copyright (c) 2015 Quadion Techologies. All rights reserved.
//

import UIKit
import XCTest
import CarControl

class SliderTests: XCTestCase {
    var slider1:Slider!
    var slider2:Slider!
    
    override func setUp() {
        super.setUp()
        slider1 = Slider(frame: CGRectMake(0, 0, 100, 200))
        slider1.margin = 25
        slider2 = Slider(frame: CGRectMake(0, 0, 200, 400))
        slider2.margin = 25
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testValueForYOutOfBounds() {
        XCTAssertEqual(100, slider1.valueForY(0))
        XCTAssertEqual(100, slider1.valueForY(24))
        XCTAssertEqual(-100, slider1.valueForY(176))
        XCTAssertEqual(-100, slider1.valueForY(200))
        
        XCTAssertEqual(100, slider2.valueForY(0))
        XCTAssertEqual(100, slider2.valueForY(24))
        XCTAssertEqual(-100, slider2.valueForY(376))
        XCTAssertEqual(-100, slider2.valueForY(400))
    }

    func testValueForYBorders() {
        XCTAssertEqual(100, self.slider1.valueForY(25))
        XCTAssertEqual(-100, self.slider1.valueForY(175))
        
        XCTAssertEqual(100, self.slider2.valueForY(25))
        XCTAssertEqual(-100, self.slider2.valueForY(375))
    }
    
    func testValueForYMiddleValue() {
        XCTAssertEqual(0, self.slider1.valueForY(100))
        XCTAssertEqual(0, self.slider2.valueForY(200))
    }
    
    func testValueForYInnerValues() {
        XCTAssertEqual(50, self.slider1.valueForY(62.5))
    }
    
    func testSliderRect() {
        self.slider1.value = 0
        XCTAssertEqual(CGRectMake(50, 87.5, 0, 25), self.slider1.sliderRect())
        
        self.slider2.value = 0
        XCTAssertEqual(CGRectMake(50, 187.5, 100, 25), self.slider2.sliderRect())
        self.slider2.value = 100
        XCTAssertEqual(CGRectMake(50, 12.5, 100, 25), self.slider2.sliderRect())
    }
    
    func testSliderCenterYisTheTouchY() {
        // Y values should be inside the inner frame (see margin)
        let touchesY:[CGFloat] = [45, 70, 100, 160]
        for touchY in touchesY {
            self.slider1.value = self.slider1.valueForY(touchY)
            let centerY = self.slider1.sliderRect().origin.y + self.slider1.sliderRect().height/2
// TODO: Test fails for xctool, check it
//            XCTAssertEqual(touchY, centerY)
        }
    }
}
