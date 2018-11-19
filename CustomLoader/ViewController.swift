/* MIT License
 Copyright (c) 2017 Saurabh Bisht
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 //  Created by Saurabh Bisht.
 //  Copyright © 2017 Saurabh Bisht. All rights reserved.
 //
 */

import UIKit

class ViewController: UIViewController {
    
    let shapeLayer = CAShapeLayer()
    let tPath = CAShapeLayer()
    let lblPercent = UILabel()
    let animate = CABasicAnimation(keyPath: "strokeEnd")
    var animateTimer: Timer?
    var statusTimer: Timer?
    var seconds = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = view.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        tPath.path = circularPath.cgPath
        tPath.strokeColor = UIColor.gray.withAlphaComponent(0.85).cgColor
        tPath.fillColor = UIColor.black.withAlphaComponent(0.65).cgColor
        tPath.lineWidth = 10
        tPath.lineCap = CAShapeLayerLineCap.round
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(red: 106.0/255.0, green: 232.0/255.0, blue: 118.0/255.0, alpha: 1).cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0

        view.layer.addSublayer(tPath)
        view.layer.addSublayer(shapeLayer)
        
        let lblLoad = UILabel()
        lblLoad.frame.size = CGSize(width: 150, height: 20)
        lblLoad.text = "Downloading.."
        lblLoad.textAlignment = .center
        lblLoad.textColor = UIColor.white
        lblLoad.center = view.center
        
        lblPercent.frame.size = CGSize(width: 100, height: 20)
        lblPercent.text = "0%"
        lblPercent.textAlignment = .center
        lblPercent.textColor = UIColor.white
        lblPercent.center = view.center
        lblPercent.center.y = lblLoad.center.y + 20
        
        view.addSubview(lblLoad)
        view.addSubview(lblPercent)
        
        animateTimer = Timer.scheduledTimer(timeInterval: 3, target: self,   selector: (#selector(animateDownload)), userInfo: nil, repeats: true)
    }

   @objc private func animateDownload(){
    self.tPath.fillColor =  UIColor.black.withAlphaComponent(0.65).cgColor

    self.animate.toValue = 1
    self.animate.duration = 3
    
    self.animate.fillMode = CAMediaTimingFillMode.forwards
    self.animate.isRemovedOnCompletion = false
    
    self.shapeLayer.add(self.animate, forKey: "basic")
    self.seconds = 0
    
    self.statusTimer = Timer.scheduledTimer(timeInterval: 0.025, target: self,   selector: (#selector(self.updateStatus)), userInfo: nil, repeats: true)
    
}

    
     @objc private func updateStatus(){
        self.animate.toValue = 0
        if self.seconds > 100 {
            self.lblPercent.text = "Completed"
            self.seconds = 0
            self.tPath.fillColor =  UIColor(red: 20.0/255.0, green: 144.0/255.0, blue: 118.0/255.0, alpha: 1).cgColor
             self.statusTimer?.invalidate()
        } else {
            self.seconds += 1
            self.lblPercent.text = "\(String(self.seconds))%"
        }
    }

}

