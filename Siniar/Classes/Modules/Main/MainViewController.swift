//
//  MainViewController.swift
//  Siniar
//
//  Created by yoga arie on 11/05/22.
//

import UIKit
import Kingfisher
import MediaPlayer

class MainViewController: UITabBarController {

    weak var playerView: UIView!
    weak var episodeImageView: UIImageView!
    weak var episodeTitleLabel: UILabel!
    weak var previousButton: UIButton!
    weak var playButton: UIButton!
    weak var nextButton: UIButton!
    weak var progressView: UIView!
    weak var progressViewWidthConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
  
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerProviderStateDidChange(_:)), name: .PlayerProviderStateDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerProviderNowPlayingInfoDidChange(_:)), name: .PlayerProviderNowPlayingInfoDidChange, object: nil)
        
        
    }

    func setup(){
        tabBar.tintColor = UIColor.brand1
        tabBar.unselectedItemTintColor = UIColor.neutral2
  
        let homeNC = BaseNavigationController(rootViewController: HomeViewController())
        homeNC.title = "Home"
        homeNC.tabBarItem.image = UIImage(named: "tab_home")
        homeNC.tabBarItem.selectedImage = UIImage(named: "tab_home")
     
        let searchNC = BaseNavigationController(rootViewController: SearchViewController())
        searchNC.title = "Search"
        searchNC.tabBarItem.image = UIImage(named: "tab_search")
        searchNC.tabBarItem.selectedImage = UIImage(named: "tab_search")
        
        let accountNC = BaseNavigationController(rootViewController: AccountViewController())
        accountNC.title = "Account"
        accountNC.tabBarItem.image = UIImage(named: "tab_account")
        accountNC.tabBarItem.selectedImage = UIImage(named: "tab_account")
        
        viewControllers = [homeNC, searchNC, accountNC]
        
        let playerView = UIView(frame: .zero)
        view.addSubview(playerView)
        self.playerView = playerView
        playerView.backgroundColor = UIColor.brand1
        playerView.layer.cornerRadius = 8
        playerView.layer.masksToBounds = true
        playerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            playerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -8)
        ])
        playerView.isHidden = true
        
        let imageView = UIImageView(frame: .zero)
        playerView.addSubview(imageView)
        self.episodeImageView = imageView
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = 21
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 42),
            imageView.heightAnchor.constraint(equalToConstant: 42),
            imageView.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 8),
            imageView.topAnchor.constraint(equalTo: playerView.topAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: playerView.bottomAnchor, constant: -8)
        ])
     
        let label = UILabel(frame: .zero)
        playerView.addSubview(label)
        self.episodeTitleLabel = label
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor.neutral3
        label.text = "Episode"
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
        
        let previousButton = UIButton(type: .system)
        playerView.addSubview(previousButton)
        self.previousButton = previousButton
        previousButton.setImage(UIImage(named: "btn_previous")?.withRenderingMode(.alwaysOriginal), for: .normal)
        previousButton.setTitle(nil, for: .normal)
        previousButton.addTarget(self, action: #selector(self.previousButtonTapped(_:)), for: .touchUpInside)
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            previousButton.widthAnchor.constraint(equalToConstant: 24),
            previousButton.heightAnchor.constraint(equalToConstant: 24),
            previousButton.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 20),
            previousButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
        
        let playButton = UIButton(type: .system)
        playerView.addSubview(playButton)
        self.playButton = playButton
        playButton.layer.cornerRadius = 16
        playButton.layer.masksToBounds = true
        playButton.layer.borderWidth = 1
        playButton.layer.borderColor = UIColor.neutral3.cgColor
        playButton.setImage(UIImage(named: "btn_play")?.withRenderingMode(.alwaysOriginal), for: .normal)
        playButton.setTitle(nil, for: .normal)
        playButton.addTarget(self, action: #selector(self.playButtonTapped(_:)), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.widthAnchor.constraint(equalToConstant: 32),
            playButton.heightAnchor.constraint(equalToConstant: 32),
            playButton.leadingAnchor.constraint(equalTo: previousButton.trailingAnchor, constant: 16),
            playButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
        
        let nextButton = UIButton(type: .system)
        playerView.addSubview(nextButton)
        self.nextButton = nextButton
        nextButton.setImage(UIImage(named: "btn_next")?.withRenderingMode(.alwaysOriginal), for: .normal)
        nextButton.setTitle(nil, for: .normal)
        nextButton.addTarget(self, action: #selector(self.nextButtonTapped(_:)), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.widthAnchor.constraint(equalToConstant: 24),
            nextButton.heightAnchor.constraint(equalToConstant: 24),
            nextButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 16),
            nextButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            nextButton.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -8)
        ])
        
        let progressView = UIView(frame: .zero)
        playerView.addSubview(progressView)
        self.progressView = progressView
        progressView.backgroundColor = UIColor.neutral3
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.heightAnchor.constraint(equalToConstant: 2),
            progressView.leadingAnchor.constraint(equalTo: playerView.leadingAnchor),
            progressView.bottomAnchor.constraint(equalTo: playerView.bottomAnchor)
        ])
        let widthConstraint = progressView.widthAnchor.constraint(equalToConstant: 128)
        widthConstraint.isActive = true
        self.progressViewWidthConstraint = widthConstraint
    }
    
    func showPlayerView(){
        playerView.isHidden = false
        viewControllers?.forEach({ (viewController) in
            if #available(iOS 11.0, *) {
                viewController.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: playerView.bounds.height + 8, right: 0)
            } else {
                // Fallback on earlier versions
                
            }
        })
        let playerProvider = PlayerProvider.shared
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        playerProvider.podcastPlayer.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { [weak self] (time) in
            guard let `self` = self, let currentItem = playerProvider.podcastPlayer.currentItem else {
                return
            }
            let currentSeconds = CMTimeGetSeconds(time)
            let totalSeconds = CMTimeGetSeconds(currentItem.duration)
            let progress: CGFloat = max(0.0001, CGFloat(currentSeconds / totalSeconds))
            self.progressViewWidthConstraint?.constant = self.playerView.bounds.width * progress
            self.view.setNeedsLayout()
        }
    }
    
    func hidePlayerView(){
        playerView.isHidden = true
        viewControllers?.forEach({ (viewController) in
            if #available(iOS 11.0, *) {
                viewController.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            } else {
                // Fallback on earlier versions
                
            }
        })
    }
    
    
    // MARK: - Actions
    @objc func previousButtonTapped(_ sender: Any){
        PlayerProvider.shared.podcastPrevious()
    }
    @objc func playButtonTapped(_ sender: Any){
        PlayerProvider.shared.podcastPlay()
    }
    
    @objc func nextButtonTapped(_ sender: Any){
        PlayerProvider.shared.podcastNext()
    }

    @objc func playerProviderStateDidChange(_ sender: Notification){
        showPlayerView()
        playerProviderNowPlayingInfoDidChange(sender)
    }
    
    @objc func playerProviderNowPlayingInfoDidChange(_ sender: Notification){
        let playerProvider = PlayerProvider.shared
        if let episode = playerProvider.playlist?.items?[playerProvider.currentIndex]{
            episodeImageView.kf.setImage(with: URL(string: episode.pictureUrl ?? ""))
            episodeTitleLabel.text = episode.title
            playButton.setImage(UIImage(named: playerProvider.isPodcastPlaying() ? "btn_pause" : "btn_play")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        
    }
}


extension UIViewController {
    func showMainViewController() {
        let viewController = MainViewController()
//        let navigationController = UINavigationController(rootViewController: viewController)
//
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        window?.rootViewController = viewController
    }
}
