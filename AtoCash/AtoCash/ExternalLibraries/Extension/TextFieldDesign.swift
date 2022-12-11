//
//  TextFieldDesign.swift
//  AtoCash
//
//  Created by user on 12/03/21.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField

@IBDesignable
open class InputTextFieldDesign : SkyFloatingLabelTextField{
    @IBInspectable var dropDownArrow: Bool = false
    func setup() {
        self.lineColor = UIColor.clear
        self.titleColor = UIColor.init(named: "NavBar") ?? UIColor.lightGray
        self.placeholderColor = UIColor.lightGray
        self.selectedTitleColor = UIColor.init(named: "NavBar") ?? UIColor.lightGray
        self.selectedLineColor = UIColor.clear
        self.errorColor = UIColor.red
        self.textColor = UIColor.black
        self.font = UIFont(name: "SFUIDisplay-Regular", size: 17.0)
        self.setupRightPaddingView()
    }
    
    public func setupRightPaddingView(){
        if self.dropDownArrow {
            let imageView = UIImageView(image: UIImage(named: "icons8-sort-down-100"))
            imageView.frame = CGRect(x: 0, y: 0, width: 20 , height: 20)
            let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: self.frame.size.height / 2, width: 20, height: 20))
            paddingView.addSubview(imageView)
            self.rightViewMode = .always
            self.rightView = paddingView
        }
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
//// Story board Extra Feature for create border radius, border width and border Color
extension UIView {
    /// corner radius
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}
/// To change UIImage mode to template
extension UIImage {
    static func localImage(_ name: String, template: Bool = false) -> UIImage {
        var image = UIImage(named: name)!
        if template {
            image = image.withRenderingMode(.alwaysTemplate)
        }
        return image
    }
    // To crop particular image
    func crop(by: CGRect) -> UIImage? {
        guard let returnImage = self.cgImage?.cropping(to: by) else {
            return nil
        }
        return UIImage(cgImage: returnImage)
    }
    
        func imageWithColor(color: UIColor) -> UIImage {
            UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
            color.setFill()

            let context = UIGraphicsGetCurrentContext()
            context?.translateBy(x: 0, y: self.size.height)
            context?.scaleBy(x: 1.0, y: -1.0)
            context?.setBlendMode(CGBlendMode.normal)

            let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
            context?.clip(to: rect, mask: self.cgImage!)
            context?.fill(rect)

            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return newImage!
        }
    
}

extension UITextField {
   public func setupRightPadview(){
        let imageView = UIImageView(image: UIImage(named: "arrowDown"))
        imageView.frame = CGRect(x: 0, y: 0, width: 20 , height: 20)
        let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: self.frame.size.height / 2, width: 20, height: 20))
        paddingView.addSubview(imageView)
        self.rightViewMode = .always
        self.rightView = paddingView
    }
    
    public func setupDateRightPadview(){
         let imageView = UIImageView(image: UIImage(named: "calendar"))
         imageView.frame = CGRect(x: 0, y: 0, width: 20 , height: 20)
         let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: self.frame.size.height / 2, width: 20, height: 20))
         paddingView.addSubview(imageView)
         self.rightViewMode = .always
         self.rightView = paddingView
     }
    
    
    
    public func setInputViewDatePicker(target: Any, selector: Selector) {
        
        let startHour: Int = 0
         let endHour: Int = 23
         let date1: Date = Date()
        let gregorian: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)

        var components: DateComponents = gregorian.dateComponents(([.day, .month, .year]), from: date1 as Date) as DateComponents
         components.hour = startHour
         components.minute = 0
         components.second = 0
         let startDate: Date = gregorian.date(from: components as DateComponents)! as Date

         components.hour = endHour
         components.minute = 59
         components.second = 59
         let endDate: Date = gregorian.date(from: components as DateComponents)! as Date

        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .time //2
        if #available(iOS 14, *) {
                datePicker.preferredDatePickerStyle = .inline
        }
        datePicker.minimumDate = startDate
        datePicker.maximumDate = endDate
        // For 24 Hrs
        datePicker.locale = Locale(identifier: "en_GB")
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    public func setInputViewPicker(_ mindate : Date?,target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 260))//1
        datePicker.datePickerMode = .date //2
        datePicker.minimumDate = mindate == nil ? nil : mindate!
        datePicker.maximumDate = Date()
        self.inputView = datePicker //3
        if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
        }
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    public func setInputViewPickerWithMin(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 260))//1
        datePicker.datePickerMode = .date //2
        datePicker.minimumDate = Date()
        datePicker.maximumDate = nil
        self.inputView = datePicker //3
        if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
        }
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
}
