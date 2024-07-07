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
    
    let realm = try! Realm()
    let repository = LikedItemTableRepository()
    lazy var liked = repository.fetchAlls()
    let searchBar = UISearchBar()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LikedItemCollectionViewCell.self, forCellWithReuseIdentifier:   LikedItemCollectionViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        liked  = repository.fetchAlls()
        collectionView.reloadData()
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
        let width = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: width / 3, height: width / 2)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return layout
    }
    
    @objc func likedBtnTapped(_ btn: UIButton){
        
        print(#function)
        let index = btn.tag
        let all = repository.fetchAlls()
        
        repository.deleteItem(id: all[index].id)
        print("Product deleted")
        
        collectionView.reloadData()
    }
}


extension LikedItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return liked.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikedItemCollectionViewCell.identifier, for: indexPath) as! LikedItemCollectionViewCell
        
        cell.layer.cornerRadius = 10
        
        cell.configUI(data: liked[indexPath.item])
        cell.likeBtn.addTarget(self, action: #selector(likedBtnTapped), for: .touchUpInside)
        cell.likeBtn.tag = indexPath.item
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        print(#function)
//                let vc = SearchResultWebViewViewController()
//                vc.likedDataFromPreviousPage = liked[indexPath.item].webLink
//                navigationController?.pushViewController(vc, animated: true)
//    }
    
}

extension LikedItemViewController: UISearchBarDelegate {
    
    
    
}
