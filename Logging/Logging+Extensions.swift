//
//  Logging+Extensions.swift
//  RunForGoodPrototype
//
//  Created by Benjamin Ludwig on 18.12.19.
//  Copyright © 2019 nerdoc & codinger GmbH. All rights reserved.
//

import Foundation
import os.log

extension LogSubsystem {
    private static var viewCycleSubsystem = Bundle.main.bundleIdentifier!
    static let viewCycle = LogSubsystem(osLogSubsystem: OSLog(subsystem: viewCycleSubsystem, category: "viewCycle"))
}

