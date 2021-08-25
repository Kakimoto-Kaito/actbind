//
//  String+Localozed.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/29.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self, comment: self)
    }
}
