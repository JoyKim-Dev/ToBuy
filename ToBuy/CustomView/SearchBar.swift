//
//  SearchBar.swift
//  ToBuy
//
//  Created by Joy Kim on 6/16/24.
//

import UIKit

class SearchBar:UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = Color.lightGray
        placeholder = "브랜드, 상품 등을 입력하세요."
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
