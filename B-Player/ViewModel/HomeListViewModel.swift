//
//  HomeList.swift
//  B-Player
//
//  Created by user on 10/01/21.
//

import Foundation
protocol HomeListViewModelProtocol {
    
    var model:HomeListModelProtocol? {get set}
    
    var viewDelegate:HomeListViewProtocol? {get set}
    
    var numberOfVideos : Int { get }
    
    var videos : [Video]? {get}
    
    func fetchVideos()
    
    func videoViewModelFor(index:Int) -> VideoViewModelProtocol?
    
    func didSelectVideo(atIndex index:Int)
    
    func logoutUser()
}

class HomeListViewModel:HomeListViewModelProtocol {
    
    var model:HomeListModelProtocol?
    weak var viewDelegate:HomeListViewProtocol?
    let userdefault = UserDefaults.standard
    
    init(withViewDelegate viewDelegate: HomeListViewProtocol? = nil, withModel model:HomeListModelProtocol? = HomeListModel()) {
        
        self.model = model
        self.viewDelegate = viewDelegate
    }
    
    var numberOfVideos : Int {
        return self.model?.videos?.count ?? 0
    }
    
    var videos : [Video]? {
        return self.model?.videos
    }
    
    
    func fetchVideos() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
        self.viewDelegate?.startSpinner()
        self.model?.fetchVideos(completion: { [weak self] (localResult) in
            self?.viewDelegate?.ceaseSpinner()
            switch localResult {
            case .success(_):
                self?.viewDelegate?.reload()
            case .failure(let error):
                print(error)
            }
        })
        }
        
        
    }
    
    func videoViewModelFor(index:Int) -> VideoViewModelProtocol? {
        guard let video = self.model?.videos?[index] else {
         return nil
        }
        
        let viewModel = VideoViewModel(video:video)
        return viewModel
    }
    
    
    func didSelectVideo(atIndex index:Int) {
        let selectedVideo = videos?[index]
        let relatedVideos = videos?.filter({ $0.id != selectedVideo?.id})
        let videoDetailModel = VideoDetailModel(withSelectedVideo: selectedVideo, relatedVideos: relatedVideos)
        viewDelegate?.selectedVideoWith(model: videoDetailModel)
        
    }
    
    func logoutUser() {
        userdefault.set(false, forKey:Key.kUserAuthenticated)
        self.viewDelegate?.didLogoutUser()
    }
}
