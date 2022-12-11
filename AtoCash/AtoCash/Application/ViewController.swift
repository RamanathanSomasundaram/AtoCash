//
//  ViewController.swift
//  AtoCash
//
//  Created by user on 02/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backImge: UIImageView!
    @IBOutlet weak var logoImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        logoImg.layer.cornerRadius = logoImg.frame.size.height / 2
//        logoImg.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//            
//            UIView.animate(withDuration: 1.35, delay: 0,
//                                       usingSpringWithDamping: 0.25,
//                                       initialSpringVelocity: 5,
//                                       options: .curveEaseOut,
//                                       animations: {
//                                        
//                self.logoImg.transform = .identity
//                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                                            AppDelegate.shared.setupRootViewController()
//                                        }
//                
//            })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        backImge.layer.cornerRadius = backImge.frame.size.height / 2
        //logoImg.layer.cornerRadius = logoImg.frame.size.height / 2
        logoImg.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
            UIView.animate(withDuration: 1.35, delay: 0,
                                       usingSpringWithDamping: 0.25,
                                       initialSpringVelocity: 5,
                                       options: .curveEaseOut,
                                       animations: {
                                        
                self.logoImg.transform = .identity
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                            AppDelegate.shared.setupRootViewController()
                                        }
                
            })
    }

}

