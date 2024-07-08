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
    let folderRepository = FolderRepository()
    lazy var liked = repository.fetchAlls()
    lazy var list = folderRepository.fetchFolder()
    var segmentIndex = 0
    
    let calendar = {
        let view = FSCalendar()
        view.isHidden = true
        return view
    }()

    let segment = {
        let control = UISegmentedControl(items: ["상품", "브랜드", "물욕달력"])
        control.selectedSegmentIndex = 0
        return control
    }()
    
    let searchBar = UISearchBar()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    let tableView = UITableView() 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LikedItemCollectionViewCell.self, forCellWithReuseIdentifier:   LikedItemCollectionViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(likedVCBrandTableViewCell.self, forCellReuseIdentifier: likedVCBrandTableViewCell.identifier)
        
        searchBar.delegate = self
        
        list = folderRepository.fetchFolder()
        print(repository.detectRealmURL())

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        liked  = repository.fetchAlls()
        list = folderRepository.fetchFolder()
        collectionView.reloadData()
        tableView.reloadData()
        configView()
        
        
    }
    override func configHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(tableView)
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
        
        tableView.snp.makeConstraints { make in
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
        tableView.rowHeight = 300
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
        print(#function)
     
        let selectedIndex = segment.selectedSegmentIndex
        print(selectedIndex)
        switch selectedIndex {
           case 0:
               segmentIndex = 0
               calendar.isHidden = true
               tableView.isHidden = true
                collectionView.isHidden = false
                collectionView.reloadData()
           case 1:
               segmentIndex = 1
               calendar.isHidden = true
               collectionView.isHidden = false
               tableView.isHidden = false
            tableView.reloadData()
           case 2:
               segmentIndex = 2
                collectionView.isHidden = true
               tableView.isHidden = true
               calendar.isHidden = false
           default:
               break
           }
        viewWillAppear(true)
    }
    
    @objc func likedBtnTapped(_ btn: UIButton){
        
        print(#function)
        let index = btn.tag
        let all = repository.fetchAlls()
        let folder = all[index].main.first
        guard let folder = folder else {return}
        
        if folder.detail.count == 1 {
            folderRepository.removeFolder(folder)
        } else if folder.detail.count > 1 {
            repository.deleteItem(id: all[index].id)
            print("Product deleted")
        }
        viewWillAppear(true)
        configView()
    }
}

extension LikedItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(list)
        return list.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: likedVCBrandTableViewCell.identifier, for: indexPath) as! likedVCBrandTableViewCell
        
        cell.configUI(data: list[indexPath.row])
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(LikedItemCollectionViewCell.self, forCellWithReuseIdentifier: LikedItemCollectionViewCell.identifier)
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        
        return cell
    }

}
extension LikedItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return liked.count
        } else {
            return list[collectionView.tag].detail.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikedItemCollectionViewCell.identifier, for: indexPath) as! LikedItemCollectionViewCell
        
        cell.layer.cornerRadius = 10
        cell.likeBtn.addTarget(self, action: #selector(likedBtnTapped), for: .touchUpInside)
        cell.likeBtn.tag = indexPath.item
        
        if collectionView == self.collectionView {
            cell.configUI(data: liked[indexPath.item])
        
            return cell
        } else {
            cell.configUI(data: list[collectionView.tag].detail[indexPath.item])
            return cell
        }
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
        let folderFilter = realm.objects(Folder.self).where {
            $0.detail.title.contains(searchText, options: .caseInsensitive)
        }
        liked = filter
        list = folderFilter
        
        collectionView.reloadData()
        tableView.reloadData()
        
    }

}
