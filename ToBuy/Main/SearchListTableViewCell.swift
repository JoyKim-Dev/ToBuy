//
//  SearchListTableViewCell.swift
//  ToBuy
//
//  Created by Joy Kim on 6/16/24.
//

import UIKit
import SnapKit

final class SearchListTableViewCell: UITableViewCell {
 
    private let leftIconImageView = UIImageView()
    private let searchWordLabel = UILabel()
     let deleteBtn = LikeBtn()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configHierarchy()
        configLayout()
        
        leftIconImageView.image = Icon.clock
        leftIconImageView.tintColor = Color.black
        deleteBtn.setImage(Icon.xMark, for: .normal)
        deleteBtn.tintColor = Color.black
        deleteBtn.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchListTableViewCell {
     func configHierarchy() {
        
        contentView.addSubview(leftIconImageView)
        contentView.addSubview(searchWordLabel)
        contentView.addSubview(deleteBtn)
    }
    
     func configLayout() {

        leftIconImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.width.equalTo(leftIconImageView.snp.height)
        }
        
        searchWordLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(leftIconImageView.snp.trailing).offset(10)
        }
        
        deleteBtn.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.width.equalTo(leftIconImageView.snp.height)
        }
    }
    
     func configUI(searchKeywordRow: Int) {
        
        
        searchWordLabel.text = UserDefaultManager.searchKeyword[searchKeywordRow]
        searchWordLabel.font = Font.semiBold14
  
    }
}
