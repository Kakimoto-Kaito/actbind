//
//  CamerarollCollectionViewCell.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/07/20.
//

import Photos
import UIKit

final class ProfileImageCamerarollCollectionViewCell: UICollectionViewCell {
    var delegate: ProfileImageCamerarollViewController?
    var indexNumber = 0
    
    @IBOutlet weak var camerarollImage: UIImageView!
    
    var resultImage: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // 画像を表示する
    func setConfigure(assets: PHAsset) {
        let manager = PHImageManager()
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        
        manager.requestImage(for: assets, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options, resultHandler: { [weak self] image, _ in
            guard let wself = self, let _ = image else {
                return
            }
            // 画像を正方形に
            let squareImage = image!.uiImageCroppingToCenterSquare()
            // 画像をリサイズ
            let resizeImage = squareImage.uiImageResize(size: CGSize(width: 500, height: 500))
            
            self!.resultImage = resizeImage
            
            wself.camerarollImage.image = self!.resultImage
            
            if self!.indexNumber == 0 {
                self!.delegate?.fastSetSelectProfileImage(self!.resultImage!)
            }
        })
    }
    
    @IBAction func selectProfileImageButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        delegate?.setSelectProfileImage(resultImage!)
    }
}
