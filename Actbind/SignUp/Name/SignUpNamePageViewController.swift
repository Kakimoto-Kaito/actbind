//
//  SignUPNamePageViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/02.
//

import UIKit

final class SignUpNamePageViewController: UIViewController {
    @IBOutlet weak var page1: UIView!
    @IBOutlet weak var page2: UIView!
    @IBOutlet weak var page3: UIView!
    @IBOutlet weak var page4: UIView!
    @IBOutlet weak var page5: UIView!
    @IBOutlet weak var page6: UIView!
    @IBOutlet weak var page7: UIView!
    @IBOutlet weak var page8: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        page1.cornerAll(value: 0, fulcrum: "width")
        page2.cornerAll(value: 0, fulcrum: "width")
        page3.cornerAll(value: 0, fulcrum: "width")
        page4.cornerAll(value: 0, fulcrum: "width")
        page5.cornerAll(value: 0, fulcrum: "width")
        page6.cornerAll(value: 0, fulcrum: "width")
        page7.cornerAll(value: 0, fulcrum: "width")
        page8.cornerAll(value: 0, fulcrum: "width")
    }
}
