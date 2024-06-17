//
//  SearchResultWebViewViewController.swift
//  ToBuy
//
//  Created by Joy Kim on 6/16/24.
//

import UIKit

class SearchResultWebViewViewController: UIViewController {

    var searchWordFromPreviousPage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configHierarchy()
        configLayout()
        configUI()

    }
    

}

extension SearchResultWebViewViewController:ConfigureBasicSettingProtocol {
    func configHierarchy() {
        //
    }
    
    func configLayout() {
        //
    }
    
    func configUI() {
        configureView(searchWordFromPreviousPage!.replacingOccurrences(of: "[<b></b>]", with: "", options: .regularExpression))
    }
    
    
    
    
}

