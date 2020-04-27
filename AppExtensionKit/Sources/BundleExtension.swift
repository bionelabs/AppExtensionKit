//
//  BundleExtension.swift
//  Home
//
//  Created by Cao Phuoc Thanh on 11/5/18.
//  Copyright © 2018 Cao Phuoc Thanh. All rights reserved.
//

public extension Bundle {
    
    var appName: String {
        return infoDictionary?["CFBundleName"] as! String
    }
    
    var bundleId: String {
        return bundleIdentifier!
    }
    
    var versionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    var buildNumber: String {
        return infoDictionary?["CFBundleVersion"] as! String
    }
    
}
