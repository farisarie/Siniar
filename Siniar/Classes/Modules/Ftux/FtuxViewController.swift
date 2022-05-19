//
//  FtuxViewController.swift
//  Siniar
//
//  Created by yoga arie on 10/05/22.
//

import UIKit

class FtuxViewController: UIViewController {
    
    weak var collectionView: UICollectionView!
    weak var pageControl: UIPageControl!
    weak var startButton: UIButton!
    
    let data: [Ftux] = [
        Ftux(image: "img_ftux1", title: "WELCOME TO SINIAR APP", subtitle: "Make your design workflow easier and save your time"),
        Ftux(image: "img_ftux2", title: "WELCOME TO SINIAR APP", subtitle: "Make your design workflow easier and save your time"),
        Ftux(image: "img_ftux3", title: "WELCOME TO SINIAR APP", subtitle: "Make your design workflow easier and save your time"),
        Ftux(image: "img_ftux4", title: "SINIAR APP", subtitle: "Lorem ipsum dolor sit amet")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = UIColor.brand2
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        self.collectionView = collectionView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionView.backgroundColor = .black
        collectionView.isPagingEnabled = true
        collectionView.register(FtuxViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        let button = PrimaryButton()
        view.addSubview(button)
        self.startButton = button
        button.setTitle("GET STARTED", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            button.heightAnchor.constraint(equalToConstant: 46)
        ])
        button.addTarget(self, action: #selector(self.startButtonTapped(_:)), for: .touchUpInside)
        
        let pageControl = UIPageControl()
        view.addSubview(pageControl)
        self.pageControl = pageControl
        pageControl.currentPageIndicatorTintColor = UIColor.brand1
        pageControl.pageIndicatorTintColor = UIColor(rgb: 0x71737B)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -100),
            pageControl.heightAnchor.constraint(equalToConstant: 26)
        ])
        if #available(iOS 14.0, *) {
          pageControl.backgroundStyle = .minimal
          pageControl.allowsContinuousInteraction = false
        }
    }
    
    @objc func startButtonTapped(_ sender: Any) {
        showSignInViewController()
    }
}

// MARK: - Code that handle collection view data source
extension FtuxViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! FtuxViewCell
        
        let ftux = data[indexPath.item]
        cell.imageView.image = UIImage(named: ftux.image)
        cell.titleLabel.text = ftux.title
        cell.subtitleLabel.text = ftux.subtitle
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FtuxViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        return CGSize(width: screenSize.width, height: screenSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - UICollectionViewDelegate
extension FtuxViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
            pageControl.currentPage = page
        }
    }
}

   


