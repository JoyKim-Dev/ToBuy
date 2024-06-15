//
//  SearchListTableViewCell.swift
//  ToBuy
//
//  Created by Joy Kim on 6/16/24.
//

import UIKit

class SearchListTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configHierarchy()
        configLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SearchListTableViewCell:ConfigureBasicSettingProtocol {
    func configHierarchy() {
        //
    }
    
    func configLayout() {
        //
    }
    
    func configUI() {
        backgroundColor = .yellow
    }
    
    
    
    
    
}
