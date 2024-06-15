//
//  ProfileImageCollectionViewCell.swift
//  ToBuy
//
//  Created by Joy Kim on 6/15/24.
//

import UIKit
import SnapKit

class ProfileImageCollectionViewCell: UICollectionViewCell {
    
    
    var imageView = ProfileImageView(profileImageNum: 2, imageBorderWidth: .unSelected, imageBorderColor: .unSelected, imageAlpha: .unSelected, cameraBtnMode: .isHidden)
  
   
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configHierarchy()
        configLayout()
        configUI()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    
}

extension ProfileImageCollectionViewCell: ConfigureBasicSettingProtocol {
    func configHierarchy() {
        contentView.addSubview(imageView)
    }
    
    func configLayout() {
        imageView.snp.makeConstraints { make in
            make.height.equalTo(contentView)
            make.width.equalTo(contentView)
    
        }
    }

    func configUI() {
        
      
        
    }
    
    func configImageUI(data: Int, isSeleced: Bool) {
        imageView.profileImage.image = UIImage(named: "profile_\(data)")
        
    }
  
    }


