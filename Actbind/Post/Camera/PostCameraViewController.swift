//
//  PostCameraViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/19.
//

import AVFoundation
import UIKit

final class PostCameraViewController: UIViewController {
    var section = 0
    
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var changeButton: UIButton!

    // デバイスからの入力と出力を管理するオブジェクトの作成
    var captureSession = AVCaptureSession()
    // カメラデバイスそのものを管理するオブジェクトの作成
    // バックカメラの管理オブジェクトの作成
    var backCamera: AVCaptureDevice?
    // フロントカメラの管理オブジェクトの作成
    var frontCamera: AVCaptureDevice?
    // 現在使用しているカメラデバイスの管理オブジェクトの作成
    var currentDevice: AVCaptureDevice?
    // キャプチャーの出力データを受け付けるオブジェクト
    var photoOutput: AVCapturePhotoOutput?
    // プレビュー表示用のレイヤ
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    // 撮影結果
    var resultImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarTitle.title = "syasinn".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                cancelButton.tintColor = UIColor(named: "BlackWhite")
            } else {
                cancelButton.tintColor = UIColor(named: myColor!)
            }
        }
        
        cancelButton.image = UIImage(named: "cancel")
        
        cameraButton.cornerAll(value: 0, fulcrum: "width")
        flashButton.cornerAll(value: 0, fulcrum: "width")
        changeButton.cornerAll(value: 0, fulcrum: "width")

        let cameraViewSystemButtonConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .default)

        changeButton.setImage(UIImage(systemName: "arrow.triangle.2.circlepath", withConfiguration: cameraViewSystemButtonConfig), for: .normal)
        
        if let userDefaults = userDefaults {
            let flashOnOff = userDefaults.integer(forKey: "flashonoff")

            if flashOnOff == 0 {
                flashButton.setImage(UIImage(systemName: "bolt.slash.fill", withConfiguration: cameraViewSystemButtonConfig), for: .normal)
            } else {
                flashButton.setImage(UIImage(systemName: "bolt.fill", withConfiguration: cameraViewSystemButtonConfig), for: .normal)
            }
        }

        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        captureSession.startRunning()
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if toHomeView == "on" {
            let UINavigationController = tabBarController?.viewControllers?[0]
            tabBarController?.selectedViewController = UINavigationController
        }
        
        reStartCamera()
    }
    
    // 画面から非表示になる直後に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        captureSession.stopRunning()
    }
    
    @IBAction func flashButtonTouchDown(_ sender: Any) {
        flashButton.layer.shadowColor = UIColor.label.cgColor
        flashButton.layer.shadowOpacity = 1
        flashButton.layer.shadowRadius = 8
        flashButton.layer.shadowOffset = .zero
    }
    
    @IBAction func flashButtonTouchDragOutside(_ sender: Any) {
        flashButton.layer.shadowColor = UIColor.clear.cgColor
        flashButton.layer.shadowOpacity = 0
        flashButton.layer.shadowRadius = 0
        flashButton.layer.shadowOffset = .zero
    }
    
    @IBAction func flashButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        flashButton.layer.shadowColor = UIColor.clear.cgColor
        flashButton.layer.shadowOpacity = 0
        flashButton.layer.shadowRadius = 0
        flashButton.layer.shadowOffset = .zero
        
        let cameraViewSystemButtonConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .default)
        if let userDefaults = userDefaults {
            let flashOnOff = userDefaults.integer(forKey: "flashonoff")

            if flashOnOff == 0 {
                userDefaults.setValue(1, forKeyPath: "flashonoff")
                flashButton.setImage(UIImage(systemName: "bolt.fill", withConfiguration: cameraViewSystemButtonConfig), for: .normal)
            } else {
                userDefaults.setValue(0, forKeyPath: "flashonoff")
                flashButton.setImage(UIImage(systemName: "bolt.slash.fill", withConfiguration: cameraViewSystemButtonConfig), for: .normal)
            }
        }
    }
    
    @IBAction func changeButtonTouchDown(_ sender: Any) {
        changeButton.layer.shadowColor = UIColor.label.cgColor
        changeButton.layer.shadowOpacity = 1
        changeButton.layer.shadowRadius = 8
        changeButton.layer.shadowOffset = .zero
    }
    
    @IBAction func changeButtonTouchDragOutside(_ sender: Any) {
        changeButton.layer.shadowColor = UIColor.clear.cgColor
        changeButton.layer.shadowOpacity = 0
        changeButton.layer.shadowRadius = 0
        changeButton.layer.shadowOffset = .zero
    }
    
    @IBAction func changeButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        changeButton.layer.shadowColor = UIColor.clear.cgColor
        changeButton.layer.shadowOpacity = 0
        changeButton.layer.shadowRadius = 0
        changeButton.layer.shadowOffset = .zero
        
        if let userDefaults = userDefaults {
            let cameraFrontBack = userDefaults.integer(forKey: "camerafrontback")

            if cameraFrontBack == 0 {
                userDefaults.setValue(1, forKeyPath: "camerafrontback")
            } else {
                userDefaults.setValue(0, forKeyPath: "camerafrontback")
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.reStartCamera()
        }
    }
    
    func reStartCamera() {
        captureSession.stopRunning()
        captureSession.inputs.forEach { input in
            captureSession.removeInput(input)
        }
        captureSession.outputs.forEach { output in
            captureSession.removeOutput(output)
        }

        let newVideoLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        newVideoLayer.frame = view.bounds
        newVideoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill

        view.layer.replaceSublayer(cameraPreviewLayer!, with: newVideoLayer)
        cameraPreviewLayer = newVideoLayer
        viewDidLoad()
    }

    @IBAction func cameraButtonTouchDown(_ sender: Any) {
        cameraButton.alpha = 0.5
    }

    @IBAction func cameraButtonTouchDragOutside(_ sender: Any) {
        cameraButton.alpha = 1.0
    }
    
    @IBAction func cameraButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        cameraButton.alpha = 1.0
        cameraButton.isEnabled = false
        flashButton.isEnabled = false
        changeButton.isEnabled = false
        cancelButton.isEnabled = false

        let settings = AVCapturePhotoSettings()
        // フラッシュの設定
        if let userDefaults = userDefaults {
            let flashOnOff = userDefaults.integer(forKey: "flashonoff")

            if flashOnOff == 0 {
                settings.flashMode = .off
            } else {
                settings.flashMode = .on
            }
        }
        
        // 赤目軽減をサポート
        settings.isAutoRedEyeReductionEnabled = true
        
        // 撮影された画像をdelegateメソッドで処理
        photoOutput?.capturePhoto(with: settings, delegate: self as AVCapturePhotoCaptureDelegate)
    }

    @IBAction func cancelButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        if section == 0 {
            dismiss(animated: true, completion: nil)
        } else {
            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
}

