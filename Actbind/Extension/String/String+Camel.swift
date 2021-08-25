//
//  String+Camel.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/29.
//

import Foundation

extension String {
    func toUpperCamel() -> String {
        capitalized.replacingOccurrences(of: "_", with: "")
    }
    
    func toCamel() -> String {
        if isEmpty { return "" }
        
        let range = NSMakeRange(0, 1)
        let ns = toUpperCamel() as NSString
        return ns.replacingCharacters(in: range, with: ns.substring(with: range).lowercased())
    }
}
