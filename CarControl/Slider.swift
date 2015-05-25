//
//  Slider.swift
//  CarControl
//
//  Created by Javier Lanatta on 5/23/15.
//  Copyright (c) 2015 Quadion Techologies. All rights reserved.
//

import UIKit

@IBDesignable
public class Slider: UIView {
    @IBInspectable var margin:CGFloat = 25
    @IBInspectable var sliderHeight:CGFloat = 25
    var value:CGFloat = 0
    
//MARK: - Touch -
    override public func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.updateSliderFor(event: event);
    }
    
    override public func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.updateSliderFor(event: nil);
    }
    
    override public func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.updateSliderFor(event: event);
    }
    
    func updateSliderFor(#event:UIEvent?) {
        if let touch:UITouch = event?.touchesForView(self)?.first as? UITouch {
            let point = touch.locationInView(self)
            self.value = self.valueForY(point.y)
        } else {
            self.value = 0
        }
        self.setNeedsDisplay()
    }
    
//MARK: - Frames and values -
    func innerFrame() -> CGRect {
        return CGRectInset(self.bounds, self.margin, self.margin)
    }

    func valueForY(y:CGFloat) -> CGFloat {
        let h = self.frame.size.height
        let ih = self.innerFrame().height

        if (y < self.margin) {
            return 100
        }
        if (y > (h - self.margin)) {
            return -100
        }

        let realY = y - self.margin
        let value = 100 - (200 * (realY / ih))

        return value
    }

    func sliderRect() -> CGRect {
        let h = self.frame.size.height
        let w = self.frame.size.width

        let sliderWidth = w - 4 * self.margin
        
        let sliderX = (w - sliderWidth)/2
        let sliderOffset =  ((100 - self.value) / 200) * (h - (2*self.sliderHeight))
        let sliderY:CGFloat = 0.5 * self.margin + sliderOffset

        return CGRectMake(sliderX, sliderY, sliderWidth, self.sliderHeight)
    }
    
//MARK: - Drawing -
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsDisplay()
    }

    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if (self.value < 0) {
            UIColor.appRedColor().setStroke()
            UIColor.appRedColor().setFill()
        } else {
            UIColor.appGreenColor().setStroke()
            UIColor.appGreenColor().setFill()
        }
        
        UIRectFrame(self.innerFrame())
        UIRectFill(self.sliderRect())
    }
}