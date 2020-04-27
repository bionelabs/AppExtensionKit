//
//  StringAttributedExtension.swift
//  HomeIQ
//
//  Created by Cao Phuoc Thanh(caophuocthanh@gmail.com) on 8/14/18.
//  Copyright © 2018 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

public func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
    let result = NSMutableAttributedString()
    result.append(left)
    result.append(right)
    return result
}

public func + (left: String, right: NSAttributedString) -> NSAttributedString {
    let result = NSMutableAttributedString()
    result.append(NSAttributedString(string: left))
    result.append(right)
    return result
}

public func + (left: NSAttributedString, right: String) -> NSAttributedString {
    let result = NSMutableAttributedString()
    result.append(left)
    result.append(NSAttributedString(string: right))
    return result
}

public extension String {
    
    public var attributedString: NSAttributedString {
        return NSAttributedString(string: self)
    }
    
    public func color(_ color: UIColor) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    public func font(_ font: UIFont) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.font: font]
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    public func attibutes(_ elements: [AttibuteType]) -> NSAttributedString {
        var _attributes: [NSAttributedString.Key: Any] = [:]
        elements.forEach {
            switch $0 {
            case .underline:
                _attributes[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue
            case .link(let url):
                _attributes[NSAttributedString.Key.link] = url
            case .color(let color):
                _attributes[NSAttributedString.Key.foregroundColor] = color
            case .font(let font):
                _attributes[NSAttributedString.Key.font] = font
            }
        }
        return NSAttributedString(string: self, attributes: _attributes)
    }
}

public enum AttibuteType {
    case color(UIColor)
    case font(UIFont)
    case underline
    case link(URL)
}

public extension NSAttributedString {
    
    public static func with(_ elements: NSAttributedString...) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        guard elements.count > 0 else {
            return attributedString
        }
        if elements.count == 1 {
            attributedString.append(elements[0])
            return attributedString
        }
        for (idx, item) in elements.enumerated() {
            attributedString.append(item)
            if idx < elements.count - 1 {
                attributedString.append(" ".attributedString)
            }
        }
        return attributedString
    }
    
    public func withAttibutes(_ elements: [AttibuteType]) -> NSAttributedString {
        var _attributes: [NSAttributedString.Key: Any] = [:]
        elements.forEach {
            switch $0 {
            case .underline:
                _attributes[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue
            case .link(let url):
                _attributes[NSAttributedString.Key.link] = url
            case .color(let color):
                _attributes[NSAttributedString.Key.foregroundColor] = color
            case .font(let font):
                _attributes[NSAttributedString.Key.font] = font
            }
        }
        return NSAttributedString(string: self.string, attributes: _attributes)
    }
}