extension PostCameraViewController: AVCapturePhotoCaptureDelegate {
    // 撮影した画像データが生成されたときに呼び出されるデリゲートメソッド
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            // Data型をUIImageオブジェクトに変換
            let uiImage = UIImage(data: imageData)
            // 画像を正方形に
            var squareImage = uiImage!.uiImageCroppingToCenterSquare()
            // フロントカメラで撮影された場合左右反転する
            if let userDefaults = userDefaults {
                let cameraFrontBack = userDefaults.integer(forKey: "camerafrontback")

                if cameraFrontBack == 0 {
                    squareImage = squareImage.uiImageInversionHorizontal()
                    // 90度回転してしまうので-90度回転させる
                    squareImage = squareImage.uiImageRotation(value: -90)
                }
            }
            // 画像をリサイズ
            let resizeImage = squareImage.uiImageResize(size: CGSize(width: 1000, height: 1000))
            // 撮影結果を保持
            resultImage = resizeImage
            
            if let userDefaults = userDefaults {
                let savePhoto = userDefaults.string(forKey: "savephoto")
                
                if savePhoto == "On" {
                    // 写真ライブラリに画像を保存
                    UIImageWriteToSavedPhotosAlbum(resizeImage, nil, nil, nil)
                }
            }
            
            cameraButton.isEnabled = true
            flashButton.isEnabled = true
            changeButton.isEnabled = true
            cancelButton.isEnabled = true
            
            // 撮影結果画面へ遷移
            let storyBoard = UIStoryboard(name: "PostColor", bundle: nil)
            let nextVC = storyBoard.instantiateInitialViewController()
            let vc = (nextVC as? PostColorViewController)
            
            // 値の設定
            vc!.postimage = resultImage
            vc!.section = section
            
            navigationController?.pushViewController(nextVC!, animated: true)
        }
    }
}

// MARK: カメラ設定メソッド

extension PostCameraViewController {
    // カメラの画質の設定
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    // デバイスの設定
    func setupDevice() {
        // カメラデバイスのプロパティ設定
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        // プロパティの条件を満たしたカメラデバイスの取得
        let devices = deviceDiscoverySession.devices

        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        // 起動時のカメラを設定
        if let userDefaults = userDefaults {
            let cameraFrontBack = userDefaults.integer(forKey: "camerafrontback")

            if cameraFrontBack == 0 {
                currentDevice = frontCamera
            } else {
                currentDevice = backCamera
            }
        }
    }
    
    // 入出力データの設定
    func setupInputOutput() {
        do {
            // 指定したデバイスを使用するために入力を初期化
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice!)
            // 指定した入力をセッションに追加
            captureSession.addInput(captureDeviceInput)
            // 出力データを受け取るオブジェクトの作成
            photoOutput = AVCapturePhotoOutput()
            // 出力ファイルのフォーマットを指定
            photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
    }
    
    // カメラのプレビューを表示するレイヤの設定
    func setupPreviewLayer() {
        // 指定したAVCaptureSessionでプレビューレイヤを初期化
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        // プレビューレイヤが、カメラのキャプチャーを縦横比を維持した状態で、表示するように設定
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        // プレビューレイヤの表示の向きを設定
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        // 画面サイズ
        let myBoundSize: CGSize = UIScreen.main.bounds.size
        cameraPreviewLayer?.frame = CGRect(x: 0, y: 0, width: Int(myBoundSize.width), height: Int(myBoundSize.width))
        view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
}
