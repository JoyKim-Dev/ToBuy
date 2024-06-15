//
//  SearchMainVC.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit
import SnapKit

class SearchMainVC: UIViewController {

  let searchBar = SearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        configHierarchy()
        configLayout()
        configUI()
    }
    

 

}

extension SearchMainVC: ConfigureBasicSettingProtocol {
    func configHierarchy() {
        view.addSubview(searchBar)
    }
    
    func configLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func configUI() {
        let nickname = UserDefaultManager.nickname
        configureView("\(nickname)'s ToBuyBag")
    }
    
    
    
    
}
