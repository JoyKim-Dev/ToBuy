//
//  LikedItemViewController.swift
//  ToBuy
//
//  Created by Joy Kim on 7/7/24.
//

import UIKit

import RealmSwift
import SnapKit
import FSCalendar

final class LikedItemViewController: BaseViewController {
    
    let realm = try! Realm()
    let repository = LikedItemTableRepository()
    lazy var liked = repository.fetchAlls()
    var list: [Folder] = []
    
    let calendar = {
        let view = FSCalendar()
        view.isHidden = true
        return view
    }()

    let segment = {
        let control = UISegmentedControl(items: ["상품", "브랜드", "물욕달력"])
        return control
    }()
    
    let searchBar = UISearchBar()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LikedItemCollectionViewCell.self, forCellWithReuseIdentifier:   LikedItemCollectionViewCell.identifier)
        searchBar.delegate = self
        
        list = repository.fetchFolder()
        print(repository.detectRealmURL())
        print(list)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        liked  = repository.fetchAlls()
        collectionView.reloadData()
        configView()
    }
    override func configHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(segment)
        view.addSubview(calendar)
    }
    
    override func configLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(40)
        }
        
        segment.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segment.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(segment.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(calendar.snp.width).multipliedBy(1.3)
        }
  
    }
    
    override func configView() {
        navigationItem.title = "찜 \(liked.count)개 목록"
        hideKeyboardWhenTappedAround()
        segment.addTarget(self, action: #selector(segmentChanged(segment:)), for: .valueChanged)
        
        
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
    
    @objc func segmentChanged(segment: UISegmentedControl) {
        
        let selectedIndex = segment.selectedSegmentIndex
        calendar.isHidden = selectedIndex == 0 || selectedIndex == 1
        collectionView.isHidden = selectedIndex == 2
    }
    
    @objc func likedBtnTapped(_ btn: UIButton){
        
        print(#function)
        let index = btn.tag
        let all = repository.fetchAlls()
        
        repository.deleteItem(id: all[index].id)
        print("Product deleted")
        
        viewWillAppear(true)
        configView()
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filter = realm.objects(LikedItemTable.self).where { $0.title.contains(searchText, options: .caseInsensitive) }
        
        liked = filter
        collectionView.reloadData()
        
    }
    
    
}
