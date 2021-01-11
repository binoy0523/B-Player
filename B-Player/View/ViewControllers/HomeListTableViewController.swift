//
//  HomeListTableViewController.swift
//  B-Player
//
//  Created by user on 10/01/21.
//

import UIKit

class HomeListTableViewController: UITableViewController, HomeListViewProtocol {
   
    
  
    var viewModel : HomeListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel =  HomeListViewModel(withViewDelegate: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
            self.viewModel?.fetchVideos()
    }
    
    @IBAction func logoutAction(_ sender: UIBarButtonItem) {
     
        self.viewModel?.logoutUser()
    }
    
    private  func setRootToSignIn() {
     guard let window = self.currentWindow else {
             return
         }
         let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController")
         window.rootViewController = vc
         let options: UIView.AnimationOptions = .transitionCrossDissolve
         let duration: TimeInterval = 0.5
         UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
         { completed in
         })

     }
    
    //    MARK:- ViewProtocl Implementation
    func reload() {
        self.tableView.reloadData()
    }
    
    func selectedVideoWith(model: VideoDetailModelProtocol) {
       
        guard let videoDetailVc = self.storyboard?.instantiateViewController(identifier: "VideoDetailViewController") as? VideoDetailViewController else { return }
        let videoDetailViewModel = VideoDetailViewModel(withViewDelegate: videoDetailVc, withModel: model)
        videoDetailVc.viewModel = videoDetailViewModel
        self.navigationController?.pushViewController(videoDetailVc, animated: true)
        
    }
    
    func startSpinner() {
        self.showSpinner()
    }
    
    func ceaseSpinner() {
        DispatchQueue.main.async {
            self.removeSpinner()
        }
        
        
    }
    
    func showAlertWith(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
    
    func didLogoutUser() {
        self.setRootToSignIn()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel?.numberOfVideos ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath)
        
        // Configure the cell...
        if let cell = cell as? VideoTableViewCell, let videoViewModel = self.viewModel?.videoViewModelFor(index: indexPath.row) {
            cell.setVideoList(for: videoViewModel)
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectVideo(atIndex: indexPath.row)
        
    }
    
    
}
