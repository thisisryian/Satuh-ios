//
//  UIViewController+Extension.swift
//  cobra-iOS
//
//  Created by DickyChengg on 2/20/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func setBackTitle(_ title: String = "") {
        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
    }
    
    public func setAsPopupViewController() {
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .custom
    }
    
    public func dismissKeyboardOnTap(_ sender: UIView? = nil) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        (sender ?? view).addGestureRecognizer(tapGesture)
    }
    
    @objc public func hideKeyboard(_ sender: UITapGestureRecognizer? = nil) {
        view.endEditing(true)
    }
    
    public func presentAlert(title: String, message: String, alertAction items: [UIAlertAction] = [], _ completion: (()->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for item in items {
            alert.addAction(item)
        }
        if items.count == 0 {
            alert.addAction(
                UIAlertAction(title: "Close", style: .cancel, handler: nil)
            )
        }
        present(alert, animated: true, completion: completion)
    }
    
    public func presentActionSheet(title: String? = nil, message: String? = nil, alertAction items: [UIAlertAction] = [], _ completion: (()->Void)? = nil) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            presentAlert(title: title!, message: message!, alertAction: items, completion)
            return
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for item in items {
            alert.addAction(item)
        }
        if items.count == 0 {
            alert.addAction(
                UIAlertAction(title: "Close", style: .cancel, handler: nil)
            )
        }
        present(alert, animated: true, completion: completion)
    }
    
    public func presentShare(withSomeText text: String) {
        let shareController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        shareController.popoverPresentationController?.sourceView = view
        present(shareController, animated: true, completion: nil)
    }
}
