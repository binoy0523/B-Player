//
//  VideoTableViewCell.swift
//  B-Player
//
//  Created by user on 10/01/21.
//

import UIKit
import SDWebImage
class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageview: UIImageView!
    
    @IBOutlet weak var videotitle: UILabel!
    
    @IBOutlet weak var videoDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setVideoList(for viewModel:VideoViewModelProtocol) {
        self.videotitle.text = viewModel.title
        self.videoDescription.text = viewModel.videoDescription
        guard let thumbnail = viewModel.thumbnail ,let imgUrl = URL(string: thumbnail) else { return }
        self.thumbImageview.sd_setImage(with: imgUrl)
        
    }

}
