//
//  SearchItemDetailVC.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit
import SnapKit

class SearchItemDetailVC: UIViewController {
    
    let numberOfResultLabel = UILabel()
    let accuracyFilterBtn = FilterBtn(btnTitle: "정확도")
    let recentDateFilterBtn = FilterBtn(btnTitle: "날짜순")
    let priceTopDownFilterBtn = FilterBtn(btnTitle: "가격높은순")
    let priceDownTopFilterBtn = FilterBtn(btnTitle: "가격낮은순")
    
    lazy var filterStackView = UIStackView()
    lazy var searchResultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: searchCollectionViewLayout())
    
    var searchWordFromPreviousPage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configHierarchy()
        configLayout()
        configUI()
        
    }
    
    
}

extension SearchItemDetailVC: ConfigureBasicSettingProtocol {
    func configHierarchy() {
        
        view.addSubview(numberOfResultLabel)
        view.addSubview(filterStackView)
        view.addSubview(searchResultCollectionView)
        
        
        let btns = [accuracyFilterBtn, recentDateFilterBtn, priceDownTopFilterBtn, priceTopDownFilterBtn]
        for i in btns {
            
            filterStackView.addArrangedSubview(i)
        }
    }
    
    func configLayout() {
        numberOfResultLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        filterStackView.snp.makeConstraints { make in
            make.top.equalTo(numberOfResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(105)
            make.height.equalTo(30)
        }
        
        searchResultCollectionView.snp.makeConstraints { make in
            make.top.equalTo(filterStackView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func configUI() {
        configureView(searchWordFromPreviousPage!)
        navigationItem.leftBarButtonItem = NavBackBtnChevron(currentVC: self)
        
        numberOfResultLabel.text = "개의 검색 결과"
        numberOfResultLabel.textColor = Color.orange
        numberOfResultLabel.font = Font.semiBold13
        
        filterStackView.axis = .horizontal
        filterStackView.spacing = 8
        filterStackView.distribution = .fillProportionally
        
        searchResultCollectionView.backgroundColor = Color.white
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.register(SearchItemDetailCollectionViewCell.self, forCellWithReuseIdentifier: SearchItemDetailCollectionViewCell.identifier)
    }
    
    
    func searchCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
    
        let sectionSpacing:CGFloat = 10
        let cellSpacing:CGFloat = 12
       
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 3)
        layout.itemSize = CGSize(width: width/2, height: width/1.25)
        layout.scrollDirection = .vertical
        
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: 100, right: sectionSpacing)
        print(#function)
        return layout
        
    }
 
}

extension SearchItemDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchResultCollectionView.dequeueReusableCell(withReuseIdentifier: SearchItemDetailCollectionViewCell.identifier, for: indexPath) as! SearchItemDetailCollectionViewCell
        cell.configUI()
        
        return cell
    }
    
    
    
}
