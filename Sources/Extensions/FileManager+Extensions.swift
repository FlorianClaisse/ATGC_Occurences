//
//  File.swift
//  
//
//  Created by Florian Claisse on 18/06/2022.
//

import Foundation


 extension FileManager {
    
    func fastaFiles(forPath path: URL) -> [URL] {
        let directoryContent = try! self.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        let fastaFiles = directoryContent.filter { $0.pathExtension == "fasta" }
        
        return fastaFiles
    }
    
    @discardableResult
    func directoryExists(atPath path: String, create: Bool = false) -> Bool {
        return self.directoryExists(atPath: URL(fileURLWithPath: path), create: create)
    }
    
    @discardableResult
    func directoryExists(atPath path: URL, create: Bool = false) -> Bool {
        var isDir: ObjCBool = false
        let exists = self.fileExists(atPath: path.path, isDirectory: &isDir)
        
        if !exists {
            if create { try! self.createDirectory(at: path, withIntermediateDirectories: true) }
            return false
        }
        
        return isDir.boolValue
    }
    
    
}
