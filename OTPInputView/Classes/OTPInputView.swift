//
//  OTPInputView.swift
//  Abhishek Rathi - iOS
//  work.abhirathi@gmail.com
//
//  Created by Abhishek.Rathi on 30/08/19.
//  Copyright © 2019 Abhishek.Rathi. All rights reserved.
//

import UIKit

protocol OTPViewDelegate {
    func didFinishedEnterOTP(otpNumber: String)
    func otpNotValid()
}

@IBDesignable class OTPInputView: UIView {
    
    @IBInspectable var maximumDigits: Int = 6
    @IBInspectable var backgroundColour: UIColor = .white
    @IBInspectable var shadowColour: UIColor = .darkGray
    @IBInspectable var textColor: UIColor = .black
    @IBInspectable var font: UIFont = UIFont.boldSystemFont(ofSize: 23)
    var otpViewDelegate: OTPViewDelegate?
    
    override func prepareForInterfaceBuilder() {
        setupTextFields()
    }
    
    override func awakeFromNib() {
        setupTextFields()
    }
    
    func setupTextFields() {
        backgroundColor = .clear
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor)
            ])
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        for tag in 1...maximumDigits {
            let textField = UITextField()
            textField.tag = tag //set Tag to textField
            stackView.addArrangedSubview(textField)  // Add to stackView
            setupTextFieldStyle(textField)  // set the style accordingly
        }
    }
    
    fileprivate func setupTextFieldStyle(_ textField: UITextField) {
        textField.delegate = self // set up textfield delegate
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.contentHorizontalAlignment = .center
        textField.layer.cornerRadius = 10
        textField.dropShadow(shadowOpacity: 0.6, shadowColor: .darkGray)
        textField.textColor = textColor
        textField.font = font
    }
}

extension OTPInputView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var nextTag = 0
        
        if string.checkBackspace()
        {
            textField.deleteBackward()
            nextTag = textField.tag - 1
        } else if string.count == 1
        {
            textField.text = string
            nextTag = textField.tag + 1
        } else if string.count == maximumDigits
        {
            var otpPasted = string
            for tag in 1...maximumDigits {
                guard let textfield = viewWithTag(tag) as? UITextField else { continue }
                textfield.text = String(otpPasted.removeFirst())
            }
            otpFetch()
        }
        
        if let nextTextfield = viewWithTag(nextTag) as? UITextField {
            nextTextfield.becomeFirstResponder()
        } else {
            if nextTag > maximumDigits {
                otpFetch()
            }
            endEditing(true)
        }
        return false
    }
    
    func otpFetch() {
        var otp = ""
        for tag in 1...maximumDigits {
            guard let textfield = viewWithTag(tag) as? UITextField else { continue }
            otp += textfield.text!
        }
        
        // Check if OTP is complete, i.e equals to maxDigits allowed
        if otp.count == maximumDigits {
            otpViewDelegate?.didFinishedEnterOTP(otpNumber: otp)
        } else {
            otpViewDelegate?.otpNotValid()
        }
    }
}


extension String {
    func checkBackspace() -> Bool {
        if let char = self.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                return true
            }
            return false
        }
        return false
    }
}

extension UIView {
    func dropShadow( shadowRadius: CGFloat = 2.0, offsetSize: CGSize = CGSize(width: 2, height: 5), shadowOpacity: Float = 0.5, shadowColor: UIColor = UIColor.lightGray ) {
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = offsetSize
        layer.shadowRadius = shadowRadius
    }
    
}
