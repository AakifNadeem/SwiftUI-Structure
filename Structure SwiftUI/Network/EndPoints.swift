//
//  EndPoints.swift
//
//  Created by Aakif Nadeem
//

import Foundation

enum APIEndPoints: String {
    case main = "default"
    
    
    func path() -> String
    {
        return self.rawValue
    }
}
