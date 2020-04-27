//
//  StringSizeExtension.swift
//  Home
//
//  Created by Cao Phuoc Thanh(caophuocthanh@gmail.com) on 11/22/18.
//  Copyright © 2018 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

extension String {
    
    func size(ofFont font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }
}
