//
//  Date+Change.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/26.
//

import Foundation

extension Date {
    func dateChange(type: Calendar.Component, value: Int) -> Date {
        Calendar.current.date(byAdding: type, value: value, to: self)!
    }
}
