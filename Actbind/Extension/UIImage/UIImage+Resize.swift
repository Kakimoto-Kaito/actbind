//
//  UIImage+Resize.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/24.
//

import UIKit

extension UIImage {
    func uiImageResize(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}
