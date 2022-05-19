//
//  HomeViewController.swift
//  Siniar
//
//  Created by yoga arie on 11/05/22.
//

import UIKit

class HomeViewController: UIViewController {
    weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        
    }
    func setup(){
    title = "Siniar"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
        view.backgroundColor = .brand2
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
        self.tableView = tableView
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        tableView.register(AlbumsViewCell.self, forCellReuseIdentifier: "albumsCellId")
        tableView.register(WeeklyViewCell.self, forCellReuseIdentifier: "weeklyCellId")
        tableView.register(MusicViewCell.self, forCellReuseIdentifier: "musicCellId")
        tableView.dataSource = self
        tableView.delegate = self
    }
    

}


//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 20
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "albumsCellId", for: indexPath) as! AlbumsViewCell
            cell.titleLabel.text = "New Podcasts"
            cell.viewAllButton.setTitle("View All", for: .normal)
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.reloadData()
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "weeklyCellId", for: indexPath) as! WeeklyViewCell
            cell.titleLabel.text = "Siniar Weekly"
            cell.nameLabel.text = "Lorem"
            cell.descLabel.text = "Ipsum dolor sit amet"
            cell.thumbImageView.image = UIImage(named: "img_ftux2")
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "musicCellId", for: indexPath) as! MusicViewCell
            cell.noLabel.text = String(format: "%2d", indexPath.row + 1)
            cell.thumbImageView.image = UIImage(named: "img_ftux\((indexPath.item % 4) + 1)")
            cell.titleLabel.text = "Title \(indexPath.item + 1)"
            cell.subtitleLabel.text = "Subtitle \(indexPath.item + 1)"
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
}

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            let view = UIView(frame: .zero)
            view.backgroundColor = .clear
            let label = UILabel(frame: .zero)
            label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            label.textColor = .neutral1
            label.text = "Recently Music"
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
            ])
            
            return view
            
            
        } else{
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2{
            return 56
        }
        else {
            return 0.0001
    }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
}

    



//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCellId", for: indexPath) as! AlbumViewCell
        cell.imageView.image = UIImage(named: "img_ftux\((indexPath.item % 4) + 1)")
        cell.titleLabel.text = "Title \(indexPath.item + 1)"
        cell.subtitleLabel.text = "Subtitle \(indexPath.item + 1)"
        return cell
    }
    
}

//MARK: - UICollectionViewFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

