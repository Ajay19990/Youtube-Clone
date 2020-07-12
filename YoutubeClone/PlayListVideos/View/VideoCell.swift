//
//  VideoCell.swift
//  YoutubeClone
//
//  Created by Ajay Choudhary on 12/07/20.
//  Copyright © 2020 Ajay Choudhary. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
    }
}
