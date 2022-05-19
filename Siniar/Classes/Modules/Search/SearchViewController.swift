//
//  SearchViewController.swift
//  Siniar
//
//  Created by yoga arie on 11/05/22.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {

    weak var tableView: UITableView!
    weak var searchController : UISearchController!
    var podcasts: [Podcast]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    // MARK: - Helpers
    func setup(){
        title = "Search"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        view.backgroundColor = .brand2
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
        self.tableView = tableView
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.register(MusicViewCell.self, forCellReuseIdentifier: "musicCellId")
        tableView.register(SearchHistoryViewCell.self, forCellReuseIdentifier: "searchCellId")
        tableView.dataSource = self
        tableView.delegate = self
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .neutral1
        searchController.searchBar.barStyle = .black
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
        }
        self.searchController = searchController
        searchController.searchBar.delegate = self
     
    }
    
    func search(_ term: String){
        
        iTunesProvider.shared.search(term) { (result) in
            switch result{
            case .success(let data):
                self.podcasts = data //ketika berhasil membawa data dari api
                
                self.tableView.reloadData()
            case .failure(let error):
                self.presentAlert(title: "Error!", message: error.localizedDescription) { _ in
                    
                }
            }
        }
    }

}
// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(searchBar.text ?? "")
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let string = NSString(string: searchBar.text ?? "").replacingCharacters(in: range, with: text)
        if string.count >= 3{
            search(string)
        }
        return true
    }
    
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return podcasts == nil ? 1 : 0 //kalo sudah disearch history pencarian akan kosong rowsnya
        } else{
            return podcasts?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchCellId", for: indexPath) as! SearchHistoryViewCell
            cell.setHistory(["Lorem", "Ipsum", "Dolor", "Ipsum", "Dolor", "Ipsum", "Dolor", "Ipsum", "Dolor", "Ipsum", "Dolor"])
            return cell
        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCellId", for: indexPath) as! MusicViewCell
        
        cell.noLabel.isHidden = true
            
        let podcast = podcasts![indexPath.row]
            
        let scale = UIScreen.main.scale
            let imageUrl: String
            if scale == 1{
                imageUrl = podcast.artworkUrl30
            } else if scale == 2 {
                imageUrl = podcast.artworkUrl60
            } else {
                imageUrl = podcast.artworkUrl100
            }
            
        cell.thumbImageView.kf.setImage(with: URL(string: imageUrl))
        cell.titleLabel.text = podcast.trackName
        cell.subtitleLabel.text = podcast.artistName
        return cell
    }
}
}

//MARK:- UITableViewDelegate
extension SearchViewController: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) 
        if let podcast = podcasts?[indexPath.row] {
            presentPodcastViewController(podcast)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if (section == 0 && podcasts == nil) || (section == 1 && podcasts != nil){ // Mengkondisikan ketika header tidak diperlukan akan dihilangkan
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .neutral1
        if section == 0 {
            label.text = "History"
        } else {
        label.text = "Search Result"
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
        else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (section == 0 && podcasts == nil) || (section == 1 && podcasts != nil) {
            
         return 56
        } else {
            return 0.0001
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
}
