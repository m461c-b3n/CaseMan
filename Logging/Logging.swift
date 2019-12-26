//
//  Logging.swift
//  RunForGoodPrototype
//
//  Created by Benjamin Ludwig on 17.12.19.
//  Copyright © 2019 nerdoc & codinger GmbH. All rights reserved.
//

import os.log

struct LogSubsystem {
    static let `default` = LogSubsystem(osLogSubsystem: OSLog.default)
    let osLogSubsystem: OSLog
}

enum LogType {
    case `default`, info, debug, error, fault
    
    fileprivate var osLogType: OSLogType {
        switch self {
        case .info: return .info
        case .debug: return .debug
        case .error: return .error
        case .fault: return .fault
        default: return .default
        }
    }
}

func log(_ message: StaticString, type: LogType, subsystem: LogSubsystem = .default, _ args: CVarArg...) {
    os_log(message, log: subsystem.osLogSubsystem, type: type.osLogType, args)
}

func logDefault(_ message: StaticString, subsystem: LogSubsystem = .default, _ args: CVarArg...) {
    os_log(message, log: subsystem.osLogSubsystem, type: .default, args)
}

func logInfo(_ message: StaticString, subsystem: LogSubsystem = .default, _ args: CVarArg...) {
    os_log(message, log: subsystem.osLogSubsystem, type: .info, args)
}

func logDebug(_ message: StaticString, subsystem: LogSubsystem = .default, _ args: CVarArg...) {
    os_log(message, log: subsystem.osLogSubsystem, type: .debug, args)
}

func logError(_ message: StaticString, subsystem: LogSubsystem = .default, _ args: CVarArg...) {
    os_log(message, log: subsystem.osLogSubsystem, type: .error, args)
}

func logFault(_ message: StaticString, subsystem: LogSubsystem = .default, _ args: CVarArg...) {
    os_log(message, log: subsystem.osLogSubsystem, type: .fault, args)
}
