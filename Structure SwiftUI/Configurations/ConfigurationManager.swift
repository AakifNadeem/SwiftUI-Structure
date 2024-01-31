//
//  ConfigrationManager.swift
//
//  Created by Aakif Nadeem on 18/01/2022.
//

import Foundation

class ConfigurationManager: NSObject
{
    static var shared = ConfigurationManager()
    
    func infoForKey(_ key: ConfigurationKey) -> String? {
        return (Bundle.main.infoDictionary?[key.rawValue] as? String)?.replacingOccurrences(of: "\\", with: "")
     }
}

enum ConfigurationKey: String {
    case baseUrl = "baseURL"
}
