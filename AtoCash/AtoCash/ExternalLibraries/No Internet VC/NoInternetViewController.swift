//
//  NoInternetViewController.swift
//  Trupe
//
//  Created by Shanth on 17/07/19.
//  Copyright © 2019 Trupe App Limited. All rights reserved.
//

import UIKit

import Alamofire
typealias internetHandler = ((_ connection : Bool) -> Void)
class NoInternetViewController: UIViewController {
   // @IBOutlet weak var header: HeaderView!
    @IBOutlet weak var lbloops: UILabel!
    @IBOutlet weak var lblInternetDesc: UILabel!
    @IBOutlet weak var btnTryagain: UIButton!
    var isFromHomeScreen: Bool!
    var completionBlock: internetHandler? = nil
    let aNetworkReachable = NetworkReachabilityManager()

    @IBOutlet weak var backBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //header.delegate = self
        //header.btnMenu.isHidden = true
        // Do any additional setup after loading the view.
//        lbloops.textColor = UIColor(red: 48.0 / 255.0 , green: 170.0 / 255.0, blue: 236.0 / 255.0 , alpha: 1.00)
//        lblInternetDesc.textColor = UIColor(red: 48.0 / 255.0 , green: 170.0 / 255.0, blue: 236.0 / 255.0 , alpha: 1.00)
//        btnTryagain.setTitleColor(UIColor.white, for: .normal)
//        btnTryagain.backgroundColor = UIColor(red: 48.0 / 255.0 , green: 170.0 / 255.0, blue: 236.0 / 255.0 , alpha: 1.00)
        backBtn.layer.cornerRadius = 20.0
        btnTryagain.layer.cornerRadius = 20.0
        

        CheckInternet()

    }
    @IBAction func backBtnAction(_ sender: Any) {
        back()
    }
    
    @IBAction func backAction(_ sender: Any) {
        back()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func back()
    {
        self.dismiss(animated: false, completion: {
            AppDelegate.shared.myNoInternet = false
            self.completionBlock?(false)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
   // func setupUI() {
        
        
    //}
    
    //func setupModel() {
        
   // }
    
    func CheckInternet(){
        
        aNetworkReachable?.listener = { status in
            if self.aNetworkReachable?.isReachable ?? false {
                switch status {
                case .reachable(.ethernetOrWiFi):
                    self.completionBlock?(true)
                    self.dismiss(animated: true, completion: {
                        AppDelegate.shared.myNoInternet = false
                        self.completionBlock = nil
                    })
                    break
                case .reachable(.wwan):
                    self.completionBlock?(true)
                    self.dismiss(animated: true, completion: {
                        AppDelegate.shared.myNoInternet = false
                        self.completionBlock = nil
                    })
                    break
                case .unknown:break

                case .notReachable:break

                }
            }
        }

        
    }
    
    
    @IBAction func retryButtonTapped(_ sender: Any) {
        CheckInternet()
    }
}


