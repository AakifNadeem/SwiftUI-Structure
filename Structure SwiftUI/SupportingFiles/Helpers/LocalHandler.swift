//
//  LocalHandler.swift
//
//  Created by Aakif Nadeem on 31/01/2023.
//

import UIKit
import Foundation


class LocalHandler: NSObject, Codable {
    static var shared = LocalHandler()
    
    //MARK: Setters
    func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: AppUserDefaults.kUserLoggedIn)
    }
    
    func saveAccessToken(token: String) {
        UserDefaults.standard.set(true, forKey: AppUserDefaults.kUserLoggedIn)
        UserDefaults.standard.set(token, forKey: AppUserDefaults.kAccessToken)
    }
    
    //MARK: Getters
    func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: AppUserDefaults.kAccessToken)
    }
    
    func removeUserData() {
        UserDefaults.standard.set(nil, forKey: AppUserDefaults.kAccessToken)
    }
}
