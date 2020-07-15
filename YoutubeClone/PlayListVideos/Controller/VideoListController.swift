//
//  ViewController.swift
//  YoutubeClone
//
//  Created by Ajay Choudhary on 04/07/20.
//  Copyright © 2020 Ajay Choudhary. All rights reserved.
//

import UIKit

fileprivate typealias VideoDataSource = UITableViewDiffableDataSource<VideoListController.Section, Video>
fileprivate typealias VideoSnapshot = NSDiffableDataSourceSnapshot<VideoListController.Section, Video>

class VideoListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var videos = [Video]()
    private var dataSource: VideoDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        setupDataSource()
        YoutubeClient.getVideos { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let videos):
                DispatchQueue.main.async { self.updateUI(videos: videos) }
            case .failure(let error):
                DispatchQueue.main.async { self.presentAlert(message: error.rawValue) }
            }
        }
    }
    
    private func setupDataSource() {
        dataSource = VideoDataSource(tableView: tableView) { (tableView, indexPath, video) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_ID, for: indexPath) as! VideoCell
            cell.video = video
            return cell
        }
    }
    
    private func createSnapShot(from: [Video]) {
        var snapshot = VideoSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(videos)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func updateUI(videos: [Video]) {
        self.videos = videos
        createSnapShot(from: videos)
    }
    
    private func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Failure", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

extension VideoListController {
    fileprivate enum Section {
        case main
    }
}

extension VideoListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let video = dataSource.itemIdentifier(for: indexPath) else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        vc.video = video
        self.present(vc, animated: true)
    }
}

