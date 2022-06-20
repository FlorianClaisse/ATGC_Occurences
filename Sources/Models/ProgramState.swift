//
//  File.swift
//  
//
//  Created by Florian Claisse on 18/06/2022.
//

import Foundation


internal final class ProgramState {
    
    private let inputA: URL
    private let inputB: URL
    private let output: URL
    private let size: Int
    private let threads: Int
    
    internal init(withOptions options: ProgramOptions) {
        // Check user entry
        guard FileManager.default.directoryExists(atPath: options.inputA) else { fatalError("Directory not found at path \(options.inputA)") }
        guard FileManager.default.directoryExists(atPath: options.inputB) else { fatalError("Directory not found at path \(options.inputB)") }
        FileManager.default.directoryExists(atPath: options.output, create: true)
        
        // Init all
        self.inputA = URL(fileURLWithPath: options.inputA, isDirectory: true)
        self.inputB = URL(fileURLWithPath: options.inputB, isDirectory: true)
        self.output = URL(fileURLWithPath: options.output, isDirectory: true)
        self.size = options.size
        self.threads = options.threads
    }
    
    internal func start() {
        // Store all files urls
        var aFiles = FileManager.default.fastaFiles(forPath: self.inputA).map { FastaFile(atPath: $0) }
        let aFirst = aFiles.removeFirst()
        var bFiles = FileManager.default.fastaFiles(forPath: self.inputB).map { FastaFile(atPath: $0) }
        let result = FastaFile.findAll(from: aFirst, to: aFiles, fromSize: self.size)
    }
}
