//
//  String+Snake.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/29.
//

import Foundation

extension String {
    func toSnake() -> String {
        let pattern = "(?<=\\w)([A-Z])"
        guard let reg = try? NSRegularExpression(pattern: pattern, options: []) else { return self }
        
        let mutable = NSMutableString(string: self)
        let range = NSMakeRange(0, count)
        reg.replaceMatches(in: mutable, options: [], range: range, withTemplate: "_$1")
        return (mutable as String).lowercased()
    }
}
