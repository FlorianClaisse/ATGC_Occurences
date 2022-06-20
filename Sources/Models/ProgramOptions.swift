//
//  File.swift
//  
//
//  Created by Florian Claisse on 18/06/2022.
//

import ArgumentParser


internal struct ProgramOptions: ParsableArguments {

    @Option(name: .customLong("inputA"), help: "Le chemin vers le dossier d'entrée A.")
    internal var inputA: String
    
    @Option(name: .customLong("inputB"), help: "Le chemin vers le dossier d'entrée B.")
    internal var inputB: String
    
    @Option(help: "Le chemin vers le dossier de sortie.")
    internal var output: String
    
    @Option(help: "La taille minimum des mots à traiter.")
    internal var size: Int = 1
    
    @Option(help: "Le nombre de threads à utiliser pour le programme.")
    internal var threads: Int = 1
}
