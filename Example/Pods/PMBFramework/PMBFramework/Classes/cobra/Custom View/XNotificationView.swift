//
//  EventView.swift
//  cobra-iOS
//
//  Created by Jimmi Oh on 5/12/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit
import Kingfisher

public class XNotificationView: UIView, View {
    
    static private let velocity: CGFloat = 0.5 // the speed of swipe
    private var duration: TimeInterval = 5 // the notification appear time duration
    
    private let topView = UIView()
    private let icon = UIImageView(image: UIImage(named: ""))
    private let appLabel = UILabel(text: DModel.applicationName)
    let dismissButton = UIButton(text: "dismiss", color: .lightGray)
    private let lineView = UIView()
    let bottomView = UIView()
    private let picImage = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let detailLabel = UILabel()
    let actionButton = UIButton()
    
    private let panGesture = UIPanGestureRecognizer()
    
    public var action: (()->Void)!
    
    public init() {
        super.init(frame: CGRect())
        
        isUserInteractionEnabled = true
        
        bottomView.addVisualEffect(style: .extraLight, animated: false)
        topView.setupSubviews([icon, appLabel, dismissButton])
        bottomView.setupSubviews([picImage, titleLabel, subtitleLabel, detailLabel, lineView, topView, actionButton])
        addSubview(bottomView)
        
        addGestureRecognizer(panGesture)
        
        setupConstraint()
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initialize(_ title: String, _ subTitle: String?, _ detail: String, _ image: String? = nil) {
        self.titleLabel.text = title
        self.detailLabel.text = detail
        
        if let image = image, let url = URL(string: image) {
            self.picImage.kf.setImage(with: ImageResource(downloadURL: url))
            picImage.snp.makeConstraints { (make) in
                make.top.equalTo(lineView.snp.bottom).offset(UI(Margin.s12))
                make.leading.equalTo(bottomView).offset(UI(Margin.s16))
                make.bottom.lessThanOrEqualTo(bottomView).offset(-Margin.s12)
                make.size.equalTo(Margin.m60 * UI(1, 2))
            }
            
            titleLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(picImage)
                make.leading.equalTo(picImage.snp.trailing).offset(Margin.s8)
            })
        } else {
            titleLabel.snp.makeConstraints({ (make) in
                make.leading.equalTo(bottomView).offset(UI(Margin.s16))
                make.top.equalTo(lineView.snp.bottom).offset(UI(Margin.s8))
            })
        }
        
        if let subTitle = subTitle {
            self.subtitleLabel.text = subTitle
            subtitleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(UI(Margin.s8))
                make.leading.trailing.equalTo(titleLabel)
            }
            
