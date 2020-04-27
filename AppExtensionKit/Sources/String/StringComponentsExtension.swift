//
//  StringComponentsExtension.swift
//  AppExtensionKit
//
//  Created by Cao Phuoc Thanh on 4/27/20.
//  Copyright © 2020 Cao Phuoc Thanh. All rights reserved.
//

import UIKit


// Range
extension String {
    
    subscript(_ r: CountableClosedRange<Int>) -> String {
        let lower = self.index(self.startIndex, offsetBy: r.lowerBound)
        let upper = self.index(self.startIndex, offsetBy: r.upperBound + 1)
        return String(self[lower..<upper])
    }
    
    subscript(_ r: CountableRange<Int>) -> String {
        let lower = self.index(self.startIndex, offsetBy: r.lowerBound)
        let upper = self.index(self.startIndex, offsetBy: r.upperBound)
        return String(self[lower..<upper])
    }
    
    subscript(_ r: Int) -> String {
        let index = self.index(self.startIndex, offsetBy: r)
        return String(self[index])
    }
    
}


// components
extension String {
    
    func components(separatedBy: Int) -> [String] {
        var strings: [String] = []
        if self.count <= separatedBy {
            return [self]
        }
        let loop: Double = Double(self.count)/Double(separatedBy)
        if loop == 1 {
            return [self]
        } else {
            strings.append(self[0...(separatedBy - 1)])
            for i in 1..<Int(loop) {
                let start = i*separatedBy
                let end = (i + 1)*separatedBy - 1
                let string = self[start...end]
                strings.append(string)
            }
            if self.count > Int(loop) * separatedBy {
                let start = Int(loop) * separatedBy
                let end = self.count - 1
                let string = self[start...end]
                strings.append(string)
            }
        }
        return strings
    }
}
