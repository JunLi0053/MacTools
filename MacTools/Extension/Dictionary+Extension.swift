//
//  Dictionary+Extension.swift
//  MacTools
//
//  Created by Jun on 2020/3/28.
//  Copyright © 2020 Jun. All rights reserved.
//

import Foundation

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
  var showJsonString: String {
        do {
            var dic: [String: Any] = [String: Any]()
            for (key, value) in self {
                dic["\(key)"] = value
            }
            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)

            if let data = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) as String? {
                return data
            } else {
                return "{}"
            }
        } catch {
            return "{}"
        }
    }
}
