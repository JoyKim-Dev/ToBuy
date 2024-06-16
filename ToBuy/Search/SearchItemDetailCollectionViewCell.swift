//
//  SearchResultDetailCollectionViewCell.swift
//  ToBuy
//
//  Created by Joy Kim on 6/16/24.
//

import UIKit

import SnapKit
import Kingfisher

class SearchItemDetailCollectionViewCell: UICollectionViewCell {
    
    let productImageView = UIImageView()
    let likeBtn = UIButton()
    
    let storeNameLabel = UILabel()
    let productNameLabel = UILabel()
    let productPriceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configHierarchy()
        configLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchItemDetailCollectionViewCell {
    func configHierarchy() {
        contentView.addSubview(productImageView)
        contentView.addSubview(likeBtn)
        contentView.addSubview(storeNameLabel)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productPriceLabel)
    }
    
    func configLayout() {
        productImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(contentView).multipliedBy(0.7)
        }
        
        likeBtn.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(20)
            make.bottom.trailing.equalTo(productImageView).inset(15)
        }
        
        storeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(3)
            make.leading.equalTo(contentView)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(storeNameLabel.snp.bottom).offset(3)
            make.leading.equalTo(contentView)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.bottom.lessThanOrEqualTo(productPriceLabel.snp.top)
        }
        
        productPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(3)
            make.leading.equalTo(contentView)
        }
        
        
        
    }
    
    func configUI() {
        contentView.backgroundColor = Color.white
        productImageView.layer.cornerRadius = 10
        productImageView.layer.masksToBounds = true
        productImageView.image = Image.mainImage
        productImageView.backgroundColor = .gray
        
        storeNameLabel.text = "mallName"
        storeNameLabel.font = Font.semiBold13
        storeNameLabel.textColor = Color.lightGray
        
        productNameLabel.text = "title여따써라잉아랐지아아아아아아아아아아아아아두줄로 가능하게에에"
        productNameLabel.lineBreakMode = .byCharWrapping
        productNameLabel.font = Font.semiBold14
        productNameLabel.numberOfLines = 2
        
        productPriceLabel.text  = "lprice정보"
        productPriceLabel.font = Font.heavy15
    }
    
    
    
    
}
