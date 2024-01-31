//
//  Double+Ext.swift
//
//  Created by Aakif Nadeem on 26/01/2023.
//

import Foundation

extension Double {
    public var toString: String { return String(self) }
    public var toInt: Int { return Int(self) }
    public var toCGFloat: CGFloat { return CGFloat(self) }
    
    mutating func roundTo(places: Int) {
        let divisor = pow(10.0, Double(places))
        self = (self * divisor).rounded() / divisor
    }
    
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

extension Int {
    public var toString: String { return String(self) }
    
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}


extension Float {
    public var toString: String { return String(self) }
    public var toInt: Int { return Int(self) }
    public var toCGFloat: CGFloat { return CGFloat(self) }
    
    mutating func roundTo(places: Int) {
        let divisor = pow(10.0, Float(places))
        self = (self * divisor).rounded() / divisor
    }
    
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
