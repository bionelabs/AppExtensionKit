//
//  StringDataExtension.swift
//  AppExtensionKit
//
//  Created by Cao Phuoc Thanh on 4/27/20.
//  Copyright © 2020 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

public func bitString(hex : UInt8) -> String {
    let string = String(hex, radix: 2)
    var padded = string
    for _ in 0..<(8 - string.count) {
        padded = "0" + padded
    }
    return padded
}

public func bit(hex : UInt8) -> [UInt] {
    let string = String(hex, radix: 2)
    var padded = string
    for _ in 0..<(8 - string.count) {
        padded = "0" + padded
    }
    return Array(padded).map { UInt(String($0))!}
}

public extension Data {
    
    /// Hexadecimal string representation of `Data` object.
    
    var hexadecimal: String {
        return map { String(format: "%02x", $0) }
            .joined()
    }
}

public extension Data {
    
    init<T>(from value: T) {
        self = Swift.withUnsafeBytes(of: value) { Data($0) }
    }
    
    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: type) }
    }
}

public extension String {
    var hexaToInt      : Int    { return Int(strtoul(self, nil, 16))      }
    var hexaToDouble   : Double { return Double(strtoul(self, nil, 16))   }
    var hexaToBinary   : String { return String(hexaToInt, radix: 2)      }
    var decimalToHexa  : String { return String(Int(self) ?? 0, radix: 16)}
    var decimalToBinary: String { return String(Int(self) ?? 0, radix: 2) }
    var binaryToInt    : Int    { return Int(strtoul(self, nil, 2))       }
    var binaryToDouble : Double { return Double(strtoul(self, nil, 2))   }
    var binaryToHexa   : String { return String(binaryToInt, radix: 16)  }
}

public extension Int {
    var binaryString: String { return String(self, radix: 2)  }
    var hexaString  : String { return String(self, radix: 16) }
    var doubleValue : Double { return Double(self) }
}

public extension Int {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Int>.size)
    }
}

public extension UInt {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt>.size)
    }
}

public extension UInt8 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt8>.size)
    }
    
    var bits:[UInt] {
        return bit(hex: self)
    }
}

public extension UInt16 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt16>.size)
    }
}

public extension UInt32 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt32>.size)
    }
    
    var byteArrayLittleEndian: [UInt8] {
        return [
            UInt8((self & 0xFF000000) >> 24),
            UInt8((self & 0x00FF0000) >> 16),
            UInt8((self & 0x0000FF00) >> 8),
            UInt8(self & 0x000000FF)
        ]
    }
}

public extension Data {
    
    var uint8: UInt8 { return self.withUnsafeBytes { $0.load(as: UInt8.self) } }
    
    var uInt16: UInt16 { return self.withUnsafeBytes { $0.load(as: UInt16.self) } }
    
    var uInt32: UInt32 { return  self.withUnsafeBytes { $0.load(as: UInt32.self) } }
    
    var uInt64: UInt64 { return  self.withUnsafeBytes { $0.load(as: UInt64.self) } }
}

public extension String {
    
    var hexadecimal: Data? {
        var data = Data(capacity: self.count / 2)
        
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSRange(startIndex..., in: self)) { match, _, _ in
            let byteString = (self as NSString).substring(with: match!.range)
            let num = UInt8(byteString, radix: 16)!
            data.append(num)
        }
        
        guard data.count > 0 else { return nil }
        
        return data
    }
    
    
    init?(hexadecimal string: String, encoding: String.Encoding = .utf8) {
        guard let data = string.hexadecimal else {
            return nil
        }
        
        self.init(data: data, encoding: encoding)
    }
    
    func hexadecimalString(encoding: String.Encoding = .utf8) -> String? {
        return data(using: encoding)?.hexadecimal
    }
    
}
