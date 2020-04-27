//
//  StringTubleExtension.swift
//  AppExtensionKit
//
//  Created by Cao Phuoc Thanh on 4/27/20.
//  Copyright © 2020 Cao Phuoc Thanh. All rights reserved.
//

extension String {
    init?(fromTuple value: Any) {
        guard let string = Tuple(value).toString() else { return nil }
        self = string
    }
    
    init?(cString: UnsafeMutablePointer<Int8>?) {
        guard let cString = cString else { return nil }
        self = String(cString: cString)
    }
    
    init?(cString: UnsafeMutablePointer<CUnsignedChar>?) {
        guard let cString = cString else { return nil }
        self = String(cString: cString)
    }
    
    init? (cString: Any) {
        
        if let pointer = cString as? UnsafeMutablePointer<CChar> {
            self = String(cString: pointer)
            return
        }
        
        if let pointer = cString as? UnsafeMutablePointer<CUnsignedChar> {
            self = String(cString: pointer)
            return
        }
        
        if let string = String(fromTuple: cString) {
            self = string
            return
        }
        
        return nil
    }
}

// https://stackoverflow.com/a/58869882/4488252
struct Tuple<T> {
    let original: T
    private let array: [Mirror.Child]
    init(_ value: T) {
        self.original = value
        array = Array(Mirror(reflecting: original).children)
    }
    func compactMap<V>(_ transform: (Mirror.Child) -> V?) -> [V] { array.compactMap(transform) }
    
    func toString() -> String? {
        
        let chars = compactMap { (_, value) -> String? in
            var scalar: Unicode.Scalar!
            switch value {
            case is CUnsignedChar: scalar = .init(value as! CUnsignedChar)
            case is CChar: scalar = .init(UInt8(value as! CChar))
            default: break
            }
            guard let _scalar = scalar else { return nil }
            return String(_scalar)
        }
        if chars.isEmpty && !array.isEmpty { return nil }
        return chars.filter{$0 != "\0"}.joined()
    }
}
