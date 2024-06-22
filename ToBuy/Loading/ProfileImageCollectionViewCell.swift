//
//  ProfileImageCollectionViewCell.swift
//  ToBuy
//
//  Created by Joy Kim on 6/15/24.
//

import UIKit
import SnapKit

class ProfileImageCollectionViewCell: UICollectionViewCell {
    
    var imageView = ProfileImageView(profileImageNum: 2, cameraBtnMode: .isHidden, isSelected: false)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configHierarchy()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileImageCollectionViewCell {
    func configHierarchy() {
        contentView.addSubview(imageView)
    }
    
    func configLayout() {
        imageView.snp.makeConstraints { make in
            make.height.equalTo(contentView)
            make.width.equalTo(contentView)
        }
    }
    
    func configUI(data: Int) {
        imageView.tag = data
        imageView.changeImage(profileNum: data)

    }
}


