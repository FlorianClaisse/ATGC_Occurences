//
//  FastaFile.swift
//  
//
//  Created by Florian Claisse on 18/06/2022.
//

import Foundation

internal struct FastaFile {
    internal let name: String
    internal let contigs: [Contig]
    
    internal init(atPath path: URL) {
        let content = try! String(contentsOf: path)
        
        var elements = content.components(separatedBy: ">")
        elements.removeFirst()
        
        self.name = path.lastPathComponent
        self.contigs = elements.map { Contig($0) }
    }
    
    internal static func findAll(from fileA: FastaFile, to fileB: [FastaFile], fromSize size: Int) -> [Substring] {
        var result = [Substring]()
        var test = [Substring]()
        var startIndex = 0
        var add = true
        
        for contig in fileA.contigs {
            for currentSize in size ... contig.chain.count {
                while (startIndex + currentSize) <= contig.chain.count {
                    let start = contig.chain.index(contig.chain.startIndex, offsetBy: startIndex)
                    let end = contig.chain.index(start, offsetBy: currentSize)
                    let word = contig.chain[start..<end]
                    test.append(word)
                    
                    for file in fileB {
                        if !file.contains(word) {
                            add = false
                            break
                        }
                    }
                    
                    if add { result.append(word) }
                    
                    startIndex += 1
                    add = true
                }
                
                startIndex = 0
                add = true
            }
            
            startIndex = 0
            add = true
        }
        
        diff(first: result, second: test)
        
        return result
    }
    
    internal func contains(_ element: Substring) -> Bool {
        for contig in contigs {
            if contig.chain.contains(element) { return true }
        }
        
        return false
    }
    
    private static func diff(first: [Substring], second: [Substring]) {
        let thisFirst = Set(first)
        let thisSecond = Set(second)
        print(Array(thisFirst.symmetricDifference(thisSecond)))
    }
}

extension FastaFile: CustomStringConvertible {
    internal var description: String {
        return "FastaFile(name: \(self.name), content: \(self.contigs))"
    }
}

