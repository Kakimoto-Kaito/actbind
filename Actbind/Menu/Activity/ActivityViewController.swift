//
//  ActivityViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/10.
//

import UIKit

final class ActivityViewController: UIViewController, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var activityTitleLabel: UILabel!
    @IBOutlet weak var activityAvgLabel: UILabel!
    @IBOutlet weak var avgTimeLabel: UILabel!
    @IBOutlet weak var activityWeekLabel: UILabel!
    @IBOutlet weak var selectActivityTimeLabel: UILabel!
    @IBOutlet weak var selectActivityDayLabel: UILabel!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var avgLineView: UIView!
    @IBOutlet weak var avgLineViewBottom: NSLayoutConstraint!
    @IBOutlet weak var toDayChartButton: UIButton!
    @IBOutlet weak var toDayChartView: UIView!
    @IBOutlet weak var toDayChartViewHeight: NSLayoutConstraint!
    @IBOutlet weak var oneDayChartButton: UIButton!
    @IBOutlet weak var oneDayChartView: UIView!
    @IBOutlet weak var oneDayChartViewHeight: NSLayoutConstraint!
    @IBOutlet weak var twoDayChartButton: UIButton!
    @IBOutlet weak var twoDayChartView: UIView!
    @IBOutlet weak var twoDayChartViewHeight: NSLayoutConstraint!
    @IBOutlet weak var threeDayChartButton: UIButton!
    @IBOutlet weak var threeDayChartView: UIView!
    @IBOutlet weak var threeDayChartViewHeight: NSLayoutConstraint!
    @IBOutlet weak var fourDayChartButton: UIButton!
    @IBOutlet weak var fourDayChartView: UIView!
    @IBOutlet weak var fourDayChartViewHeight: NSLayoutConstraint!
    @IBOutlet weak var fiveDayChartButton: UIButton!
    @IBOutlet weak var fiveDayChartView: UIView!
    @IBOutlet weak var fiveDayChartViewHeight: NSLayoutConstraint!
    @IBOutlet weak var sixDayChartButton: UIButton!
    @IBOutlet weak var sixDayChartView: UIView!
    @IBOutlet weak var sixDayChartViewHeight: NSLayoutConstraint!
    @IBOutlet weak var toDayLabel: UILabel!
    @IBOutlet weak var oneDayLabel: UILabel!
    @IBOutlet weak var twoDayLabel: UILabel!
    @IBOutlet weak var threeDayLabel: UILabel!
    @IBOutlet weak var fourDayLabel: UILabel!
    @IBOutlet weak var fiveDayLabel: UILabel!
    @IBOutlet weak var sixDayLabel: UILabel!
    
    var toDayActivityTime = 0
    var oneDayActivityTime = 0
    var twoDayActivityTime = 0
    var threeDayActivityTime = 0
    var fourDayActivityTime = 0
    var fiveDayActivityTime = 0
    var sixDayActivityTime = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        navigationBarTitle.title = "akuthibithi".localized()
        
        // 日毎の値
        toDayActivityTime = 0
        oneDayActivityTime = 0
        twoDayActivityTime = 0
        threeDayActivityTime = 0
        fourDayActivityTime = 0
        fiveDayActivityTime = 0
        sixDayActivityTime = 0
        
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
        
            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                avgTimeLabel.textColor = UIColor(named: "Blue")
                avgLineView.backgroundColor = UIColor(named: "Blue")
                if toDayActivityTime >= 60 {
                    toDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Plus")
                } else if toDayActivityTime < 60, toDayActivityTime >= 30 {
                    toDayChartView.backgroundColor = UIColor(named: "BlueHalf")
                } else {
                    toDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Minus")
                }
                
                if oneDayActivityTime >= 60 {
                    oneDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Plus")
                } else if oneDayActivityTime < 60, oneDayActivityTime >= 30 {
                    oneDayChartView.backgroundColor = UIColor(named: "BlueHalf")
                } else {
                    oneDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Minus")
                }
                
                if twoDayActivityTime >= 60 {
                    twoDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Plus")
                } else if twoDayActivityTime < 60, twoDayActivityTime >= 30 {
                    twoDayChartView.backgroundColor = UIColor(named: "BlueHalf")
                } else {
                    twoDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Minus")
                }
                
                if threeDayActivityTime >= 60 {
                    threeDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Plus")
                } else if threeDayActivityTime < 60, threeDayActivityTime >= 30 {
                    threeDayChartView.backgroundColor = UIColor(named: "BlueHalf")
                } else {
                    threeDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Minus")
                }
                
                if fourDayActivityTime >= 60 {
                    fourDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Plus")
                } else if fourDayActivityTime < 60, fourDayActivityTime >= 30 {
                    fourDayChartView.backgroundColor = UIColor(named: "BlueHalf")
                } else {
                    fourDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Minus")
                }
                
                if fiveDayActivityTime >= 60 {
                    fiveDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Plus")
                } else if fiveDayActivityTime < 60, fiveDayActivityTime >= 30 {
                    fiveDayChartView.backgroundColor = UIColor(named: "BlueHalf")
                } else {
                    fiveDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Minus")
                }
                
                if sixDayActivityTime >= 60 {
                    sixDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Plus")
                } else if sixDayActivityTime < 60, sixDayActivityTime >= 30 {
                    sixDayChartView.backgroundColor = UIColor(named: "BlueHalf")
                } else {
                    sixDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Minus")
                }
                
            } else {
                backButton.tintColor = UIColor(named: myColor!)
                avgTimeLabel.textColor = UIColor(named: myColor!)
                avgLineView.backgroundColor = UIColor(named: myColor!)
                if toDayActivityTime >= 60 {
                    toDayChartView.backgroundColor = UIColor(named: myColor! + "Half" + "Plus")
                } else if toDayActivityTime < 60, toDayActivityTime >= 30 {
                    toDayChartView.backgroundColor = UIColor(named: myColor! + "Half")
                } else {
                    toDayChartView.backgroundColor = UIColor(named: myColor! + "Half" + "Minus")
                }
                
                if oneDayActivityTime >= 60 {
                    oneDayChartView.backgroundColor = UIColor(named: myColor! + "Half" + "Plus")
                } else if oneDayActivityTime < 60, oneDayActivityTime >= 30 {
                    oneDayChartView.backgroundColor = UIColor(named: myColor! + "Half")
                } else {
                    oneDayChartView.backgroundColor = UIColor(named: myColor! + "Half" + "Minus")
                }
                
                if twoDayActivityTime >= 60 {
                    twoDayChartView.backgroundColor = UIColor(named: myColor! + "Half" + "Plus")
                } else if twoDayActivityTime < 60, twoDayActivityTime >= 30 {
                    twoDayChartView.backgroundColor = UIColor(named: myColor! + "Half")
                } else {
                    twoDayChartView.backgroundColor = UIColor(named: myColor! + "Half" + "Minus")
                }
                
                if threeDayActivityTime >= 60 {
                    threeDayChartView.backgroundColor = UIColor(named: myColor! + "Half" + "Plus")
                } else if threeDayActivityTime < 60, threeDayActivityTime >= 30 {
                    threeDayChartView.backgroundColor = UIColor(named: myColor! + "Half")
                } else {
                    threeDayChartView.backgroundColor = UIColor(named: myColor! + "Half" + "Minus")
                }
                
                if fourDayActivityTime >= 60 {
                    fourDayChartView.backgroundColor = UIColor(named: myColor! + "Half" + "Plus")
                } else if fourDayActivityTime < 60, fourDayActivityTime >= 30 {
                    fourDayChartView.backgroundColor = UIColor(named: myColor! + "Half")
                } else {
                    fourDayChartView.backgroundColor = UIColor(named: myColor! + "Half" + "Minus")
                }
                
                if fiveDayActivityTime >= 60 {
                    fiveDayChartView.backgroundColor = UIColor(named: myColor! + "Half" + "Plus")
                } else if fiveDayActivityTime < 60, fiveDayActivityTime >= 30 {
                    fiveDayChartView.backgroundColor = UIColor(named: myColor! + "Half")
                } else {
                    fiveDayChartView.backgroundColor = UIColor(named: myColor! + "Half" + "Minus")
                }
                
                if sixDayActivityTime >= 60 {
                    sixDayChartView.backgroundColor = UIColor(named: myColor! + "Half" + "Plus")
                } else if sixDayActivityTime < 60, sixDayActivityTime >= 30 {
                    sixDayChartView.backgroundColor = UIColor(named: myColor! + "Half")
                } else {
                    sixDayChartView.backgroundColor = UIColor(named: myColor! + "Half" + "Minus")
                }
            }
        }
        
        activityTitleLabel.text = "riyoujikann".localized()
        activityAvgLabel.text = "itinitinoheikinn".localized()
        
        let weekActivityTime = [sixDayActivityTime, fiveDayActivityTime, fourDayActivityTime, threeDayActivityTime, twoDayActivityTime, oneDayActivityTime, toDayActivityTime]
        // 平均
        let avg = weekActivityTime.reduce(0) { $0 + $1 } / weekActivityTime.count
        // 1週間の平均を計算
        let hour = avg / 60
        if hour == 0 {
            let avgString = String(avg)
            avgTimeLabel.text = avgString + "funn".localized()
        } else {
            let hourString = String(hour)
            let minute = avg - (hour * 60)
            let minuteString = String(minute)
            avgTimeLabel.text = hourString + "jikann".localized() + " " + minuteString + "funn".localized()
        }
        
        // 1週間の平均のフォーマット
        let avgWeekFormatter = DateIntervalFormatter()
        avgWeekFormatter.dateTemplate = "yyyyMMMd"
        let date = Date()
        // １週間前の日付
        let date2 = date.dateChange(type: .day, value: -6)
        activityWeekLabel.text = avgWeekFormatter.string(from: date2, to: date)
        
        // 今日の利用時間を計算
        let toDayActivityTimeHour = toDayActivityTime / 60
        if toDayActivityTimeHour == 0 {
            let avgString = String(toDayActivityTime)
            selectActivityTimeLabel.text = avgString + "funn".localized()
        } else {
            let toDayActivityTimeHourString = String(toDayActivityTimeHour)
            let toDayActivityTimeMinute = toDayActivityTime - (toDayActivityTimeHour * 60)
            let toDayActivityTimeMinuteString = String(toDayActivityTimeMinute)
            selectActivityTimeLabel.text = toDayActivityTimeHourString + "jikann".localized() + " " + toDayActivityTimeMinuteString + "funn".localized()
        }
        
        selectActivityDayLabel.text = Date().dateToStringTemplate(format: "yyyyMMMMd")
        
        // 最大値
        var activityMax = weekActivityTime.max()
        
        if activityMax == 0 {
            activityMax = 1
            
            let avgLine = Double(avg) / Double(activityMax!) * 100
            let toDayChart = Double(toDayActivityTime) / Double(activityMax!) * 100
            let oneDayChart = Double(oneDayActivityTime) / Double(activityMax!) * 100
            let twoDayChart = Double(twoDayActivityTime) / Double(activityMax!) * 100
            let threeDayChart = Double(threeDayActivityTime) / Double(activityMax!) * 100
            let fourDayChart = Double(fourDayActivityTime) / Double(activityMax!) * 100
            let fiveDayChart = Double(fiveDayActivityTime) / Double(activityMax!) * 100
            let sixDayChart = Double(sixDayActivityTime) / Double(activityMax!) * 100
            
            let maxHeight = chartView.bounds.height
            
            avgLineViewBottom.constant = maxHeight * CGFloat(avgLine) / 100
            toDayChartViewHeight.constant = maxHeight * CGFloat(toDayChart) / 100
            oneDayChartViewHeight.constant = maxHeight * CGFloat(oneDayChart) / 100
            twoDayChartViewHeight.constant = maxHeight * CGFloat(twoDayChart) / 100
            threeDayChartViewHeight.constant = maxHeight * CGFloat(threeDayChart) / 100
            fourDayChartViewHeight.constant = maxHeight * CGFloat(fourDayChart) / 100
            fiveDayChartViewHeight.constant = maxHeight * CGFloat(fiveDayChart) / 100
            sixDayChartViewHeight.constant = maxHeight * CGFloat(sixDayChart) / 100
        } else {
            let avgLine = Double(avg) / Double(activityMax!) * 100
            let toDayChart = Double(toDayActivityTime) / Double(activityMax!) * 100
            let oneDayChart = Double(oneDayActivityTime) / Double(activityMax!) * 100
            let twoDayChart = Double(twoDayActivityTime) / Double(activityMax!) * 100
            let threeDayChart = Double(threeDayActivityTime) / Double(activityMax!) * 100
            let fourDayChart = Double(fourDayActivityTime) / Double(activityMax!) * 100
            let fiveDayChart = Double(fiveDayActivityTime) / Double(activityMax!) * 100
            let sixDayChart = Double(sixDayActivityTime) / Double(activityMax!) * 100
            
            let maxHeight = chartView.bounds.height
            
            avgLineViewBottom.constant = maxHeight * CGFloat(avgLine) / 100
            toDayChartViewHeight.constant = maxHeight * CGFloat(toDayChart) / 100
            oneDayChartViewHeight.constant = maxHeight * CGFloat(oneDayChart) / 100
            twoDayChartViewHeight.constant = maxHeight * CGFloat(twoDayChart) / 100
            threeDayChartViewHeight.constant = maxHeight * CGFloat(threeDayChart) / 100
            fourDayChartViewHeight.constant = maxHeight * CGFloat(fourDayChart) / 100
            fiveDayChartViewHeight.constant = maxHeight * CGFloat(fiveDayChart) / 100
            sixDayChartViewHeight.constant = maxHeight * CGFloat(sixDayChart) / 100
        }
        
        let oneDay = Date().dateChange(type: .day, value: -1)
        let twoDay = Date().dateChange(type: .day, value: -2)
        let threeDay = Date().dateChange(type: .day, value: -3)
        let fourDay = Date().dateChange(type: .day, value: -4)
        let fiveDay = Date().dateChange(type: .day, value: -5)
        let sixDay = Date().dateChange(type: .day, value: -6)
         
        let oneDayString = oneDay.dateToStringTemplate(format: "EEE")
        let twoDayString = twoDay.dateToStringTemplate(format: "EEE")
        let threeDayString = threeDay.dateToStringTemplate(format: "EEE")
        let fourDayString = fourDay.dateToStringTemplate(format: "EEE")
        let fiveDayString = fiveDay.dateToStringTemplate(format: "EEE")
        let sixDayString = sixDay.dateToStringTemplate(format: "EEE")
        
        toDayLabel.text = "kyou".localized()
        oneDayLabel.text = oneDayString
        twoDayLabel.text = twoDayString
        threeDayLabel.text = threeDayString
        fourDayLabel.text = fourDayString
        fiveDayLabel.text = fiveDayString
        sixDayLabel.text = sixDayString
        
        backButton.image = UIImage(named: "back")
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if toHomeView == "on" {
            let UINavigationController = tabBarController?.viewControllers?[0]
            tabBarController?.selectedViewController = UINavigationController
        }
    }
    
    @IBAction func toDayChartButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        // 今日の利用時間を計算
        let toDayActivityTimeHour = toDayActivityTime / 60
        if toDayActivityTimeHour == 0 {
            let avgString = String(toDayActivityTime)
            selectActivityTimeLabel.text = avgString + "funn".localized()
        } else {
            let toDayActivityTimeHourString = String(toDayActivityTimeHour)
            let toDayActivityTimeMinute = toDayActivityTime - (toDayActivityTimeHour * 60)
            let toDayActivityTimeMinuteString = String(toDayActivityTimeMinute)
            selectActivityTimeLabel.text = toDayActivityTimeHourString + "jikann".localized() + " " + toDayActivityTimeMinuteString + "funn".localized()
        }
        
        selectActivityDayLabel.text = Date().dateToStringTemplate(format: "yyyyMMMMd")
    }
    
    @IBAction func oneDayChartButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        // 1日前の利用時間を計算
        let oneDayActivityTimeHour = oneDayActivityTime / 60
        if oneDayActivityTimeHour == 0 {
            let avgString = String(oneDayActivityTime)
            selectActivityTimeLabel.text = avgString + "funn".localized()
        } else {
            let oneDayActivityTimeHourString = String(oneDayActivityTimeHour)
            let oneDayActivityTimeMinute = oneDayActivityTime - (oneDayActivityTimeHour * 60)
            let oneDayActivityTimeMinuteString = String(oneDayActivityTimeMinute)
            selectActivityTimeLabel.text = oneDayActivityTimeHourString + "jikann".localized() + " " + oneDayActivityTimeMinuteString + "funn".localized()
        }
        
        // 1日前のdateを取得
        let oneDay = Date().dateChange(type: .day, value: -1)
        selectActivityDayLabel.text = oneDay.dateToStringTemplate(format: "yyyyMMMMd")
    }
    
    @IBAction func twoDayChartButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        // 2日前の利用時間を計算
        let twoDayActivityTimeHour = twoDayActivityTime / 60
        if twoDayActivityTimeHour == 0 {
            let avgString = String(twoDayActivityTime)
            selectActivityTimeLabel.text = avgString + "funn".localized()
        } else {
            let twoDayActivityTimeHourString = String(twoDayActivityTimeHour)
            let twoDayActivityTimeMinute = twoDayActivityTime - (twoDayActivityTimeHour * 60)
            let twoDayActivityTimeMinuteString = String(twoDayActivityTimeMinute)
            selectActivityTimeLabel.text = twoDayActivityTimeHourString + "jikann".localized() + " " + twoDayActivityTimeMinuteString + "funn".localized()
        }
        
        // 2日前のdateを取得
        let twoDay = Date().dateChange(type: .day, value: -2)
        selectActivityDayLabel.text = twoDay.dateToStringTemplate(format: "yyyyMMMMd")
    }
    
    @IBAction func threeDayChartButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        // 3日前の利用時間を計算
        let threeDayActivityTimeHour = threeDayActivityTime / 60
        if threeDayActivityTimeHour == 0 {
            let avgString = String(threeDayActivityTime)
            selectActivityTimeLabel.text = avgString + "funn".localized()
        } else {
            let threeDayActivityTimeHourString = String(threeDayActivityTimeHour)
            let threeDayActivityTimeMinute = threeDayActivityTime - (threeDayActivityTimeHour * 60)
            let threeDayActivityTimeMinuteString = String(threeDayActivityTimeMinute)
            selectActivityTimeLabel.text = threeDayActivityTimeHourString + "jikann".localized() + " " + threeDayActivityTimeMinuteString + "funn".localized()
        }
        
        // 3日前のdateを取得
        let threeDay = Date().dateChange(type: .day, value: -3)
        selectActivityDayLabel.text = threeDay.dateToStringTemplate(format: "yyyyMMMMd")
    }
    
    @IBAction func fourDayChartButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        // 4日前の利用時間を計算
        let fourDayActivityTimeHour = fourDayActivityTime / 60
        if fourDayActivityTimeHour == 0 {
            let avgString = String(fourDayActivityTime)
            selectActivityTimeLabel.text = avgString + "funn".localized()
        } else {
            let fourDayActivityTimeHourString = String(fourDayActivityTimeHour)
            let fourDayActivityTimeMinute = fourDayActivityTime - (fourDayActivityTimeHour * 60)
            let fourDayActivityTimeMinuteString = String(fourDayActivityTimeMinute)
            selectActivityTimeLabel.text = fourDayActivityTimeHourString + "jikann".localized() + " " + fourDayActivityTimeMinuteString + "funn".localized()
        }
        
        // 4日前のdateを取得
        let fourDay = Date().dateChange(type: .day, value: -4)
        selectActivityDayLabel.text = fourDay.dateToStringTemplate(format: "yyyyMMMMd")
    }
    
    @IBAction func fiveDayChartButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        // 5日前の利用時間を計算
        let fiveDayActivityTimeHour = fiveDayActivityTime / 60
        if fiveDayActivityTimeHour == 0 {
            let avgString = String(fiveDayActivityTime)
            selectActivityTimeLabel.text = avgString + "funn".localized()
        } else {
            let fiveDayActivityTimeHourString = String(fiveDayActivityTimeHour)
            let fiveDayActivityTimeMinute = fiveDayActivityTime - (fiveDayActivityTimeHour * 60)
            let fiveDayActivityTimeMinuteString = String(fiveDayActivityTimeMinute)
            selectActivityTimeLabel.text = fiveDayActivityTimeHourString + "jikann".localized() + " " + fiveDayActivityTimeMinuteString + "funn".localized()
        }
        
        // 5日前のdateを取得
        let fiveDay = Date().dateChange(type: .day, value: -5)
        selectActivityDayLabel.text = fiveDay.dateToStringTemplate(format: "yyyyMMMMd")
    }
    
    @IBAction func sixDayChartButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        // 6日前の利用時間を計算
        let sixDayActivityTimeHour = sixDayActivityTime / 60
        if sixDayActivityTimeHour == 0 {
            let avgString = String(sixDayActivityTime)
            selectActivityTimeLabel.text = avgString + "funn".localized()
        } else {
            let sixDayActivityTimeHourString = String(sixDayActivityTimeHour)
            let sixDayActivityTimeMinute = sixDayActivityTime - (sixDayActivityTimeHour * 60)
            let sixDayActivityTimeMinuteString = String(sixDayActivityTimeMinute)
            selectActivityTimeLabel.text = sixDayActivityTimeHourString + "jikann".localized() + " " + sixDayActivityTimeMinuteString + "funn".localized()
        }
        
        // 6日前のdateを取得
        let sixDay = Date().dateChange(type: .day, value: -6)
        selectActivityDayLabel.text = sixDay.dateToStringTemplate(format: "yyyyMMMMd")
    }
    
    @IBAction func backBottonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
}
