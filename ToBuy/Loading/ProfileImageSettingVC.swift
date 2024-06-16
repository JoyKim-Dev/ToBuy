//
//  ProfileImageSettingVC.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit
import SnapKit

class ProfileImageSettingVC: UIViewController {
    
    lazy var selectedImageView = ProfileImageView(profileImageNum: imageDataFromPreviousPage , imageBorderWidth: .isSelected, imageBorderColor: .isSelected, imageAlpha: .isSelected, cameraBtnMode: .isShowing)
    lazy var profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
 
    var imageDataFromPreviousPage:Int = 0
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configHierarchy()
        configLayout()
        configUI()
        
    }
    
}

extension ProfileImageSettingVC: ConfigureBasicSettingProtocol {
    func configHierarchy() {
        view.addSubview(selectedImageView)
        view.addSubview(profileCollectionView)
    }
    
    func configLayout() {
        selectedImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.width.equalTo(125)
        }
        
        profileCollectionView.snp.makeConstraints { make in
            make.top.equalTo(selectedImageView.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func configUI() {
        
        
        configureView("PROFILE SETTING")
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.identifier)
        navigationItem.leftBarButtonItem = NavBackBtnChevron(currentVC: self)
        
        
    }
    
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()

        let sectionSpacing:CGFloat = 2
        let cellSpacing:CGFloat = 2

        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 3)
        layout.itemSize = CGSize(width: width/5, height: width/5)
        layout.scrollDirection = .vertical

        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        print(#function)
        return layout
        
    }
    
}

extension ProfileImageSettingVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = profileCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.identifier, for: indexPath) as! ProfileImageCollectionViewCell
        let data = indexPath.item
        let cellIsSelected = indexPath == selectedIndexPath
        cell.configImageUI(data: data, isSeleced: cellIsSelected)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let previousIndexPath = selectedIndexPath {
            
            let previousCell = collectionView.cellForItem(at: previousIndexPath) as? ProfileImageCollectionViewCell
            previousCell?.imageView.layer.borderColor = ImageBorderColor.unSelected.value
            previousCell?.imageView.alpha = ImageAlpha.isSelected.rawValue
            previousCell?.imageView.layer.borderWidth = ImageBorderWidth.unSelected.rawValue
        }
        
       
        selectedIndexPath = indexPath
        let cell = collectionView.cellForItem(at: indexPath) as! ProfileImageCollectionViewCell
        UserDefaultManager.profileImage.removeAll()
        UserDefaultManager.profileImage.insert(indexPath.item, at: 0)
        print(UserDefaultManager.profileImage[0])
        cell.imageView.layer.borderColor = ImageBorderColor.isSelected.value
        cell.imageView.profileImage.alpha = ImageAlpha.isSelected.rawValue
        cell.imageView.layer.borderWidth = ImageBorderWidth.isSelected.rawValue
        cell.imageView.layer.cornerRadius = cell.imageView.frame.width / 2
        cell.imageView.clipsToBounds = true
        selectedImageView.profileImage.image = UIImage(named: "profile_\(indexPath.item)")
    }
    
}
