//
//  ProfileImageSettingVC.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit
import SnapKit

protocol ImageDelegate : AnyObject {
    func imageDataFromImageSettingpage(int:Int)
}

class ProfileImageSettingVC: UIViewController {
    
    lazy var selectedImageView = ProfileImageView(profileImageNum: imageDataFromPreviousPage , imageBorderWidth: .isSelected, imageBorderColor: .isSelected, cameraBtnMode: .isShowing)
    lazy var profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    lazy var selectedImage = UIImage()
    var imageDataFromPreviousPage:Int = 0
    var selectedIndexPath: IndexPath?
    
    weak var imageForDelegate: ImageDelegate?
    
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
        if UserDefaultManager.nickname.isEmpty == false {
            navigationItem.title = "EDIT PROFILE"
        }
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.identifier)
        let navBackBtn = UIBarButtonItem(image: Icon.chevronLeft, style: .plain, target: self, action: #selector(navBackBtnTapped))
        navigationItem.leftBarButtonItem = navBackBtn
        
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
    
    @objc func navBackBtnTapped(data: Int) {
        navigationController?.popViewController(animated: true)
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
         
        let cell = collectionView.cellForItem(at: indexPath) as! ProfileImageCollectionViewCell

        if let previousIndexPath = selectedIndexPath {
            let previousCell = collectionView.cellForItem(at: previousIndexPath) as? ProfileImageCollectionViewCell
                        previousCell?.imageView.layer.borderColor = ImageBorderColor.unSelected.value
                        previousCell?.imageView.layer.borderWidth = ImageBorderWidth.unSelected.rawValue
            previousCell?.imageView.alpha = ImageAlpha.unSelected.rawValue
        }
        
       selectedIndexPath = indexPath
        imageForDelegate?.imageDataFromImageSettingpage(int: indexPath.row)
        print("\(indexPath.row)클로저전달")
        let cell2 = collectionView.cellForItem(at: indexPath) as! ProfileImageCollectionViewCell
        cell2.imageView.layer.borderColor = ImageBorderColor.isSelected.value
        cell2.imageView.alpha = ImageAlpha.isSelected.rawValue
        cell2.imageView.layer.borderWidth = ImageBorderWidth.isSelected.rawValue
        cell2.imageView.layer.cornerRadius = cell.imageView.frame.width / 2
        cell2.imageView.clipsToBounds = true
        selectedImageView.profileImage.image = UIImage(named: "catProfile_\(indexPath.item)")
        
        
    }
    
}
