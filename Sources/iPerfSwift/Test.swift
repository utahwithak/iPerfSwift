//
//  Test.swift
//  iPerfSwift
//
//  Created by Carl Wieland on 8/9/19.
//  Copyright © 2019 Datum Apps. All rights reserved.
//

import Foundation
import iperf


public class Test {
    let test: UnsafeMutablePointer<iperf_test>

    private var runTest = false

    public init?() {
        guard let newTest = iperf_new_test() else {
            return nil
        }
        iperf_defaults(newTest)
        test = newTest
        role = .client
    }

    deinit {
        iperf_free_test(test)
    }

    public var port: Int32 {
        get {
            return iperf_get_test_server_port(test)
        }
        set {
            iperf_set_test_server_port(test, newValue)
        }
    }

    public var serverHostname: String {
        get {
            String(cString: iperf_get_test_server_hostname(test))
        }
        set {
            newValue.withCString{
                let converted = UnsafeMutablePointer(mutating: $0)
                iperf_set_test_server_hostname(test, converted)
            }
        }
    }

    public var verbose: Bool {
        get {
            return iperf_get_verbose(test) == 1
        }
        set {
            iperf_set_verbose(test, newValue ? 1 : 0)
        }
    }

    var duration: Int {
        get {
            return Int(iperf_get_test_duration(test))
        }
        set {
            iperf_set_test_duration(test, Int32(truncatingIfNeeded: newValue))
        }
    }

    var controlSocket: Int32 {
        get {
            return iperf_get_control_socket(test)
        }
        set {
            iperf_set_control_socket(test, newValue)
        }
    }

    public var role: Role {
        get {
            return iperf_get_test_role(test) == Role.client.codeVal ? .client : .server
        }
        set {
            iperf_set_test_role(test, newValue.codeVal)
        }
    }

    public var reverse: Bool {
        get {
            iperf_get_test_reverse(test) == 1
        }
        set {
            iperf_set_test_reverse(test, newValue ? 1 : 0)
        }
    }

    public var reporterInterval: Double {
        get {
            iperf_get_test_reporter_interval(test)
        }
        set {
            iperf_set_test_reporter_interval(test, newValue)
        }
    }

    public var statsInterval: Double {
        get {
            iperf_get_test_stats_interval(test)
        }
        set {
            iperf_set_test_stats_interval(test, newValue)
        }
    }

    public var numberOfStreams: Int {
        get {
            Int(iperf_get_test_num_streams(test))
        }
        set {
            iperf_set_test_num_streams(test, Int32(truncatingIfNeeded: newValue))
        }
    }

    private func resetTest() {
        iperf_reset_test(self.test)
    }

    public func startTest() {
        runTest = true
        DispatchQueue.global(qos: .userInteractive).async {

            while (self.runTest) {
                let rc: Int32

                switch self.role {
                case .client:
                    rc =  iperf_run_client(self.test)
                    self.runTest = false

                case .server:
                    rc = iperf_run_server(self.test)
                    if rc == 0 {
                        self.resetTest()
                    } else{
                        self.runTest = false
                    }
                }

                print("Test finished:\(rc)")
            }

        }
    }

    public func stopTest() {
        runTest = false
    }

}
