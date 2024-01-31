//
//  NetworkModel.swift
//
//  Created by Aakif Nadeem on 31/01/2023.
//

import CommonCrypto
import Foundation
import UIKit

struct APIResponse<T: Codable> : Codable {
    var data : T?
    
    var statusCode : Int?
    var token: String?
}


struct APIErrorResponse: Codable {
    let error: ErrorModel?
}

struct ErrorModel : Codable {
    let code : String?
    let message : String?
}


//MARK: Media
class Media {
    let key: String
    let fileName: String
    let data: Data
    let mimeType: String
    
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpg"
        self.fileName = "\(arc4random()).jpeg"
        
        guard let data = image.jpegData(compressionQuality: 0.6) else { return nil }
        self.data = data
    }
    
    init(withURL url: URL, forKey key: String) {
        self.key = key
        self.mimeType = "video/mp4"
        self.fileName = "\(arc4random()).mp4"
        
        var data = Data()
        do {
            data = try Data(contentsOf: url)
        } catch {
            print("Unable to load data: \(error)")
        }
        
        self.data = data
    }
    
    init?(withPath path: String, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpg"
        
        if let cityName = path.components(separatedBy: "/").lazy.last?.split(separator: ".").lazy.first {
            self.fileName = "\(cityName).jpeg"
        } else {
            self.fileName = "\(arc4random()).jpeg"
        }
        
        guard let imageData = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return nil }
        self.data = imageData
    }
}
