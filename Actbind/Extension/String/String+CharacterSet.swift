//
//  String+CharacterSet.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/24.
//

import Foundation

extension String {
    /// StringからCharacterSetを取り除く
    func stringCharacterSetRemove(characterSet: CharacterSet) -> String {
        components(separatedBy: characterSet).joined()
    }

    /// StringからCharacterSetを抽出する
    func stringCharacterSetExtract(characterSet: CharacterSet) -> String {
        stringCharacterSetRemove(characterSet: characterSet.inverted)
    }
}
