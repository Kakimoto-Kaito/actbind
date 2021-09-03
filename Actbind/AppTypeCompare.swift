//
//  AppTypeCompare.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/08/25.
//

import Foundation

enum AppTypeCompareType {
    case release
    case beta
    case error
}

enum AppTypeCompare {
    static func toAppStoreVersion(completion: @escaping (AppTypeCompareType) -> Void) {
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
                    
                    switch storeVersion.compare(appVersion, options: .numeric) {
                    case .orderedAscending:
                        // appVersion > storeVersion
                        completion(.beta)
                    case .orderedSame, .orderedDescending:
                        // storeVersion >= appVersion
                        completion(.release)
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
