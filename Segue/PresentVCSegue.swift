//
//  PresentVCSegue.swift
//  Segue
//
//  Created by Dushyant Bansal on 18/02/18.
//  Copyright © 2018 db42.in. All rights reserved.
//

import UIKit

class PresentVCSegue: UIStoryboardSegue {
  var destinationView: UIView?
  
  func performNormal() {
    let sourceView = self.source.view!
    let destinationView = self.destination.view!
    
    let screenHeight = UIScreen.main.bounds.size.height
    let screenWidth = UIScreen.main.bounds.size.width

    let destinationFrame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: screenHeight)
    destinationView.frame =  destinationFrame
    
    let window = UIApplication.shared.keyWindow
    window?.insertSubview(destinationView, aboveSubview: sourceView)
    
    UIView.animate(withDuration: 1, animations: {
      destinationView.frame = destinationView.frame.offsetBy(dx: 0, dy: -screenHeight)
      sourceView.frame = sourceView.frame.offsetBy(dx: 0, dy: -screenHeight)
    }) { (finished) in
      destinationView.removeFromSuperview()
      self.source.present(self.destination, animated: false, completion: nil)
    }
  }
  
  override func perform() {
    let sourceView = self.source.view!
    let destinationView = self.destination.view!
    
    let screenHeight = UIScreen.main.bounds.size.height
    let screenWidth = UIScreen.main.bounds.size.width
    
    let destinationFrame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
    destinationView.frame =  destinationFrame
    
    let window = UIApplication.shared.keyWindow
    window?.insertSubview(destinationView, aboveSubview: sourceView)
    self.destinationView = destinationView
    
    let fillLayer = CAShapeLayer()
    fillLayer.fillRule = kCAFillRuleEvenOdd
    fillLayer.fillColor = UIColor.yellow.cgColor
    fillLayer.opacity = 1
    window?.layer.addSublayer(fillLayer)
    
    let w = UIScreen.main.bounds.size.width
    let h = UIScreen.main.bounds.size.height
    
    let bigRect = CGRect(x: 0, y: 0, width: w, height: h)
    let smallRect = CGRect(x: w/2-30, y: h/2-30, width: 60, height: 60)
    
    let pathBigRect = UIBezierPath(rect: bigRect)
    let pathSmallRect = UIBezierPath(roundedRect: smallRect, cornerRadius: 30.0)
    
    pathBigRect.append(pathSmallRect)
    pathBigRect.usesEvenOddFillRule = true
    
    
    let toSmallRect = CGRect(x: (w-1000)/2, y: (h-1000)/2, width: 1000, height: 1000)
    let toPathBigRect = UIBezierPath(rect: bigRect)
    let toPathSmallRect = UIBezierPath(roundedRect: toSmallRect, cornerRadius: h/2)
    
    toPathBigRect.append(toPathSmallRect)
    toPathBigRect.usesEvenOddFillRule = true
    //start path
    fillLayer.path = pathBigRect.cgPath
    //animate path
    let animation = CABasicAnimation(keyPath: "path")
    animation.toValue = toPathBigRect.cgPath
    animation.duration = 1
    animation.delegate = self
    
    animation.fillMode = kCAFillModeBoth
    animation.isRemovedOnCompletion = false
    
    fillLayer.add(animation, forKey: animation.keyPath)
  }
}

extension PresentVCSegue: CAAnimationDelegate {
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    self.destinationView?.removeFromSuperview()
    self.source.present(self.destination, animated: false, completion: nil)
  }
}
