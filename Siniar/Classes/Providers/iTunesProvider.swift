//
//  iTunesProvider.swift
//  Siniar
//
//  Created by yoga arie on 12/05/22.
//

import Foundation

import RxSwift
import Moya
import FeedKit

class iTunesProvider{
    static var shared: iTunesProvider = iTunesProvider()
    private init(){}
    
    private let disposeBag = DisposeBag()
    
    func search(_ term: String, media: String = "podcast", limit: Int = 50, completion: @escaping (Result<[Podcast], Error>) -> Void){
        api.rx.request(.search(term: term, media: media, limit: limit)).map(SearchResponse.self)
            .subscribe { (response) in
                switch response {
                case .success(let searchResponse):
                    completion(.success(searchResponse.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            .disposed(by: disposeBag)
    }
    
    func loadFromFeedUrl(_ url: String, completion: @escaping (Result<RSSFeed?, Error>) -> Void){
        let feedURL = URL(string: url)!
        let parser = FeedParser(URL: feedURL)
        parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            // Do your thing, then back to the Main thread
            DispatchQueue.main.async {
                // ..and update the UI
                switch result{
                case .success(let feed):
                    let rssFeed = feed.rssFeed
                    completion(.success(rssFeed))
                    
                case .failure(let error):
                    completion(.failure(error))
                    
                }
            }
        }
    }
        
   
    
}


