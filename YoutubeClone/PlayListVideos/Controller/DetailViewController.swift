//
//  DetailViewController.swift
//  YoutubeClone
//
//  Created by Ajay Choudhary on 15/07/20.
//  Copyright © 2020 Ajay Choudhary. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var webView: WKWebView!
    
    var video: Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        guard let video = video else { return }
        
        titleLabel.text = video.title
        descriptionTextView.text = video.description
        descriptionTextView.isEditable = false
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateLabel.text = dateFormatter.string(from: video.published)
        
        
        guard let url = URL(string: Constants.YT_EMBED_URL + video.videoId) else {
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}
