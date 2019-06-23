//
//  ActivityIndicator.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import Foundation
import UIKit

struct ActivityIndicator {
    
    static let shared = ActivityIndicator()
    
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    
    private init() {
        activityIndicator.color = UIColor.gray
        activityIndicator.hidesWhenStopped = true
    }
    
    func show() {
        if let window = UIApplication.shared.keyWindow, !window.subviews.contains(activityIndicator) {
            activityIndicator.startAnimating()
            activityIndicator.center = window.center
            window.addSubview(activityIndicator)
        }
    }
    
    func hide() {
        if let window = UIApplication.shared.keyWindow, window.subviews.contains(activityIndicator) {
            activityIndicator.removeFromSuperview()
            activityIndicator.stopAnimating()
        }
    }
}
