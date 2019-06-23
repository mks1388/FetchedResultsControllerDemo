//
//  CALayer+Border.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addBorder(radius: CGFloat, color: CGColor = UIColor.white.cgColor, width: CGFloat = 2.0) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
        layer.borderColor = color
        layer.borderWidth = width
    }
}
