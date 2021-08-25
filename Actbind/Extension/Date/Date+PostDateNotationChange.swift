//
//  Date+PostDateNotationChange.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/24.
//

import Foundation

let minute = 60
let hour = minute * 60
let day = hour * 24
let week = day * 7
let year = day * 365

extension Date {
    func postDateNotationChange() -> String {
        // 現在時刻を取得する
        let now = Date()

        // カレンダーを作成する
        let cal = Calendar.current

        let components = cal.dateComponents([.second, .minute, .hour, .day, .year], from: self, to: now)

        // 目的などに応じて適切に書き換える必要がある
        let diffSec = components.second! + components.minute! * minute + components.hour! * hour + components.day! * day + components.year! * year

        var result = String()

        if diffSec < minute {
            result = "suubyoumae".localized()
        } else if diffSec < hour {
            if (diffSec / minute) == 1 {
                result = String(format: "funnmae".localized(), "\(diffSec / minute)")
            } else {
                result = String(format: "fukusuufunnmae".localized(), "\(diffSec / minute)")
            }
        } else if diffSec < day {
            let postDateMonth = dateToStringTemplate(format: "dd")
            let nowDateMonth = Date().dateToStringTemplate(format: "dd")
            
            if postDateMonth == nowDateMonth {
                if (diffSec / hour) == 1 {
                    result = String(format: "jikannmae".localized(), "\(diffSec / hour)")
                } else {
                    result = String(format: "fukusuujikannmae".localized(), "\(diffSec / hour)")
                }
            } else {
                result = String(format: "nitimae".localized(), "1")
            }
        } else if diffSec < week {
            let postDateDay = dateToStringTemplate(format: "dd")
            let sevenDaysAgoDate = now.dateChange(type: .day, value: -7)
            let sevenDaysAgoDateDay = sevenDaysAgoDate.dateToStringTemplate(format: "dd")
           
            if postDateDay != sevenDaysAgoDateDay {
                if (diffSec / day) == 1 {
                    result = String(format: "nitimae".localized(), "\(diffSec / day)")
                } else {
                    result = String(format: "fukusuunitimae".localized(), "\(diffSec / day)")
                }
            } else {
                result = dateToStringTemplate(format: "MMMMd")
            }
        } else {
            let postDateYear = dateToStringTemplate(format: "yyyy")
            let nowDateYear = Date().dateToStringTemplate(format: "yyyy")
            
            if postDateYear == nowDateYear {
                result = dateToStringTemplate(format: "MMMMd")
            } else {
                result = dateToStringTemplate(format: "yyyyMMMMd")
            }
        }

        return result
    }
}
