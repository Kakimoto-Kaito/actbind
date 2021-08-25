//
//  CamerarollViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/07/20.
//

import Photos
import UIKit

final class ProfileImageCamerarollViewController: UIViewController {
    var section = 0
    
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var selectProfileImage: UIImageView!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var goCameraButtonBackgroundView: UIView!
    
    var photos = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarTitle.title = "カメラロール".localized()
        
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                nextButton.tintColor = UIColor(named: "Blue")
                cancelButton.tintColor = UIColor(named: "BlackWhite")
            } else {
                nextButton.tintColor = UIColor(named: myColor!)
                cancelButton.tintColor = UIColor(named: myColor!)
            }
        }
        
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0)]
        nextButton.setTitleTextAttributes(attributes, for: UIControl.State.normal)
        nextButton.title = "tugihe".localized()
        nextButton.isEnabled = false
        
        cancelButton.image = UIImage(named: "cancel")
        
        goCameraButtonBackgroundView.cornerAll(value: 0, fulcrum: "")
        
        setup()
        getAllPhotosInfo()
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if toHomeView == "on" {
            let UINavigationController = tabBarController?.viewControllers?[0]
            tabBarController?.selectedViewController = UINavigationController
        }
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "ProfileImageEdit", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        let vc = (nextVC as? ProfileImageEditViewController)
        
        vc!.profileimage = selectProfileImage.image
        vc!.section = section
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        if section == 0 {
            dismiss(animated: true, completion: nil)
        } else if section == 1 {
            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        } else {
            presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func goCameraButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        dismiss(animated: true, completion: nil)
    }

    func setup() {
        // UICollectionViewCellのマージン等の設定
        let flowLayout: UICollectionViewFlowLayout! = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 2,
                                     height: UIScreen.main.bounds.width / 3 - 2)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 2

        collectionView.collectionViewLayout = flowLayout
    }
    
    func getAllPhotosInfo() {
        photos = []
        
        // ソート条件を指定
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        
        let assets: PHFetchResult = PHAsset.fetchAssets(with: .image, options: options)
        assets.enumerateObjects { asset, _, _ -> Void in
            self.photos.append(asset as PHAsset)
        }
        
        collectionView.reloadData()
    }
}

extension ProfileImageCamerarollViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let camerarollCell = collectionView.dequeueReusableCell(withReuseIdentifier: "camerarollCell", for: indexPath) as! ProfileImageCamerarollCollectionViewCell
        camerarollCell.setConfigure(assets: photos[indexPath.row])
        camerarollCell.indexNumber = indexPath.row
        camerarollCell.delegate = self
        
        return camerarollCell
    }
    
    func fastSetSelectProfileImage(_ resultImage: UIImage?) {
        selectProfileImage.image = resultImage
        nextButton.isEnabled = true
    }
    
    func setSelectProfileImage(_ resultImage: UIImage?) {
        selectProfileImage.image = resultImage
        nextButton.isEnabled = true
    }
}
