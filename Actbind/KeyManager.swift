//
//  KeyManager.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/07/11.
//

import Foundation

struct KeyManager {
    private let keyFilePath = Bundle.main.path(forResource: "Keys", ofType: "plist")

    func getKeys() -> NSDictionary? {
        guard let keyFilePath = keyFilePath else {
            return nil
        }
        return NSDictionary(contentsOfFile: keyFilePath)
    }

    func getValue(key: String) -> AnyObject? {
        guard let keys = getKeys() else {
            return nil
        }
        return keys[key] as AnyObject
    }
}
