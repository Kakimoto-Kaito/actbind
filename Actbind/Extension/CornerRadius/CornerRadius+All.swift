//
//  CornerRadius+All.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/30.
//

import UIKit

extension UIView {
    func cornerAll(value: CGFloat, fulcrum: String) {
        if value == 0 {
            if fulcrum == "width" {
                layer.cornerRadius = layer.bounds.width / 2
            } else {
                layer.cornerRadius = layer.bounds.height / 2
            }
        } else {
            layer.cornerRadius = value
        }
    }
}
