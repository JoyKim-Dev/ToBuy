//
//  SearchItemDetailVC.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit

class SearchItemDetailVC: UIViewController {

    var searchWordFromPreviousPage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configHierarchy()
        configLayout()
        configUI()

    }
    

}

extension SearchItemDetailVC: ConfigureBasicSettingProtocol {
    func configHierarchy() {
        //
    }
    
    func configLayout() {
        //
    }
    
    func configUI() {
        configureView(searchWordFromPreviousPage!)
    }
    
    
    
}
