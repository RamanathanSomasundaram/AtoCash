//
//  DesignableTextField.swift
//  Ejaar
//
//  Created by user on 10/01/21.
//  Copyright © 2021 LKB-L-115. All rights reserved.
//

import Foundation
import UIKit
@available(*, unavailable, message: "Only use it at Storybord or Xib.", renamed: "UIImageView")
@IBDesignable final class DesignableUITextField: UITextField,UITextFieldDelegate {

    
    @IBInspectable var placeHolderColor: UIColor = .lightGray{
        didSet {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: placeHolderColor])
        }
    }
    
    @IBInspectable var placeHolderSize: UIFont?  {
        get{
            return self.placeHolderSize
        }
        set {
            self.attributedPlaceholder = NSMutableAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.font:UIFont(name: "", size: 0)!])
        }
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            leftUpdateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var leftColor: UIColor = UIColor.lightGray {
        didSet {
            leftUpdateView()
        }
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            rightUpdateView()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0
    
    @IBInspectable var rightColor: UIColor = UIColor.lightGray {
        didSet {
            rightUpdateView()
        }
    }
    
    func rightUpdateView() {
        if let image = leftImage {
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = rightColor
            rightView = imageView
        } else {
            rightViewMode = UITextField.ViewMode.never
            rightView = nil
        }
    }
    
    func leftUpdateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = leftColor
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
    }
    
    /// Applies underline to the text view with the specified width
        @IBInspectable public var underLineWidth: CGFloat = 0.0 {
            didSet {
                updateUnderLineFrame()
            }
        }

        /// Sets the underline color
        @IBInspectable public var underLineColor: UIColor = .groupTableViewBackground {
            didSet {
                updateUnderLineUI()
            }
        }
    // MARK: - init methods
        override public init(frame: CGRect) {
            super.init(frame: frame)
            delegate = self
            // 2
            autocorrectionType = .no
            applyStyles()
        }

        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            delegate = self
            // 2
            autocorrectionType = .no
            applyStyles()
        }

        // MARK: - Layout
        override public func layoutSubviews() {
            super.layoutSubviews()
            updateUnderLineFrame()
        }

        // MARK: - Styles
        private func applyStyles() {
            applyUnderLine()
        }

        // MARK: - Underline
        private var underLineLayer = CALayer()
        private func applyUnderLine() {
            // Apply underline only if the text view's has no borders
            if borderStyle == UITextField.BorderStyle.none {
                underLineLayer.removeFromSuperlayer()
                updateUnderLineFrame()
                updateUnderLineUI()
                layer.addSublayer(underLineLayer)
                layer.masksToBounds = true
            }
        }

        private func updateUnderLineFrame() {
            var rect = bounds
            rect.origin.y = bounds.height - underLineWidth
            rect.size.height = underLineWidth
            underLineLayer.frame = rect
        }

        private func updateUnderLineUI() {
            underLineLayer.backgroundColor = underLineColor.cgColor
        }
    
    //Copy,Paste enable/disable
    @IBInspectable var isPasteEnabled: Bool = true
      
      @IBInspectable var isSelectEnabled: Bool = true
      
      @IBInspectable var isSelectAllEnabled: Bool = true
      
      @IBInspectable var isCopyEnabled: Bool = true
      
      @IBInspectable var isCutEnabled: Bool = true
      
      @IBInspectable var isDeleteEnabled: Bool = true
      
      override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
          switch action {
          case #selector(UIResponderStandardEditActions.paste(_:)) where !isPasteEnabled,
               #selector(UIResponderStandardEditActions.select(_:)) where !isSelectEnabled,
               #selector(UIResponderStandardEditActions.selectAll(_:)) where !isSelectAllEnabled,
               #selector(UIResponderStandardEditActions.copy(_:)) where !isCopyEnabled,
               #selector(UIResponderStandardEditActions.cut(_:)) where !isCutEnabled,
               #selector(UIResponderStandardEditActions.delete(_:)) where !isDeleteEnabled:
              return false
          default:
              return super.canPerformAction(action, withSender: sender)
          }
      }
      
    
    //MAX Length
    private var maxLengths = [UITextField: Int]()
    //MARK:- Maximum length
    @IBInspectable var maxLength: Int {
            get {
                guard let length = maxLengths[self] else {
                    return 100
                }
                return length
            }
            set {
                maxLengths[self] = newValue
                addTarget(self, action: #selector(fixMax), for: .editingChanged)
            }
        }
        @objc func fixMax(textField: UITextField) {
            let text = textField.text
            textField.text = text?.safelyLimitedTo(length: maxLength)
        }
    
    // 1
      @IBInspectable var allowedChars: String = ""
      
      
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard string.count > 0 else {
          return true
        }
        
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // 1. Here's the first change...
        return allowedIntoTextField(text: prospectiveText)
      }
      
      // 2. ...and here's the second!
      func allowedIntoTextField(text: String) -> Bool {
        if (text.containsOnlyCharactersIn(matchCharacters: allowedChars)){
            return text.count <= maxLength
        }
        else{
            return false
        }
      }
    }

extension UITextField{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
    
    func togglePasswordVisibility() {
        isSecureTextEntry = !isSecureTextEntry
        if let existingText = text, isSecureTextEntry {
            /* When toggling to secure text, all text will be purged if the user
             continues typing unless we intervene. This is prevented by first
             deleting the existing text and then recovering the original text. */
            deleteBackward()
            if let textRange = textRange(from: beginningOfDocument, to: endOfDocument) {
                replace(textRange, withText: existingText)
            }
        }
        /* Reset the selected text range since the cursor can end up in the wrong
         position after a toggle because the text might vary in width */
        if let existingSelectedTextRange = selectedTextRange {
            selectedTextRange = nil
            selectedTextRange = existingSelectedTextRange
        }
    }
}

extension String
{
    
    // Returns true if the string contains only characters found in matchCharacters.
     func containsOnlyCharactersIn(matchCharacters: String) -> Bool {
       let disallowedCharacterSet = CharacterSet(charactersIn: matchCharacters).inverted
       return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
     }
        func safelyLimitedTo(length n: Int)->String {
            if (self.count <= n) {
                return self
            }
            return String( Array(self).prefix(upTo: n) )
        }
        
        func safelyLimitedFrom(length n: Int)->String {
            if (self.count <= n) {
                return self
            }
            return String( Array(self).prefix(upTo: n) )
        }
}
