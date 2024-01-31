//
//  NetworkConnectivity.swift
//
//  Created by Aakif Nadeem
//

import Foundation
import Network

class Connectivity: ObservableObject {
    private let monitor = NWPathMonitor()
    
    init() {
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    func isConnected() -> Bool {
        return monitor.currentPath.status == .satisfied
    }
    
    func isUsingWiFi() -> Bool {
        if let interfaceType = monitor.currentPath.availableInterfaces.first?.type {
            return interfaceType == .wifi
        }
        return false
    }
}
