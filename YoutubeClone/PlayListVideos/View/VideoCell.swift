//
//  VideoCell.swift
//  YoutubeClone
//
//  Created by Ajay Choudhary on 15/07/20.
//  Copyright © 2020 Ajay Choudhary. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    let placeholder = UIImage(named: "placeholder")
    
    var video: Video? {
        didSet {
            guard let video = video else { return }
            titleLabel.text = video.title
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            dateLabel.text = dateFormatter.string(from: video.published)
            downloadThumbnailImage(video: video)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func downloadThumbnailImage(video: Video){
        
        if let cachedData = CacheManager.getVideoCache(video.thumbnail) {
            thumbnailImageView.image = UIImage(data: cachedData)
            return
        }
        
        guard video.thumbnail != "" else {
            self.thumbnailImageView.image = self.placeholder
            return
        }
        
        let url = URL(string: video.thumbnail)
        let task = URLSession.shared.dataTask(with: url!) { [weak self] (data, response, error) in
            
            guard let self = self else { return }
            if error != nil {
                self.thumbnailImageView.image = self.placeholder
                return
            }
            
            guard let data = data else {
                self.thumbnailImageView.image = self.placeholder
                return
            }

            guard url!.absoluteString == video.thumbnail else { return }
            CacheManager.setVideCache(url!.absoluteString, data)
            DispatchQueue.main.async { self.thumbnailImageView.image = UIImage(data: data) }
        }
        task.resume()
    }
    
}
