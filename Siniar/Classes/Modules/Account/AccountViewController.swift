//
//  AccountViewController.swift
//  Siniar
//
//  Created by yoga arie on 11/05/22.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {
    weak var tableView: UITableView!
    
    enum Library {
        case playlist
        case album
        case video
        case artist
        case download
        
        var title: String{
            switch self{
            case .playlist:
                return "My Playlist"
            case .album:
                return "Album"
            case .video:
                return "MV"
            case .artist:
                return "Artist"
            case .download:
                return "Download"
            }
        }
            
            var icon: UIImage{
                switch self{
                case .playlist:
                    return UIImage(named: "library_music")!
                case .album:
                    return UIImage(named: "album")!
                case .video:
                    return UIImage(named: "video_library")!
                case .artist:
                    return UIImage(named: "recent_actors")!
                case .download:
                    return UIImage(named: "save_alt")!
                }
            }
        }
    
    let libraryItems: [Library] = [.playlist, .album, .video, .artist, .download]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    
    func setup(){
        title = "Account"
      
        view.backgroundColor = .brand2
        let tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
        self.tableView = tableView
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.register(ProfileViewCell.self, forCellReuseIdentifier: "profileCellId")
        tableView.register(RecentActivityViewCell.self, forCellReuseIdentifier: "recentActivityCellId")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "libraryCellId")
        tableView.dataSource = self
        tableView.delegate = self
        let signOutButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(self.signOutButtonTapped(_:)))
        navigationItem.rightBarButtonItem = signOutButton
    }
    
    @objc func signOutButtonTapped(_ sender: Any){
        try? Auth.auth().signOut()
        let alert = UIAlertController(title: "Sign-Out", message: "Are you sure ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            PlayerProvider.shared.closePodcastPlayer()
            try? Auth.auth().signOut()
            self.showSignInViewController()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { _ in }))
        present(alert, animated: true, completion: nil)
    }
    
    

}

extension AccountViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1{
            return libraryItems.count
        } else if section == 2{
            return 1
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileCellId", for: indexPath) as! ProfileViewCell
            cell.profileImageView.image = UIImage(named: "img_ftux3")
            cell.delegate = self
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "libraryCellId", for: indexPath)
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = UIColor.neutral1
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            
            let library = libraryItems[indexPath.row]
            cell.textLabel?.text = library.title
            cell.imageView?.image = library.icon
            cell.accessoryType = .disclosureIndicator
            cell.tintColor = UIColor.neutral1
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recentActivityCellId", for: indexPath) as! RecentActivityViewCell
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.reloadData()
            return cell
        }
    }
    
}

extension AccountViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let library = libraryItems[indexPath.row]
        switch library{
        case .playlist:
            break
        case .download:
            break
        case .video:
            break
        case .artist:
            break
        case .album:
            break
        }
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
            if section == 1{
                label.text = "Library"
            } else {
                label.text = "Recent Activity"
            }
            
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
        if section == 0{
            return 0.0001
        } else {
            return 56
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
}

extension AccountViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activityCellId", for: indexPath) as! ActivityViewCell
        cell.imageView.image = UIImage(named: "img_ftux\((indexPath.item % 4) + 1)")
        return cell
    }
}

extension AccountViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88, height: 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
}

extension AccountViewController: ProfileViewCellDelegate{
    func profileViewCellEditButtonTapped(_ cell: ProfileViewCell) {
        showEditProfileViewController()
    }
    
    
}
