//
//  LikedItemViewController.swift
//  ToBuy
//
//  Created by Joy Kim on 7/7/24.
//

import UIKit

import RealmSwift
import SnapKit

final class LikedItemViewController: BaseViewController {
    
    let searchBar = UISearchBar()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LikedItemCollectionViewCell.self, forCellWithReuseIdentifier:   LikedItemCollectionViewCell.identifier)
    }
    
    override func configHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    override func configLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configView() {
        navigationItem.title = "찜 목록"
    }
}

extension LikedItemViewController {
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        // 전체 화면 너비 - 셀 사이 간격 = 각 셀 너비 * 각 행 셀 갯수 -> itemsize 활용
        let width = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: width / 3, height: width / 2)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return layout
    }
    }


extension LikedItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Realm.filter.좋아요.true.count
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikedItemCollectionViewCell.identifier, for: indexPath) as! LikedItemCollectionViewCell
        
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .orange
        
        return cell
    }
    
    
    
}
