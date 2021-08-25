//
//  CornerRadius+Part.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/30.
//

import UIKit

extension UIView {
    func cornerPart(value: CGFloat, fulcrum: String, Location: CACornerMask) {
        cornerAll(value: value, fulcrum: fulcrum)
        layer.maskedCorners = Location
    }
}
