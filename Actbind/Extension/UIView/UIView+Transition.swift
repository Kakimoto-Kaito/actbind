//
//  UIView+Transition.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/06/12.
//

import UIKit

extension UIView {
    func errorViewTransition(value: CGFloat) {
        UIView.transition(
            // アニメーションさせるview
            with: self,
            // アニメーションの秒数
            duration: 0.2,
            // アニメーションの指定 等速
            options: [.curveLinear],
            // アニメーション中の処理
            animations: { self.transform = CGAffineTransform(translationX: 0, y: -value) },
            completion: { (_: Bool) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    UIView.transition(
                        // アニメーションさせるview
                        with: self,
                        // アニメーションの秒数
                        duration: 0.2,
                        // アニメーションの指定 等速
                        options: [.curveLinear],
                        // アニメーション中の処理
                        animations: { self.transform = CGAffineTransform(translationX: 0, y: value) },
                        completion: nil
                    )
                }
            }
        )
    }
}
