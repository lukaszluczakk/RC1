//
//  CommandLineHelper.swift
//  FM
//
//  Created by Łukasz Łuczak on 05/09/2021.
//

import Foundation

enum CommandLineArgument: String {
    case uiTest = "ui-test"
}

struct CommandLineHelper {
    static func isTestRunning() -> Bool {
        CommandLine.arguments.contains(CommandLineArgument.uiTest.rawValue)
    }
}
