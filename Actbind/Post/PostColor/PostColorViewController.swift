//
//  PostColorViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/02.
//

import UIKit
import Vision

final class PostColorViewController: UIViewController, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    // 撮影画面で撮影した画像またはカメラロールから選ばれた画像
    var postimage: UIImage?
    var section = 0

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var selectColorLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var redSpaceView: UIView!
    @IBOutlet weak var redBorderView: UIView!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var orangeSpaceView: UIView!
    @IBOutlet weak var orangeBorderView: UIView!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var yellowSpaceView: UIView!
    @IBOutlet weak var yellowBorderView: UIView!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var greenSpaceView: UIView!
    @IBOutlet weak var greenBorderView: UIView!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var blueSpaceView: UIView!
    @IBOutlet weak var blueBorderView: UIView!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var purpleSpaceView: UIView!
    @IBOutlet weak var purpleBorderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        navigationBarTitle.title = "kara-taguwosenntaku".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                nextButton.tintColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: myColor!)
                nextButton.tintColor = UIColor(named: myColor!)
            }
        }
        
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0)]
        nextButton.setTitleTextAttributes(attributes, for: UIControl.State.normal)
        nextButton.title = "tugihe".localized()
        
        backButton.image = UIImage(named: "back")
        
        postImage.image = postimage
        postImage.cornerAll(value: 16, fulcrum: "")
        
        redButton.cornerAll(value: 0, fulcrum: "width")
        redSpaceView.cornerAll(value: 0, fulcrum: "width")
        redBorderView.cornerAll(value: 0, fulcrum: "width")
        
        orangeButton.cornerAll(value: 0, fulcrum: "width")
        orangeSpaceView.cornerAll(value: 0, fulcrum: "width")
        orangeBorderView.cornerAll(value: 0, fulcrum: "width")
        
        yellowButton.cornerAll(value: 0, fulcrum: "width")
        yellowSpaceView.cornerAll(value: 0, fulcrum: "width")
        yellowBorderView.cornerAll(value: 0, fulcrum: "width")
        
        greenButton.cornerAll(value: 0, fulcrum: "width")
        greenSpaceView.cornerAll(value: 0, fulcrum: "width")
        greenBorderView.cornerAll(value: 0, fulcrum: "width")
        
        blueButton.cornerAll(value: 0, fulcrum: "width")
        blueSpaceView.cornerAll(value: 0, fulcrum: "width")
        blueBorderView.cornerAll(value: 0, fulcrum: "width")
        
        purpleButton.cornerAll(value: 0, fulcrum: "width")
        purpleSpaceView.cornerAll(value: 0, fulcrum: "width")
        purpleBorderView.cornerAll(value: 0, fulcrum: "width")
        
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        
        colorML()
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
    
    func colorML() {
        let config = MLModelConfiguration()
        guard let model = try? VNCoreMLModel(for: PostColorClassifier(configuration: config).model) else {
            fatalError("Loading Core ML Model Failed.")
        }
        let request = VNCoreMLRequest(model: model) { request, _ in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            print(results)
            if let firstResult = results.first {
                if firstResult.identifier.contains("Red") {
                    self.redBorderView.backgroundColor = UIColor(named: "Border")
                    self.orangeBorderView.backgroundColor = UIColor.clear
                    self.yellowBorderView.backgroundColor = UIColor.clear
                    self.greenBorderView.backgroundColor = UIColor.clear
                    self.blueBorderView.backgroundColor = UIColor.clear
                    self.purpleBorderView.backgroundColor = UIColor.clear
                    self.selectColorLabel.text = "red".localized()
                } else if firstResult.identifier.contains("Orange") {
                    self.redBorderView.backgroundColor = UIColor.clear
                    self.orangeBorderView.backgroundColor = UIColor(named: "Border")
                    self.yellowBorderView.backgroundColor = UIColor.clear
                    self.greenBorderView.backgroundColor = UIColor.clear
                    self.blueBorderView.backgroundColor = UIColor.clear
                    self.purpleBorderView.backgroundColor = UIColor.clear
                    self.selectColorLabel.text = "orange".localized()
                } else if firstResult.identifier.contains("Yellow") {
                    self.redBorderView.backgroundColor = UIColor.clear
                    self.orangeBorderView.backgroundColor = UIColor.clear
                    self.yellowBorderView.backgroundColor = UIColor(named: "Border")
                    self.greenBorderView.backgroundColor = UIColor.clear
                    self.blueBorderView.backgroundColor = UIColor.clear
                    self.purpleBorderView.backgroundColor = UIColor.clear
                    self.selectColorLabel.text = "yellow".localized()
                } else if firstResult.identifier.contains("Green") {
                    self.redBorderView.backgroundColor = UIColor.clear
                    self.orangeBorderView.backgroundColor = UIColor.clear
                    self.yellowBorderView.backgroundColor = UIColor.clear
                    self.greenBorderView.backgroundColor = UIColor(named: "Border")
                    self.blueBorderView.backgroundColor = UIColor.clear
                    self.purpleBorderView.backgroundColor = UIColor.clear
                    self.selectColorLabel.text = "green".localized()
                } else if firstResult.identifier.contains("Blue") {
                    self.redBorderView.backgroundColor = UIColor.clear
                    self.orangeBorderView.backgroundColor = UIColor.clear
                    self.yellowBorderView.backgroundColor = UIColor.clear
                    self.greenBorderView.backgroundColor = UIColor.clear
                    self.blueBorderView.backgroundColor = UIColor(named: "Border")
                    self.purpleBorderView.backgroundColor = UIColor.clear
                    self.selectColorLabel.text = "blue".localized()
                } else if firstResult.identifier.contains("Purple") {
                    self.redBorderView.backgroundColor = UIColor.clear
                    self.orangeBorderView.backgroundColor = UIColor.clear
                    self.yellowBorderView.backgroundColor = UIColor.clear
                    self.greenBorderView.backgroundColor = UIColor.clear
                    self.blueBorderView.backgroundColor = UIColor.clear
                    self.purpleBorderView.backgroundColor = UIColor(named: "Border")
                    self.selectColorLabel.text = "purple".localized()
                } else {
                    self.selectColorLabel.text = ""
                }
            }
        }
        let ciImage = CIImage(image: postimage!)
        let handler = VNImageRequestHandler(ciImage: ciImage!)
        do {
            try! handler.perform([request])
        }
    }
    
    @IBAction func tapGesture(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "ImageSpotlight", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        let vc = (nextVC as? ImageSpotlightViewController)
        
        // 値の設定
        vc!.spotlightimage = postimage
        
        present(nextVC!, animated: true) {}
    }
    
    @IBAction func redButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        redBorderView.backgroundColor = UIColor(named: "Border")
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        selectColorLabel.text = "red".localized()
    }
    
    @IBAction func orangeButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor(named: "Border")
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        selectColorLabel.text = "orange".localized()
    }
    
    @IBAction func yellowButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor(named: "Border")
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        selectColorLabel.text = "yellow".localized()
    }
    
    @IBAction func greenButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor(named: "Border")
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        selectColorLabel.text = "green".localized()
    }
    
    @IBAction func blueButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor(named: "Border")
        purpleBorderView.backgroundColor = UIColor.clear
        selectColorLabel.text = "blue".localized()
    }
    
    @IBAction func purpleButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor(named: "Border")
        selectColorLabel.text = "purple".localized()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "Post", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        let vc = (nextVC as? PostViewController)
        
        // 値の設定
        if selectColorLabel.text == "red".localized() {
            vc!.postcolor = "Red"
        } else if selectColorLabel.text == "orange".localized() {
            vc!.postcolor = "Orange"
        } else if selectColorLabel.text == "yellow".localized() {
            vc!.postcolor = "Yellow"
        } else if selectColorLabel.text == "green".localized() {
            vc!.postcolor = "Green"
        } else if selectColorLabel.text == "blue".localized() {
            vc!.postcolor = "Blue"
        } else {
            vc!.postcolor = "Purple"
        }
        vc!.postimage = postimage
        vc!.section = section
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }

    @IBAction func backBottonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
}
