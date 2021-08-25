//
//  UIImage+Inversion.swift.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/24.
//

import UIKit

extension UIImage {
    // 上下反転
    func uiImageInversionVertical() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: 0)
        context.scaleBy(x: 1.0, y: 1.0)
        context.draw(cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let inversionHorizontalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return inversionHorizontalImage!
    }

    // 左右反転
    func uiImageInversionHorizontal() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: size.width, y: size.height)
        context.scaleBy(x: -1.0, y: -1.0)
        context.draw(cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let inversionHorizontalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return inversionHorizontalImage!
    }
}
