//
//  ViewController.swift
//  swipe
//
//  Created by Александр Сенин on 10/12/2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var scrin: UIView!
    var speed = CGPoint(x: 0, y: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrin = UIView(frame: view.frame)
        scrin.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        view.addSubview(scrin)
        
        let swipeRightRecognizer = UIPanGestureRecognizer(target: self, action: #selector(swipeRight))
        scrin.addGestureRecognizer(swipeRightRecognizer)
    }
    
    func closer(x: CGFloat, view: UIView){
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: { () -> Void in
            view.transform.tx = x
        })
    }
    
    func animColor(alpha: CGFloat, view: UIView){
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: { () -> Void in
            view.alpha = alpha
        })
    }
    
    @objc func swipeRight(recognizer: UIPanGestureRecognizer){
        switch recognizer.state {
        case .began:
            animColor(alpha: 1, view: scrin)
        case .changed:
            speed = recognizer.translation(in: self.view)
            let newX = speed.x + scrin.transform.tx
            if newX >= 0 && newX <= view.frame.maxX / 4 * 3{
                scrin.transform.tx = newX
            }else if newX < 0{
                scrin.transform.tx = 0
            }else if newX > view.frame.maxX / 3 * 2{
                scrin.transform.tx = view.frame.maxX / 4 * 3
            }
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        case .ended:
            if ((scrin.transform.tx >= view.frame.width / 4 * 1.5) && (speed.x == 0)) || speed.x > 0{
                closer(x: view.frame.maxX / 4 * 3, view: scrin)
                animColor(alpha: 0.5, view: scrin)
            }else{
                closer(x: 0, view: scrin)
            }
        default: break
        }
    }


}

