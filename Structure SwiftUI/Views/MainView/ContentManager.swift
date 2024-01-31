//
//  ContentManager.swift
//
//  Created by Aakif Nadeem on 31/01/2024.
//

import Foundation

class ContentManager: NSObject, ObservableObject {
    static var shared = ContentManager()
    
    func getBestResults(onCompletion: @escaping (Result<String?, Error>) -> Void) {
        let params = [
            "email": "coordinates"
        ] as [String : Any]
    
        Task(priority: .background) {
            let result = await NetworkService.shared.apiRequest(.main, requestType: .POST, params: params, responseModel: APIResponse<String>.self)
            
            switch result {
            case .success(let response):
                if let model = response.data {
                    onCompletion(.success(model))
                }
                
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}
