//
//  XKeyboard.swift
//  Cobra
//
//  Created by DickyChengg on 7/26/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

public class XKeyboard {
    
    private var view: UIView?
    private var scrollView: UIScrollView?
    public var textFields: [UITextField] = []
    public var textViews: [UITextView] = []
    
    private var viewFrame: CGRect {
        return view?.frame ?? CGRect()
    }
    
    private var activeField: UITextField? {
        let fields = textFields.filter({ (textField) -> Bool in
            return textField.isFirstResponder
        })
        guard fields.count != 0 else {
            return nil
        }
        return fields[0]
    }
    
    private var activeView: UITextView? {
        let views = textViews.filter { (view) -> Bool in
            return view.isFirstResponder
        }
        guard views.count != 0 else {
            return nil
        }
        return views[0]
    }
    
    public func initialize(view: UIView?, scrollView: UIScrollView?, textFields: [UITextField], textViews: [UITextView]) {
        self.view = view
        self.scrollView = scrollView
        self.textFields = textFields
        self.textViews = textViews
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView?.contentInset.bottom = keyboardSize.height
            scrollView?.scrollIndicatorInsets.bottom = keyboardSize.height
            
            view?.frame.size.height -= keyboardSize.height
            
            arrangeActiveField()
            arrangeActiveView()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        scrollView?.contentInset.bottom = 0
        scrollView?.scrollIndicatorInsets.bottom = 0
    }
    
    private func arrangeActiveField() {
        if let activeField = activeField, (!viewFrame.contains(activeField.frame.origin)) {
            scrollView?.scrollRectToVisible(activeField.frame, animated: false)
        }
    }
    
    private func arrangeActiveView() {
        if let activeView = activeView, (!viewFrame.contains(activeView.frame.origin)) {
            scrollView?.scrollRectToVisible(activeView.frame, animated: false)
        }
    }
    
}
