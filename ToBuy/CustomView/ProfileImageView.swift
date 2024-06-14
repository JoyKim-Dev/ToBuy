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
    
    let image = UIImageView()
    let button = UIButton()
    var delegate: ProfileCameraBtnDelegate?
    
    init(profileImageNum: Int, imageBorderWidth: ImageBorderWidth, imageBorderColor: ImageBorderColor, imageAlpha: ImageAlpha, cameraBtnMode: ButtonHidden) {
        super.init(frame: .zero)
        
        configHierarchy()
        configLayout()
        configUI(profileImageNum: profileImageNum, imageBorderWidth: imageBorderWidth, imageBorderColor: imageBorderColor, imageAlpha: imageAlpha, cameraBtnMode: cameraBtnMode)
        
        
//        image.image = UIImage(named: "profile_\(profileImageNum)")
//        image.alpha = imageAlpha.rawValue
//        image.layer.borderWidth = imageBorderWidth.rawValue
//        image.layer.borderColor = Color.orange.cgColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        image.layer.cornerRadius = image.frame.width / 2
        image.clipsToBounds = true
        
        button.layer.cornerRadius = button.frame.width / 2
        button.clipsToBounds = true
    }
     
    func configHierarchy() {
        addSubview(image)
        addSubview(button)
    }
     
    func configLayout() {
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(30)
        }
        
        button.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.bottom.equalTo(image.snp.bottom).inset(5)
            make.trailing.equalTo(image.snp.trailing).inset(5)
        }
    }
    
    func configUI(profileImageNum: Int, imageBorderWidth: ImageBorderWidth, imageBorderColor: ImageBorderColor, imageAlpha: ImageAlpha, cameraBtnMode: ButtonHidden) {
        image.image = UIImage(named: "profile_\(profileImageNum)")
        image.alpha = imageAlpha.rawValue
        image.layer.borderWidth = imageBorderWidth.rawValue
        image.layer.borderColor = imageBorderColor.value
        
        button.setImage(Icon.cameraFill, for: .normal)
        button.tintColor = Color.white
        button.backgroundColor = Color.orange
        button.isHidden = cameraBtnMode.value
        button.addTarget(self, action: #selector(cameraBtnTapped), for: .touchUpInside)
    }
    
    @objc func cameraBtnTapped() {
        delegate?.cameraButtonTapped()
        
    }
}
