//
//  Constants.swift
//
//  Created by Aakif Nadeem on 25/10/2023.
//

import Foundation

struct AppConstants {
    static let baseURL = URL(string: ConfigurationManager.shared.infoForKey(.baseUrl) ?? "")!
    
    static let UTCFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    static let DateFormat = "MMMM dd, yyyy"
    static let DateTimeFormat = "dd MMM, yyyy hh:mm a"
    static let CompactDateFormat = "dd.MM.yyyy"
    static let timeFormat = "EEEE, hh:mm a"
}

struct AppUserDefaults {
    static let kUserLoggedIn = "UserLoggedIn"
    static let kAccessToken = "AccessToken"
}

extension Notification.Name {
    static let NotificationName = Notification.Name("")
}
