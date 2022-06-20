//
//  File 2.swift
//  
//
//  Created by Florian Claisse on 18/06/2022.
//


internal struct Contig {
    internal let name: String
    internal let chain: String
    
    internal init(_ content: String) {
        guard let firstIndex = content.firstIndex(of: "\n") else { fatalError("Can't decode file") }
        let name = content[..<firstIndex]
        
        var chain = content[firstIndex..<content.endIndex].uppercased()
        chain.removeAll { character in
            switch character {
            case "A", "T", "G", "C":  return false
            default: return true
            }
        }
        
        self.name = String(name)
        self.chain = chain
    }
    
    
}

extension Contig: CustomStringConvertible {
    internal var description: String {
        return "Contig(name: \(self.name), chain: \(self.chain))"
    }
}
