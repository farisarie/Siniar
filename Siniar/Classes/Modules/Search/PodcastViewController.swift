//
//  PodcastViewController.swift
//  Siniar
//
//  Created by yoga arie on 16/05/22.
//

import UIKit
import Kingfisher
import FeedKit
import SafariServices

class PodcastViewController: UIViewController {

    weak var tableView: UITableView!
    
    var podcast: Podcast!
    var rssFeed: RSSFeed?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        loadData()
         
        NotificationCenter.default.addObserver(self, selector: #selector(self.PlayerProviderStateDidChange(_:)), name: NSNotification.Name.PlayerProviderStateDidChange, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.PlayerProviderStateDidChange, object: nil)
    }
    
    func setup(){
        view.backgroundColor = UIColor.brand2
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
        self.tableView = tableView
        tableView.backgroundColor = UIColor.clear
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(PodcastDetailViewCell.self, forCellReuseIdentifier: "detailCellId")
        tableView.register(EpisodeViewCell.self, forCellReuseIdentifier: "episodeCellId")
        tableView.dataSource = self
        tableView.delegate = self
        
        let backButton = UIButton(type: .system)
        view.addSubview(backButton)
        backButton.setImage(UIImage(named: "btn_back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.setTitle(nil, for: .normal)
        backButton.layer.cornerRadius = 12
        backButton.layer.masksToBounds = true
        backButton.backgroundColor = UIColor.brand2.withAlphaComponent(0.6)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
        ])
        backButton.addTarget(self, action: #selector(self.closeButtonTapped(_:)), for: .touchUpInside)
        
        
    }
    func loadData(){
        iTunesProvider.shared.loadFromFeedUrl(podcast.feedUrl) { (result) in
            switch result{
            case .success(let rssFeed):
                self.rssFeed = rssFeed
                self.tableView.reloadData()
            case .failure(let error):
                self.presentAlert(title: "Oops!", message: error.localizedDescription) { _ in
                    
                }
            }
        }
        
    }
    @objc func PlayerProviderStateDidChange(_ sender: Notification){
        tableView.reloadData()
    }

}



// MARK: - UITableViewDataSource
extension PodcastViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        } else {
            return rssFeed?.items?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCellId", for: indexPath) as! PodcastDetailViewCell
            cell.artworkImageView.kf.setImage(with: URL(string: podcast.artworkUrl600))
            cell.titleLabel.text = podcast.collectionName
            cell.subtitleLabel.text = podcast.artistName
            cell.descLabel.attributedText = rssFeed?.description?.convertHtmlToAttributedStringWithCSS(
                font: UIFont.systemFont(ofSize: 14, weight: .regular),
                csscolor: "#EEEEEE",
                lineheight: 16,
                csstextalign: "left"
            )
            cell.genreLabel.text = rssFeed?.iTunes?.iTunesCategories?.compactMap({ $0.attributes?.text})
                .joined(separator: " • ")
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCellId", for: indexPath) as! EpisodeViewCell
            let episode = rssFeed?.items?[indexPath.row]
            cell.episodeImageView.kf.setImage(with: URL(string: episode?.iTunes?.iTunesImage?.attributes?.href ?? ""))
            cell.dateLabel.text = episode?.pubDate?.string(format: "d MMM yyyy")
            cell.titleLabel.text = episode?.title
            cell.subtitleLabel.attributedText = episode?.description?.convertHtmlToAttributedStringWithCSS(
                font: UIFont.systemFont(ofSize: 14, weight: .regular),
                csscolor: "#EEEEEE",
                lineheight: 16,
                csstextalign: "left"
            )
            cell.durationLabel.text = episode?.iTunes?.iTunesDuration?.string
            cell.delegate = self
            
            let playerProvider = PlayerProvider.shared
            if playerProvider.playlist == rssFeed, playerProvider.currentIndex == indexPath.row, playerProvider.isPodcastPlaying() {
                cell.playButton.setImage(UIImage(named: "btn_pause_small")?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
            else {
                cell.playButton.setImage(UIImage(named: "btn_play_small")?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension PodcastViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        else {
            let view = UIView(frame: .zero)
            view.backgroundColor = .clear
            
            let label = UILabel(frame: .zero)
            label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            label.textColor = .neutral1
            label.text = "Episodes"
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
            ])
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0001
        } else {
            return 56
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
}

// MARK: - EpisodeViewCellDelegate
extension PodcastViewController: EpisodeViewCellDelegate{
    func episodeViewCellPlayButtonTapped(_ cell: EpisodeViewCell) {
        if let indexPath = tableView.indexPath(for: cell), let playlist = rssFeed{
            let playerProvider = PlayerProvider.shared
            if playerProvider.playlist == playlist,
               playerProvider.currentIndex == indexPath.row {
                playerProvider.podcastPlay()
                
            } else {
                playerProvider.launchPodcastPlaylist(playlist: playlist, index: indexPath.row)
            }
            }
        }
    }


extension PodcastViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let viewController = SFSafariViewController(url: URL)
        present(viewController, animated: true, completion: nil)
        return false
    }
}

// MARK: - UIViewController {
extension UIViewController{
    func presentPodcastViewController(_ podcast: Podcast) {
        let viewController = PodcastViewController()
        viewController.podcast = podcast
        present(viewController, animated: true, completion: nil)
    }
}
