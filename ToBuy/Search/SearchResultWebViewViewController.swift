//
//  SearchResultWebViewViewController.swift
//  ToBuy
//
//  Created by Joy Kim on 6/16/24.
//

import UIKit

import SnapKit
import WebKit
import RealmSwift

final class SearchResultWebViewViewController: UIViewController {
    let realm = try! Realm()
    let repository = LikedItemTableRepository()
    var searchDataFromPreviousPage:ItemResult?
    var likedDataFromPreviousPage: String = ""
    
    private let webView = WKWebView()
    private lazy var navLikeBtn = UIBarButtonItem(image: .likeSelected, style: .plain, target: self, action: #selector(navLikeBtnTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configHierarchy()
        configLayout()
        configUI()
    }
}

extension SearchResultWebViewViewController:ConfigureBasicSettingProtocol {
    func configHierarchy() {
        view.addSubview(webView)
    }
    
    func configLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configUI() {
        navigationItem.leftBarButtonItem = NavBackBtnChevron(currentVC: self)
        
        configureView(searchDataFromPreviousPage?.title.replacingOccurrences(of: "[<b></b>]", with: "", options: .regularExpression) ?? "")
        if let _ = realm.object(ofType: LikedItemTable.self, forPrimaryKey: searchDataFromPreviousPage?.productId) {
            navLikeBtn.image = .likeSelected.withRenderingMode(.alwaysOriginal)
        } else {
            navLikeBtn.image = .likeUnselected.withRenderingMode(.alwaysOriginal)
        }
        
        
        
        //        if UserDefaultManager.likedItemID.contains(searchDataFromPreviousPage?.productId ?? "nil") {
        //            navLikeBtn.image = .likeSelected.withRenderingMode(.alwaysOriginal)
        //        } else {
        //            navLikeBtn.image = .likeUnselected.withRenderingMode(.alwaysOriginal)
        //        }
        
        navigationItem.rightBarButtonItem = navLikeBtn
        
        guard let url = searchDataFromPreviousPage?.link else {
            return
        }
        
        guard let validURL = URL(string: url) else {
            print("유효하지 않은 url")
            return
        }
        
        if likedDataFromPreviousPage != "" {
            let request = URLRequest(url: URL(string:likedDataFromPreviousPage)!)
            webView.load(request)
        } else {
            let request = URLRequest(url: validURL)
            webView.load(request)
        }
    }
    
    
    @objc func navLikeBtnTapped() {
        
        guard let id = searchDataFromPreviousPage?.productId, let title = searchDataFromPreviousPage?.title, let price = searchDataFromPreviousPage?.lprice, let weblink = searchDataFromPreviousPage?.link, let image = searchDataFromPreviousPage?.image else {
            print("no data")
            return
        }
        
        let liked = LikedItemTable(id: id, title: title, price: price, webLink: weblink, image: image )
        
        if let _ = realm.object(ofType: LikedItemTable.self, forPrimaryKey: id) {
            repository.deleteItem(id: id)
             print("Product deleted")
         } else {
             repository.createItem(liked)
             print("Product added")
         }
        
        
//        if UserDefaultManager.likedItemID.contains(id) {
//            UserDefaultManager.likedItemID.removeAll {$0 == id}
//        } else {
//            UserDefaultManager.likedItemID.append(id)
//        }
        configUI()
    }
}

