//
//  URLExtension.swift
//  AppExtensionKit
//
//  Created by Cao Phuoc Thanh on 4/27/20.
//  Copyright © 2020 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

public extension URL {
    func isContained(in parentDirectoryURL: URL) -> Bool {
        // Ensure this URL is contained in the passed in URL
        let parentDirectoryURL = URL(fileURLWithPath: parentDirectoryURL.path, isDirectory: true).standardized
        return self.standardized.absoluteString.hasPrefix(parentDirectoryURL.absoluteString)
    }
}

public extension URL {
    var fileName: String? {
        let components = self.absoluteString.components(separatedBy: "/")
        if let last = components.last, last != "" {
            return (last as NSString).removingPercentEncoding
        } else if components.count > 2 {
            return (components[components.count - 2] as NSString).removingPercentEncoding
        } else {
            return (self.absoluteString.components(separatedBy: "/").last as NSString?)?.removingPercentEncoding
        }
    }
}

public extension URL {
    var isDirectory: Bool {
        var isDir: ObjCBool = ObjCBool(false)
        if FileManager.default.fileExists(atPath: self.path, isDirectory: &isDir) {
            return isDir.boolValue
        } else {
            return false
        }
    }
}

public extension URL {
    
    func readBuffer(offset: Int, lenght: Int, calback: (UnsafeMutablePointer<UInt8>, Int) -> Void) -> Int {
        guard let inputStream: InputStream = InputStream(url: self) else { return 0 }
        var sum: Int = 0
        inputStream.open()
        inputStream.schedule(in: RunLoop.current, forMode: RunLoop.Mode.default)
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: lenght)
        while inputStream.hasBytesAvailable {
            let read = inputStream.read(buffer, maxLength: lenght)
            sum += read
            calback(buffer, read)
        }
        buffer.deallocate()
        inputStream.close()
        return sum
    }
    
    func readBuffer(capacity: Int, calback: (UnsafeMutablePointer<UInt8>, Int) -> Void) -> Int {
        guard let inputStream: InputStream = InputStream(url: self) else { return 0 }
        var sum: Int = 0
        inputStream.open()
        inputStream.schedule(in: RunLoop.current, forMode: RunLoop.Mode.default)
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: capacity)
        while inputStream.hasBytesAvailable {
            let read = inputStream.read(buffer, maxLength: capacity)
            sum += read
            calback(buffer, read)
        }
        buffer.deallocate()
        inputStream.close()
        return sum
    }
    
    func bufferSize() -> UInt64 {
        guard let fileAttribute: [FileAttributeKey : Any] = try? FileManager.default.attributesOfItem(atPath: self.path) else { return 0}
        guard let fileNumberSize: NSNumber = fileAttribute[FileAttributeKey.size] as? NSNumber else { return 0 }
        return UInt64(truncating: fileNumberSize)
    }
    func writeBuffer(_ buffer: UnsafeMutablePointer<UInt8>, capacity: Int) {
        let outputStream = OutputStream(url: self, append: true)
        outputStream?.write(buffer, maxLength: capacity)
    }
    
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }
    
    var fileSize: UInt64 {
        return self.attributes?[.size] as? UInt64 ?? UInt64(0)
    }
    
    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }
    
    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
    
    var modificationDate: Date? {
        return attributes?[.modificationDate] as? Date
    }
    
    var directoryPath: String {
        guard self.isDirectory == false else {
            return self.path
        }
        return self.path.components(separatedBy: "/").dropLast().joined(separator: "/")
    }
    
}
