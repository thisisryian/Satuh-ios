//
//  WebViewController.swift
//  SGByte-Property
//
//  Created by Roni Aja on 8/15/17.
//  Copyright © 2017 Pundi Mas Berjaya. All rights reserved.
//////

import UIKit
import RappleProgressHUD

public class WebViewController: BaseViewController, ViewController {
    
    lazy var root = WebView()
    public var url: String = ""
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view = root
        
        setupController()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let myUrl = URL(string: url)
        root.loadRequest(URLRequest(url: myUrl!))
    }
    
    public func setupController() {
        root.delegate = self
        
    }
    
}

extension WebViewController: UIWebViewDelegate {
    
    public func webViewDidStartLoad(_ webView: UIWebView) {
        let attributes = RappleActivityIndicatorView.attribute(style: .circle, tintColor: UIColor.white, screenBG: UIColor.black, progressBG: UIColor.white, progressBarBG: UIColor.white , progreeBarFill: UIColor.white)
        RappleActivityIndicatorView.startAnimatingWithLabel("Loading some Information \n Please wait a while ..", attributes: attributes)
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView) {
        RappleActivityIndicatorView.stopAnimation(completionIndicator: .success, completionLabel: "Success", completionTimeout: 0.5)
    }
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        RappleActivityIndicatorView.stopAnimation(completionIndicator: .success, completionLabel: "Failed", completionTimeout: 1)
        
        if (error as NSError).code != NSURLErrorCancelled {
            RappleActivityIndicatorView.stopAnimation(completionIndicator: .success, completionLabel: "Failed", completionTimeout: 1)
            self.presentAlert(title: "Error", message: "Tidak dapat terhubung ke internet. Periksa koneksi internet anda", {
                debug(error)
            })
        }
    }
}