            detailLabel.snp.makeConstraints { (make) in
                make.top.equalTo(subtitleLabel.snp.bottom).offset(UI(Margin.s8))
            }
        } else {
            detailLabel.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(UI(Margin.s8))
            }
        }
        
    }
    
    @objc public func actionPressed(_ sender: UIButton) {
        action()
        dismiss()
    }
    
    @objc public func dismissPressed(_ sender: UIButton) {
        dismiss()
    }
    
    @objc func present(duration: TimeInterval) {
        guard let window = DSource.window else { return }
        guard let notif = DSource.Notification.shared else { return }
        self.duration = duration
        window.addSubview(notif)
        
        notif.snp.makeConstraints { (make) in
            make.top.equalTo(window).offset(-(notif.frame.size.height * 1.5))
            make.leading.equalTo(window).offset(Margin.s8 * UI(1, 2.5))
            make.trailing.equalTo(window).offset(-Margin.s8 * UI(1, 2.5))
        }
        setNeedsLayout()
        layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, animations: {
            notif.frame.origin.y = 0
        }, completion: { _ in
            notif.perform(#selector(notif.dismiss(_:)), with: nil, afterDelay: duration)
        })
        
        actionButton.addTarget(notif, action: #selector(notif.actionPressed(_:)), for: .touchUpInside)
        dismissButton.addTarget(notif, action: #selector(notif.dismissPressed(_:)), for: .touchUpInside)
    }
    
    @objc public func dismiss(_ completion: (()->Void)? = nil) {
        guard let notif = DSource.Notification.shared else { return }
        UIView.animate(withDuration: 0.3, animations: {
            notif.frame.origin.y = -(DSource.Notification.shared.frame.size.height * 1.5)
        }) { _ in
            NSObject.cancelPreviousPerformRequests(withTarget: notif)
            notif.removeFromSuperview()
            DSource.Notification.shared = nil
            if let completion = completion {
                completion()
            }
        }
    }
    
    @objc public func xNotifSwipped(_ sender: UIPanGestureRecognizer) {
        guard let panView = sender.view, let notif = DSource.Notification.shared else { return }
        let translation = sender.translation(in: self)
        let position = (panView.center.y + translation.y) + (panView.frame.height / 2)
        if sender.state == .began || sender.state == .changed {
            NSObject.cancelPreviousPerformRequests(withTarget: notif)
            panView.center.y = position * XNotificationView.velocity
        }
        
        guard sender.state == .ended else { return }
        guard position < (panView.frame.size.height - 40) else {
            guard position > (panView.frame.origin.y + panView.frame.size.height) else {
                // back to init position
                UIView.animate(withDuration: 0.3) {
                    panView.frame.origin.y = 0
                }
                notif.perform(#selector(notif.dismiss(_:)), with: nil, afterDelay: duration)
                return
            }
            // animate the panview to center
            UIView.animate(withDuration: 0.3, animations: {
                panView.frame.origin.y = (mainScreen.height / 2) - (panView.frame.size.height / 2)
            }, completion: { _ in
                // hide and make the size bigger 0.1
                // do action
                UIView.animate(withDuration: 0.3, animations: {
                    panView.transform = CGAffineTransform(scaleX: 1.1, y: 1.05)
                    panView.alpha = 0
                }, completion: { _ in
                    self.actionPressed(self.actionButton)
                })
            })
            return
        }
        // dismiss the notification
        dismiss()
    }
    
    public func setupView() {
        topView.backgroundColor = UIColor.silverGray.alpha(0.9)
        
        picImage.kf.indicatorType = .activity
        picImage.setLayer(cornerRadius: 8, borderWidth: 0.5, borderColor: .silverGray)
        
        bottomView.setLayer(cornerRadius: 16, borderWidth: 0.5, borderColor: .lightGray)
        
//        appLabel.font = UIFont.regular(.b1)
        
        titleLabel.numberOfLines = 0
//        titleLabel.font = UIFont.medium(.h3)
        
        subtitleLabel.numberOfLines = 0
//        subtitleLabel.font = UIFont.medium(.h3)
        
        detailLabel.numberOfLines = 2
//        detailLabel.font = UIFont.light(.b1)
        
        lineView.setAsLine(height: 0.5)
        
        panGesture.addTarget(self, action: #selector(xNotifSwipped(_:)))
    }
    
    public func setupConstraint() {
        
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.leading.trailing.bottom.equalTo(self)
        }
        
        topView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(bottomView)
        }
        
        icon.snp.makeConstraints { (make) in
            make.top.leading.equalTo(topView).offset(UI(Margin.s8))
            make.bottom.equalTo(topView).offset(-UI(Margin.s8))
            make.size.equalTo(Margin.i25 * UI(1, 1.5))
        }
        
        appLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(icon)
            make.leading.equalTo(icon.snp.trailing).offset(UI(Margin.s8))
        }
        
        dismissButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(icon)
            make.trailing.equalTo(topView).offset(-UI(Margin.s12))
        }
        
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalTo(bottomView)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(bottomView).offset(-UI(Margin.s16))
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.lessThanOrEqualTo(bottomView).offset(-Margin.s12)
        }
        
        actionButton.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom)
            make.leading.trailing.bottom.equalTo(bottomView)
        }
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}
