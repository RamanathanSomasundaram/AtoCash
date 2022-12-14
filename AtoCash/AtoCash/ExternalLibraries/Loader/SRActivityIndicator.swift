//
//  SR_ActivityIndicator.swift
//  SR_Activity_Indicator
//
//  Created by Saroj on 4/7/16.
//  Copyright © 2016 Saroj. All rights reserved.
///

import UIKit

public enum maskType {
    case Dim
    case Blur
}
//Loader showing
public func showLoader(_ innerStroke : UIColor = UIColor.init(named: "GradientStart")!, outerStroke : UIColor? = nil ,imageSize : CGFloat = 50, imageName : String = "NewLogo", backgroundType : maskType = .Blur) {
    SRActivityIndicator.innerStrokeColor = innerStroke
    SRActivityIndicator.outerStrokeColor = outerStroke ?? UIColor.init(named: "GradientEnd")!
    SRActivityIndicator.centerImageSize = imageSize
    SRActivityIndicator.centerImage = UIImage(named: imageName)!
    SRActivityIndicator.setMaskingWith(maskType:backgroundType,alpha: 0.5)
    SRActivityIndicator.show()
}
//Loader Hide
public func hideLoader() {
    SRActivityIndicator.dissmiss()
}

public let SRActivityIndicator = SR_ActivityIndicator()

public class SR_ActivityIndicator: UIView {
    
    let contentView = UIView()
    public var outerFillColor : UIColor = UIColor.clear
    public var outerStrokeColor : UIColor = UIColor.clear
    public var outerLineWidth : CGFloat = 5.0
    public var outerEndStroke : CGFloat = 1.0
    public var outerAnimationDuration : CGFloat = 2.0
    public var enableInnerLayer : Bool = true
    public var innerFillColor : UIColor  = UIColor.clear
    public var innerStrokeColor : UIColor = UIColor(red: 208/255, green: 154/255, blue: 35/255, alpha: 1)
    public var centerImageSize: CGFloat = 50
    public var centerImage: UIImage? = UIImage(named: "image")
    public var innerLineWidth : CGFloat = 5.0
    public var innerEndStroke : CGFloat = 0.3
    public var innerAnimationDuration : CGFloat = 1.0
    public var currentInnerRotation : CGFloat = 0
    public var currentOuterRotation : CGFloat = 0
    public var masking:maskType = .Dim
    public var innerView : UIView = UIView()
    public var outerView : UIView = UIView()
    public var centerView : UIImageView = UIImageView()
    public var disableUserInteraction = true
    let vibrancyEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))

    //MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }
    
    public func setMaskingWith(maskType:maskType? = .Dim, alpha:CGFloat? = 1){
        switch maskType {
        case .Dim:
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: alpha!)
        case .Blur:
            vibrancyEffectView.frame = self.bounds
            vibrancyEffectView.alpha = alpha!
            vibrancyEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.insertSubview(vibrancyEffectView, belowSubview: self.contentView)
        case .none:
            break
        }
    }
    
    
    private func commonInit(){
         self.frame = UIScreen.main.bounds
                if !disableUserInteraction{
            self.isUserInteractionEnabled = false
        }
         contentView.frame = CGRect(x: 0, y: 0, width: 25+centerImageSize, height: 25+centerImageSize)
         self.addSubview(contentView)
         contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
         contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    //MARK:- draw
    override public func draw(_ rect: CGRect) {
        contentView.frame = CGRect(x: 0, y: 0, width: 25+centerImageSize, height: 25+centerImageSize)
        self.contentView.addSubview(outerView)
        outerView.frame = CGRect(x: 0 , y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        outerView.center = self.convert(self.center, from: self.contentView)
        let outerLayer = CAShapeLayer()
        outerLayer.path = UIBezierPath(ovalIn: outerView.bounds).cgPath
        outerLayer.lineWidth = outerLineWidth
        outerLayer.strokeStart = 0.0
        outerLayer.strokeEnd = outerEndStroke
        outerLayer.fillColor = outerFillColor.cgColor
        outerLayer.strokeColor = outerStrokeColor.cgColor
        outerView.layer.addSublayer(outerLayer)
        self.contentView.addSubview(centerView)
        centerView.frame = CGRect(x: 0, y: 0, width: centerImageSize, height: centerImageSize)
        centerView.layer.cornerRadius = centerView.frame.width / 2
        centerView.clipsToBounds = true
        centerView.center = self.convert(self.center, from: self.contentView)
        centerView.image = centerImage
        
        if enableInnerLayer{
            self.contentView.addSubview(innerView)
            innerView.frame = CGRect(x: 0 , y: 0, width: contentView.frame.size.width , height: contentView.frame.size.height)
            innerView.center =  self.convert(self.center, from: self.contentView)
            let innerLayer = CAShapeLayer()
            innerLayer.path = UIBezierPath(ovalIn: innerView.bounds).cgPath
            innerLayer.lineWidth = innerLineWidth
            innerLayer.strokeStart = 0
            innerLayer.strokeEnd = innerEndStroke
            //innerLayer.lineCap = CAShapeLayerLineCap.round
            innerLayer.fillColor = innerFillColor.cgColor
            innerLayer.strokeColor = innerStrokeColor.cgColor
            innerView.layer.addSublayer(innerLayer)
        }
       
    }
    
    //MARK:- Public
    public func animateInnerRing(){
        innerView.layer.removeAllAnimations()
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0 * CGFloat(Double.pi/180)
        rotationAnimation.toValue = 360 * CGFloat(Double.pi/180)
        rotationAnimation.duration = Double(innerAnimationDuration)
        rotationAnimation.repeatCount = HUGE
        self.innerView.layer.add(rotationAnimation, forKey: "rotateInner")
    }
    
    public  func startAnimating(){
        self.animateInnerRing()
    }
    
    public func show() {
        DispatchQueue.main.async {
                   
//            if #available(iOS 13.0, *) {
//                let sceneDelegate = UIApplication.shared.connectedScenes
//                    .first!.delegate as! SceneDelegate
//                sceneDelegate.window!.addSubview(self)
//
//            // iOS12 or earlier
//            } else {
                let appDelegate = UIApplication.shared.delegate
                appDelegate!.window!!.addSubview(self)
        //    }
                   
                   self.alpha = 0
            UIView.animate(withDuration: 0.3, animations: {
                       self.alpha = 1
                   }, completion: { (true) in
                       self.animateInnerRing()
                   })
            }
        }
    
    public func dissmiss(){
            UIView.animate(withDuration: 0.3,animations: {() -> Void in
            self.alpha = 0
       }, completion: { _ in
              self.innerView.layer.removeAllAnimations()
            self.removeFromSuperview()
        })
    }
    
}



