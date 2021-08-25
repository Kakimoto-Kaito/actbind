//
//  UserDefaults+Remove.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/24.
//

import Foundation

extension UserDefaults {
    func userDefaultsRemoveAll() {
        dictionaryRepresentation().forEach { removeObject(forKey: $0.key) }
    }
}
