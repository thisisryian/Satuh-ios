//
//  XTextFieldView.swift
//  Cobra
//
//  Created by Mic Limz on 7/24/17.
//  Copyright © 2017 Pundi Mas Berjaya. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public class XTextField: UIView {
    
    private let titleLabel          = UILabel()
    private let titleLabelIcon      = UIImageView()
    
    private let textField           = UITextField()
    private let textFieldButton     = UIButton()
    
    private let errorLabel          = UILabel()
    
    private(set) var length              = 0
    private var imageVariant            = true
    private(set) var id: String
    var tagValue : Any? = nil

    
    public var advanceSetup: ((UITextField, UILabel, UILabel)->Void) = { _,_,_  in }
    
    public init(id: String = "") {
        self.id = id
        super.init(frame: CGRect())
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setupView(){
        advanceSetup(textField, titleLabel, errorLabel)
        titleLabel.font = UIFont.bold(.h4)
        textField.autocorrectionType    = .no
//        errorLabel.font                 = UIFont.light(.f1)
        errorLabel.numberOfLines        = 0
    }
    
    // Set view for normalSetupView
    private func normalSetupView(){
//        titleLabel.font = UIFont.regular(.b2)
        textField.normalTextField(.roundedRect)
    }
    
    // Set view for specialSetupView
    private func specialSetupView(){
        
    }
    
    public func initializeNormalTextField(title: String, placeholder: String, titleIcon: UIImage? = nil) {
        titleLabelIcon.image            = titleIcon
        titleLabel.text                 = title
        textField.placeholder           = placeholder
        titleLabel.numberOfLines        = 0
//        textField.font                  = UIFont.light(.b2)
        setupSubviews([titleLabel, titleLabelIcon, textField, textFieldButton, errorLabel])
        normalSetupConstraint()
        normalSetupView()
        setupView()
    }
    
    public func initializeSpecialTextField(titleIcon: UIImage? = nil ,placeholder: String){
        textField.placeholder               = placeholder
        titleLabelIcon.image                = titleIcon
        if titleIcon != nil {
            titleLabelIcon.frame            = CGRect(x: 0, y: 0, width: 40 * UI(1,1.25), height: 20 * UI(1,2))
        }
        titleLabelIcon.contentMode          = .scaleAspectFit
        textField.leftView                  = titleLabelIcon
        textField.leftViewMode              = .always
        textField.borderStyle               = .roundedRect
//        textField.font                      = UIFont.light(.b2)
        
        setupSubviews([textField, errorLabel, textFieldButton])
        textField.addSubview(titleLabelIcon)
        specialSetupConstraint()
        specialSetupView()
        setupView()
        
    }
    
    public func setSecureTextEntry(_ bool : Bool) {
        textField.isSecureTextEntry = bool
    }
    
    // Set type of textfield for normal textfield or password textfield
    public func setAsPasswordTextField(){
        textField.isSecureTextEntry = true
        textFieldButton.setImage(UIImage(named: "ic_eye_password"), for: .normal)
        textFieldButton.snp.makeConstraints({ (make) in
            make.size.equalTo(Margin.i20 * UI(1,1.5))
        })
        _ = textFieldButton.rx.tap.subscribe(onNext: { _ in
            if(self.imageVariant){
                self.textField.isSecureTextEntry = false
                self.textFieldButton.setImage(UIImage(named: "ic_eye_password_full"), for: .normal)
                self.imageVariant = false
            } else {
                self.textField.isSecureTextEntry = true
                self.textFieldButton.setImage(UIImage(named: "ic_eye_password"), for: .normal)
                self.imageVariant = true
            }

        })
    }
    
    public func setAsButtonTextField(_ dropdownIcon: UIImage? = nil) -> UIButton {
        let button = UIButton()
        let iconIV = UIImageView(image: dropdownIcon)
        setupSubviews([button, iconIV])
        button.snp.makeConstraints { (make) in
            make.edges.equalTo(textField)
        }
        if iconIV.image != nil {
            iconIV.snp.makeConstraints({ (make) in
                make.centerY.equalTo(button)
                make.trailing.equalTo(button).offset(-Margin.s8 * UI(1,2))
                make.size.equalTo(Margin.i20)
            })
        }
        return button
    }
    
    // Set keyboardtype for textfield
    public func keyboardType(_ keyboardType : UIKeyboardType) {
        textField.keyboardType = keyboardType
    }

    public func setLimitText(length: Int){
        self.length = length
        textField.delegate = self
    }     
    
    public func isEditable(_ bool : Bool) {
        if !bool {
            textField.isEnabled = false
            textField.isUserInteractionEnabled = false
        }
    }
    
    // Get text from a textfield
    public var text: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    public var placeholder : String {
        get {
            return textField.placeholder ?? ""
        }
        set {
            textField.placeholder = newValue
        }
    }
    
    // Set and show error when there's error
    public func setError(title: String, color: UIColor = UIColor.Main.red){
        errorLabel.text = title
        errorLabel.textColor = color
    }
    
    // Remove error when textfield content is right
    public func destroyErrorTitle(){
        errorLabel.text = ""
    }
    
    public func setFieldShouldNotBeEmpty() {
        textField.addTarget(self, action: #selector(checkTextLength), for: UIControlEvents.editingChanged)
    }
    
    public func unsetFieldShouldNotBeEmpty() {
        textField.removeTarget(self, action: #selector(checkTextLength), for: UIControlEvents.editingChanged)
    }
    
    public func becomeResponder() {
        textField.becomeFirstResponder()
    }
    
    @objc public func checkTextLength() {
        if(String.empty(textField.text)){
            setError(title: "This field is empty")
        } else {
            destroyErrorTitle()
        }

    }
    
    
    private func normalSetupConstraint() {
        titleLabelIcon.snp.makeConstraints { (make) in
            
            if titleLabelIcon.image != nil {
                make.top.equalTo(self)
                make.leading.equalTo(self)
                make.size.equalTo(Margin.i20 * UI(1,1.5))
            }
        }
        
        titleLabel.snp.makeConstraints { (make) in
            if titleLabelIcon.image != nil {
                make.leading.equalTo(titleLabelIcon.snp.trailing).offset(Margin.s8 / 2)
                make.trailing.equalTo(self)
                make.centerY.equalTo(titleLabelIcon)
            } else {
                make.top.equalTo(self)
                make.leading.equalTo(self)
                make.trailing.equalTo(self)
            }
            
        }
        
        textField.snp.makeConstraints { (make) in
            if titleLabelIcon.image != nil{
                make.top.equalTo(titleLabelIcon.snp.bottom).offset(Margin.s8 / 2)
            } else {
                make.top.equalTo(titleLabel.snp.bottom).offset(Margin.s8 / 2)
            }
            make.leading.trailing.equalTo(self)
            make.height.equalTo(Margin.s32 * UI(1,1.25))
            
        }
        
        textFieldButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(textField)
            make.trailing.equalTo(textField).offset(-Margin.s12 * UI(1,1.5))
            make.size.equalTo(0)
        }
        errorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(Margin.s8 / 2)
            make.leading.trailing.bottom.equalTo(self)
        }
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    private func specialSetupConstraint() {

        textField.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(Margin.s32 * UI(1,1.25))
        }
        
        textFieldButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(textField).offset(-Margin.s8 / 2)
            make.centerY.equalTo(textField)
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(Margin.s8 / 2)
            make.leading.equalTo(textField)
            make.trailing.equalTo(textField)
            make.bottom.equalTo(self)
        }
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
}
extension XTextField : UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        let numberOfChars = newText.characters.count
        return numberOfChars < self.length
    }
    
}
