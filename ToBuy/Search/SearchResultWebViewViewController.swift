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
    let folderRepository = FolderRepository()
    var detail = List<LikedItemTable>()
    
    private let webView = WKWebView()
    private lazy var navLikeBtn = UIBarButtonItem(image: .likeSelected, style: .plain, target: self, action: #selector(navLikeBtnTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configHierarchy()
        configLayout()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configUI()
        // 장바구니 like 수 갱신 위해 호출..이방법이 최선인가?
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
        
        guard let id = searchDataFromPreviousPage?.productId, let title = searchDataFromPreviousPage?.title, let price = searchDataFromPreviousPage?.lprice, let weblink = searchDataFromPreviousPage?.link, let image = searchDataFromPreviousPage?.image , let brand = searchDataFromPreviousPage?.brand else {
            print("no data")
            return
        }
        
        let liked = LikedItemTable(id: id, title: title, price: price, webLink: weblink, brand: brand, image: image )
        
        let folderName = realm.objects(Folder.self).where {
            $0.brandName == liked.brand}
        
        if let _ = realm.object(ofType: LikedItemTable.self, forPrimaryKey: id) {
            repository.deleteItem(id: id)
            print("Product deleted")
        } else {
                if let folder = folderName.first {
                    repository.createItem(liked, folder: folder)
                } else {
                    detail.append(liked)
                    let folder = Folder(brandName: liked.brand, detail: detail)
                    folderRepository.createFolder(folder)
                }
        }
        configUI()
    }
}

