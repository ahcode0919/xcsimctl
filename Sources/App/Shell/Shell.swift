//
//  Shell.swift
//  
//
//  Created by Aaron Hinton on 4/11/21.
//

import Foundation

func shell(_ command: String) -> Data {
    let task = Process()
    let pipe = Pipe()
    
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/zsh"
    task.launch()
    
    return pipe.fileHandleForReading.readDataToEndOfFile()
}
