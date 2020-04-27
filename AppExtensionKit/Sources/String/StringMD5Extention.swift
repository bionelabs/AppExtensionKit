//
//  MD5Extention.swift
//  Blink
//
//  Created by Cao Phuoc Thanh on 9/19/18.
//  Copyright © 2018 Cao Phuoc Thanh. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var md5: String! {
        guard let messageData = self.data(using:String.Encoding.utf8) else {
            return nil
        }
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
}
