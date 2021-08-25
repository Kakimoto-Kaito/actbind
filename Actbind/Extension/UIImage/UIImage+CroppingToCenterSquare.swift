//
//  UIImage+CroppingToCenterSquare.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/24.
//

import UIKit

extension UIImage {
    func uiImageCroppingToCenterSquare() -> UIImage {
        let cgImage = self.cgImage!
        var newWidth = CGFloat(cgImage.width)
        var newHeight = CGFloat(cgImage.height)
        if newWidth > newHeight {
            newWidth = newHeight
        } else {
            newHeight = newWidth
        }
        let x = (CGFloat(cgImage.width) - newWidth) / 2
        let y = (CGFloat(cgImage.height) - newHeight) / 2
        let rect = CGRect(x: x, y: y, width: newWidth, height: newHeight)
        let croppedCGImage = cgImage.cropping(to: rect)!
        return UIImage(cgImage: croppedCGImage, scale: scale, orientation: imageOrientation)
    }
}
