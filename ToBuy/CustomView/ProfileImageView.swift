//
//  ProfileImageView.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit
import SnapKit

enum ButtonHidden: String {
    case isHidden
    case isShowing
    
    var value: Bool {
        switch self {
        case .isHidden: 
            return true
        case.isShowing:
            return false
        }
    }
}
   
class ProfileImageView: UIView {
    
    var profileImage = UIImageView()
    let profileButton = UIButton()
    
    init(profileImageNum: Int, imageBorderWidth: ImageBorderWidth, imageBorderColor: ImageBorderColor, cameraBtnMode: ButtonHidden) {
        super.init(frame: .zero)
        
        configHierarchy()
        configLayout()
        configUI(profileImageNum: profileImageNum, imageBorderWidth: imageBorderWidth, imageBorderColor: imageBorderColor, cameraBtnMode: cameraBtnMode)
        
        
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
    
    func configUI(profileImageNum: Int, imageBorderWidth: ImageBorderWidth, imageBorderColor: ImageBorderColor, cameraBtnMode: ButtonHidden) {
        profileImage.image = UIImage(named: "catProfile_\(profileImageNum)")
        profileImage.layer.borderWidth = imageBorderWidth.rawValue
        profileImage.layer.borderColor = imageBorderColor.value
    
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
}

