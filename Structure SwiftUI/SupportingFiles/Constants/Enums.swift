//
//  Enums.swift
//
//  Created by Aakif Nadeem on 31/01/2024.
//

import Foundation

//MARK: ENUMS
enum AppViews: String {
    case SignUp
    case Home
}

enum TabBarEnum: Int, Identifiable, CaseIterable, Comparable {
    static func < (lhs: TabBarEnum, rhs: TabBarEnum) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case Conversation, Home, Profile
    
    internal var id: Int { rawValue }
    
    var icon: String {
        switch self {
        case .Home:
            return "ic_tab_home"
        case .Conversation:
            return "ic_tab_conversation"
        case .Profile:
            return "ic_tab_profile"
        }
    }
    
    var selectedIcon: String {
        switch self {
        case .Home:
            return "ic_tab_home"
        case .Conversation:
            return "ic_tab_selected_conversation"
        case .Profile:
            return "ic_tab_selected_profile"
        }
    }
    
    var title: String {
        switch self {
        case .Home:
            return ""
        case .Conversation:
            return ""
        case .Profile:
            return ""
        }
    }
}
