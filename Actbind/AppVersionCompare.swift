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
        let api = KeyManager().getValue(key: "API") as? String
        
        let url = URL(string: api! + "appversion")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        // request.addValue("", forHTTPHeaderField: "authorization") //APIKey
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // ここのエラーはクライアントサイドのエラー(ホストに接続できないなど)
            if let error = error {
                DispatchQueue.main.async {
                    print("クライアントエラー: \(error.localizedDescription)")
                    completion(.error)
                }
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.error)
                return
            }
            
            if response.statusCode == 200 {
                let json = String(data: data, encoding: .utf8)!
                print(json)
                
                do {
                    let versionNumberArray = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
                    print(versionNumberArray)
                    
                    let versionNumber = versionNumberArray.map { versionNumber -> [String: Any] in
                        versionNumber as! [String: Any]
                    }
                    let storeVersion = versionNumber[0]["version_number"] as! String
                    let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
                    
                    switch storeVersion.compare(appVersion!, options: .numeric) {
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
