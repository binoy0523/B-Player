//
//  API_Manager.swift
//  B-Player
//
//  Created by user on 09/01/21.
//

import Foundation

class ApiManager {
    
    static func request<T:Codable>(url:URL, completion:@escaping(_ response:T?,_ error:Error?)->Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Process and evaluate response from generic method
            
            if let data = data ,error == nil {
                let decoded = try! JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(decoded,nil)
                }
                
            }
            else {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
            }
        })
        task.resume()
  
        
        
    }
    
    
}


