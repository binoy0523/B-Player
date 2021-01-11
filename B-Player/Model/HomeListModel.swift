//
//  HomeListModel.swift
//  B-Player
//
//  Created by user on 10/01/21.
//

import Foundation

protocol HomeListModelProtocol {
 
    func fetchVideos(completion: @escaping (Result<[Video], Error>) -> Void)
    
    var videos:[Video]? {get set}
    
}

class HomeListModel:HomeListModelProtocol {
    var videos: [Video]?
    
    init() {
        
    }
    
    func fetchVideos(completion: @escaping (Result<[Video], Error>) -> Void) {
        if (VideoLocalDBManager.sharedManager.entityIsEmpty()) {
            self.getVideosfromServer(completion: completion)
        } else {
            self.getVideosfromLocal(completion: completion)
        }
    }
    
    
    private func getVideosfromServer(completion: @escaping (Result<[Video], Error>) -> Void) {
        guard let requestUrl = URL(string: "https://interview-e18de.firebaseio.com/media.json?print=pretty") else { return  }
        ApiManager.request(url: requestUrl) { [weak self] (videos:[VideoData]?, error) in
            if error == nil {
                guard let videosList = videos else {return}
                
                VideoLocalDBManager.sharedManager.save(videos: videosList) { (status) in
                    if status {
                        self?.getVideosfromLocal(completion: completion)
                    }
                }
                
            } else {
                completion(.failure(error!))
            }
            
        }
    }
    
    private func getVideosfromLocal(completion: @escaping (Result<[Video], Error>) -> Void) {
        VideoLocalDBManager.sharedManager.getFromLocal { (videos, error) in
            if let videosList = videos , error == nil {
                self.videos = videosList
              completion(.success(videosList))
            }
            else{
                completion(.failure(error!))
            }
        }
        
    }

    
    
}
