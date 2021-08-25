//
//  UIImage+Rotation.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/24.
//

import UIKit

extension UIImage {
    func uiImageRotation(value: CGFloat) -> UIImage {
        let rotationValue = -value * CGFloat.pi / 180
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: size.width / 2, y: size.height / 2)
        context.scaleBy(x: 1.0, y: -1.0)
        context.rotate(by: rotationValue)
        context.draw(cgImage!, in: CGRect(x: -(size.width / 2), y: -(size.height / 2), width: size.width, height: size.height))
        let rotationImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rotationImage!
    }
}
