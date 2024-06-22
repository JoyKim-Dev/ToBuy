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
    
    lazy var selectedImageView = ProfileImageView(profileImageNum: imageDataFromPreviousPage , cameraBtnMode: .isShowing, isSelected: true)
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
        cell.configUI(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImageView.changeImage(profileNum: indexPath.item)
        imageForDelegate?.imageDataFromImageSettingpage(int: indexPath.item)
        
        for i in 0..<collectionView.numberOfItems(inSection: 0) {
            if let cell = collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as? ProfileImageCollectionViewCell {
                ProfileImageStyle.unSelected.configProfileImageUI(to: cell.imageView.profileImage)
             
            }
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? ProfileImageCollectionViewCell {
            ProfileImageStyle.isSelected.configProfileImageUI(to: cell.imageView.profileImage)
        }
    }
}
