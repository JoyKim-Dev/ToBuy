//
//  String + Extension.swift
//  ToBuy
//
//  Created by Joy Kim on 6/18/24.
//

import UIKit

extension String {
    // 문자열에 숫자가 포함되어 있는지 확인하는 메서드
    func containsNumber() -> Bool {
        let regex = try! NSRegularExpression(pattern: "\\d")
        let range = NSRange(location: 0, length: self.utf16.count)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
    
    func containsAnyOfSpecificSymbols(_ symbols: [Character]) -> Bool {
            for s in symbols {
                if self.contains(s) {
                    return true
                }
            }
            return false
        }
}
