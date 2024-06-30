//
//  ProfileImageView.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit
import SnapKit

enum ProfileImageStyle {
    case isSelected
    case unSelected

    var borderColor: CGColor {
        switch self {
        case .isSelected:
            return Color.orange.cgColor
        case .unSelected:
            return Color.unselectedGray.cgColor
        }
    }
    var alpha: CGFloat {
        switch self {
        case .isSelected:
            return 1.0
        case .unSelected:
            return 0.5
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .isSelected:
            return 3.0
        case .unSelected:
            return 1.0
        }
    }
    
    func configProfileImageUI(to imageView: UIImageView) {
        imageView.layer.borderColor = self.borderColor
        imageView.alpha = self.alpha
        imageView.layer.borderWidth = self.borderWidth
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
    }
}


class ProfileImageView: UIView {
    
    var profileImage = UIImageView()
    let profileButton = UIButton()
    
    init(profileImageNum: Int,cameraBtnMode: ButtonHidden, isSelected: Bool) {
        super.init(frame: .zero)
        
        configHierarchy()
        configLayout()
        configUI(profileImageNum: profileImageNum,cameraBtnMode: cameraBtnMode, isSelected:isSelected)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeRectToCircle()
    }
     
    func configHierarchy() {
        addSubview(profileImage)
        addSubview(profileButton)
    }
     
    func configLayout() {
        profileImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        profileButton.snp.makeConstraints { make in
            make.width.height.equalTo(profileImage).multipliedBy(0.25)
            make.bottom.equalTo(profileImage.snp.bottom).inset(5)
            make.trailing.equalTo(profileImage.snp.trailing).inset(5)
        }
    }
    
    func configUI(profileImageNum: Int, cameraBtnMode: ButtonHidden, isSelected: Bool) {
        changeImage(profileNum: profileImageNum)
        activationCheck(profileIsSelected: isSelected)
  
        profileButton.setImage(Icon.cameraFill, for: .normal)
        profileButton.tintColor = Color.white
        profileButton.backgroundColor = Color.orange
        profileButton.isHidden = cameraBtnMode.value
    }
    
    func makeRectToCircle() {
           profileImage.layer.cornerRadius = profileImage.frame.width / 2
           profileImage.clipsToBounds = true
           
           profileButton.layer.cornerRadius = profileButton.frame.width / 2
           profileButton.clipsToBounds = true
       }
    
    func changeImage(profileNum: Int) {
        profileImage.image = UIImage(named: "catProfile_\(profileNum)")
    }
    
    func activationCheck(profileIsSelected: Bool) {
        if profileIsSelected {
            ProfileImageStyle.isSelected.configProfileImageUI(to: self.profileImage)
        }
        else {
            ProfileImageStyle.unSelected.configProfileImageUI(to: self.profileImage)
        }
    }
}

