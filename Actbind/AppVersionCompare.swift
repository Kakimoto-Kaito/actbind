//
//  AppVersionCompare.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/08/25.
//

import Foundation

enum AppVersionCompareType {
    case latest
    case old
    case error
}

enum AppVersionCompare {
    static func toAppStoreVersion(completion: @escaping (AppVersionCompareType) -> Void) {
        let url = URL(string: "https://itunes.apple.com/lookup?id=1579280491")!
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // ここのエラーはクライアントサイドのエラー(ホストに接続できないなど)
            if error != nil {
                completion(.error)
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                print("no data or no response")
                return
            }
            
            if response.statusCode == 200 {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                    guard let storeVersion = ((jsonData?["results"] as? [Any])?.first as? [String: Any])?["version"] as? String,
                          let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
                    else {
                        completion(.error)
                        return
                    }
                    print("$$$$$$$$$$$")
                    print(storeVersion)
                    print(appVersion)
                    print("$$$$$$$$$$$")
                    switch storeVersion.compare(appVersion, options: .numeric) {
                    case .orderedDescending:
                        // appVersion < storeVersion
                        completion(.old)
                    case .orderedSame, .orderedAscending:
                        // storeVersion <= appVersion
                        completion(.latest)
                    }
                } catch {
                    completion(.error)
                }
            } else {
                completion(.error)
                return
            }
        }
        task.resume()
    }
}
