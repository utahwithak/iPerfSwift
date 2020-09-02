//
//  Role.swift
//  iPerfSwift
//
//  Created by Carl Wieland on 8/9/19.
//  Copyright © 2019 Datum Apps. All rights reserved.
//

import Foundation
import iperf

public enum Role {
    case client
    case server

    internal var codeVal: Int8 {
        switch self {
        case .client:
            return "c".utf8CString[0]
        case .server:
            return "s".utf8CString[0]
        }
    }
}
