//
//  LaunchAnimationController.swift
//  Segue
//
//  Created by Dushyant Bansal on 18/02/18.
//  Copyright © 2018 db42.in. All rights reserved.
//

import UIKit

class LaunchAnimationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  fileprivate func doAnimation() {
    let fillLayer = CAShapeLayer()
    fillLayer.fillRule = kCAFillRuleEvenOdd
    fillLayer.fillColor = UIColor.black .cgColor
    fillLayer.opacity = 1
    //fillLayer.position = view.center
    //fillLayer.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
    view.layer.addSublayer(fillLayer)
    
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
    
    animation.fillMode = kCAFillModeBoth
    animation.isRemovedOnCompletion = false
    
    fillLayer.add(animation, forKey: animation.keyPath)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    performSegue(withIdentifier: "showRootViewController", sender: nil)
    return
    doAnimation()
  }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
