//
//  PickerViewController.swift
//  DPM
//
//  Created by DickyChengg on 5/3/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

public class PickerViewController: BaseViewController, ViewController {
    lazy var root = PickerView()
    fileprivate var widthRatio: [CGFloat] = []
    public var data: [[String]] = []
    public var selection: [Int] = []
    
    public var checking: (([Int])->(message: String, status: Bool))!
    fileprivate var callback: (([Int])->Void)!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view = root
        
        recursive(views: root.pickerView)
    }
    
    public func recursive(views: UIView) {
        for item in views.subviews {
            if item.subviews.count > 0 {
                recursive(views: item)
            }
            debug(key: "parent: \(item.superview ?? UIView())", "child: \(item)")
        }
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        root.contentView.frame.origin.y += self.root.contentView.frame.size.height
        UIView.animate(withDuration: 0.2) {
            self.root.contentView.frame.origin.y -= self.root.contentView.frame.size.height
            self.root.alpha = 1
        }
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.2) {
            self.root.contentView.frame.origin.y += self.root.contentView.frame.size.height
            self.root.alpha = 0
        }
    }
    
    public func setupController() {
        root.pickerView.delegate = self
        root.pickerView.dataSource = self
        root.pickerView.reloadAllComponents()
        
        for i in 0..<selection.count {
            root.pickerView.selectRow(selection[i], inComponent: i, animated: true)
        }
        
        root.dismissBtn.addTarget(self, action: #selector(dismissPressed(_:)), for: .touchUpInside)
        root.selectBtn.addTarget(self, action: #selector(selectPressed(_:)), for: .touchUpInside)
        root.cancelBtn.addTarget(self, action: #selector(dismissPressed(_:)), for: .touchUpInside)
    }
    
    public func initialize(data: [[String]], selection: [Int], ratio: [CGFloat] = [1.0], _ callback: @escaping (([Int])->Void)) {
        self.data = data
        self.selection = selection
        self.widthRatio = ratio.map { value in
            return value * root.pickerView.frame.size.width
        }
        self.callback = callback
        setupController()
    }
    
    public func present(withTitle title: String, from viewController: UIViewController? = nil) {
        root.title.text = title
        setAsPopupViewController()
        
        
        
        if let viewController = viewController {
            viewController.present(self, animated: true, completion: nil)
        } else {
            DSource.navbar?.present(self, animated: true, completion: nil)
        }
    }
    
    @objc public func selectPressed(_ sender: UIButton) {
        for i in 0..<root.pickerView.numberOfComponents {
            selection[i] = root.pickerView.selectedRow(inComponent: i)
        }
        if checking != nil {
            let response = checking(selection)
            guard response.status else {
                self.presentAlert(title: "Error", message: "Selection not found")
                return
            }
        }
        callback(selection)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc public func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return data.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data[component].count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[component][row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return widthRatio[component]
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.font = UIFont.light(.b1)
        label.textAlignment = .center
        label.text = data[component][row]
        return label
    }
    
    
    
}
