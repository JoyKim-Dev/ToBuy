//
//  SearchResultWebViewViewController.swift
//  ToBuy
//
//  Created by Joy Kim on 6/16/24.
//

import UIKit

import SnapKit
import WebKit

class SearchResultWebViewViewController: UIViewController {
    
    var searchDataFromPreviousPage:ItemResult?
    var userDefaultsDidChange: Bool = false
    
    let webView = WKWebView()
    lazy var navLikeBtn = UIBarButtonItem(image: .likeSelected, style: .plain, target: self, action: #selector(navLikeBtnTapped))
    
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
        
        if UserDefaults.standard.bool(forKey: searchDataFromPreviousPage?.productId ?? "") == true {
            navLikeBtn.image = .likeSelected.withRenderingMode(.alwaysOriginal)
        } else {
            navLikeBtn.image = .likeUnselected.withRenderingMode(.alwaysOriginal)
        }
        navigationItem.rightBarButtonItem = navLikeBtn
        
        guard let url = searchDataFromPreviousPage?.link else {
            print("nil")
            return
        }
        
        guard let validURL = URL(string: url) else {
            print("유효하지 않은 url")
            return
        }
        let request = URLRequest(url: validURL)
        webView.load(request)
        
    }

    
    @objc func navLikeBtnTapped() {
        
        if navLikeBtn.image == Icon.likeUnSelected {
            navLikeBtn.image = Icon.likeSelected.withRenderingMode(.alwaysOriginal)
            UserDefaults.standard.setValue(true, forKey: searchDataFromPreviousPage?.productId ?? "미정")
            UserDefaultManager.storedDataisChanged = true
        } else {
            navLikeBtn.image = Icon.likeUnSelected.withRenderingMode(.alwaysOriginal)
            UserDefaults.standard.setValue(false, forKey: searchDataFromPreviousPage?.productId ?? "미정")
            UserDefaultManager.storedDataisChanged = true
        }
    }
    
}

