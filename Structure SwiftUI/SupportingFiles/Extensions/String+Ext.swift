//
//  String+Ext.swift
//  Structure SwiftUI
//
//  Created by Aakif Nadeem on 31/01/2024.
//

import Foundation
import UIKit

extension String {
    func width(fontSize: Int, type: UIFont.Weight = .regular) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(fontSize), weight: type)]
        let size = self.size(withAttributes: fontAttributes)
        return ceil(size.width)
    }
    
    public var toInt: Int { return Int(self) ?? 0 }
    
    func maxLength(length: Int) -> String {
        var str = self
        let nsString = str as NSString
        if nsString.length >= length {
            str = nsString.substring(with:
                                        NSRange(
                                            location: 0,
                                            length: nsString.length > length ? length : nsString.length))
        }
        return  str
    }
    
    func toUTCDate(format: String = AppConstants.DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = AppConstants.UTCFormat
        let date: Date? = dateFormatter.date(from: self)?.toLocalTime() ?? Date()
        
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date ?? Date())
    }
}
