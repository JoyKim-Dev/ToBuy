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
    
    let backBarBtn = NavBackBtnChevron()
    
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
        navigationItem.leftBarButtonItem = backBarBtn
        backBarBtn.action = #selector(backBarBtnTapped)
        
        
    }
    
    @objc func backBarBtnTapped() {
        print("Back button tapped")
        navigationController?.popViewController(animated: true)
        
        
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        // 아이폰 마다 디바이스 너비가 달라서 itemsize 계산 필요 : (0-40) / 3 으로 비율적으로 넣어줘야 함.
        // 여기서 -40은 가로 셀 개수 * interimspacing + section inset(right + left)
        // 각 spacing을 상수로 선언해서 활용하면 좋음
        let sectionSpacing:CGFloat = 2
        let cellSpacing:CGFloat = 2
        // section inset은 늘 2개이고 (양 옆), interimspacing은 내가 만들 행의 셀 갯수 -1이니 이걸 활용한 식을 넣는 것이 좋음. 그러면 유지관리쉬움. 값을 바꿔도 바로바로 반영이 되니까.
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 3)
        layout.itemSize = CGSize(width: width/5, height: width/5)
        layout.scrollDirection = .vertical
        // equal 값이 아니라 minimum 값이기 때문에 다른 설정 상태에 따라 spacing 더 크게 보여질 수도 있음.
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
        UserDefaultManager.profileImage = indexPath.item
        cell.imageView.layer.borderColor = ImageBorderColor.isSelected.value
        cell.imageView.profileImage.alpha = ImageAlpha.isSelected.rawValue
        cell.imageView.layer.borderWidth = ImageBorderWidth.isSelected.rawValue
        cell.imageView.layer.cornerRadius = cell.imageView.frame.width / 2
        cell.imageView.clipsToBounds = true
        selectedImageView.profileImage.image = UIImage(named: "profile_\(indexPath.item)")
    }
    
}
