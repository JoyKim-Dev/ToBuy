//
//  SearchItemDetailVC.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit

import Alamofire
import SnapKit

enum SearchResultSortType:String {
    case accuracy = "sim"
    case recentDate = "date"
    case priceTopDown = "dsc"
    case priceDownTop = "asc"
    
    var btnTitle: String {
        switch self {
        case .accuracy:
            return "정확도"
        case .recentDate:
            return "날짜순"
        case .priceTopDown:
            return "가격높은순"
        case .priceDownTop:
            return "가격낮은순"
        }
    }
}

class SearchItemDetailVC: UIViewController {
    
    lazy var numberOfResultLabel = UILabel()
    let accuracyFilterBtn = UIButton.Configuration.filteredButton(title: SearchResultSortType.accuracy.btnTitle)
    let recentDateFilterBtn = UIButton.Configuration.filteredButton(title: SearchResultSortType.recentDate.btnTitle)
    let priceTopDownFilterBtn = UIButton.Configuration.filteredButton(title: SearchResultSortType.priceTopDown.btnTitle)
    let priceDownTopFilterBtn = UIButton.Configuration.filteredButton(title: SearchResultSortType.priceDownTop.btnTitle)
    lazy var btns = [accuracyFilterBtn, recentDateFilterBtn, priceDownTopFilterBtn, priceTopDownFilterBtn]
    lazy var filterStackView = UIStackView()
    lazy var searchResultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: searchCollectionViewLayout())
    
    var searchWordFromPreviousPage: String?
    lazy var query = searchWordFromPreviousPage
    
    var list = Product(lastBuildDate: "", total: 1, start: 1 , display: 1, items: [])
    var start = 1
    var apiSortType = SearchResultSortType.accuracy.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configHierarchy()
        configLayout()
        configUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchResultCollectionView.reloadData()
    }
}

extension SearchItemDetailVC: ConfigureBasicSettingProtocol {
    func configHierarchy() {
        
        view.addSubview(numberOfResultLabel)
        view.addSubview(filterStackView)
        view.addSubview(searchResultCollectionView)
        
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
            //  make.trailing.equalTo(view.safeAreaLayoutGuide).inset(85)
            make.height.equalTo(30)
        }
        
        searchResultCollectionView.snp.makeConstraints { make in
            make.top.equalTo(filterStackView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func configUI() {
        
        callRequest(query: String(query ?? ""))
        
        configureView(searchWordFromPreviousPage ?? "")
        navigationItem.leftBarButtonItem = NavBackBtnChevron(currentVC: self)
        
        numberOfResultLabel.textColor = Color.orange
        numberOfResultLabel.font = Font.heavy15
        
        filterStackView.axis = .horizontal
        filterStackView.spacing = 8
        filterStackView.distribution = .fillProportionally
        
        searchResultCollectionView.backgroundColor = Color.white
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.register(SearchItemDetailCollectionViewCell.self, forCellWithReuseIdentifier: SearchItemDetailCollectionViewCell.identifier)
        searchResultCollectionView.prefetchDataSource = self
        
        
        accuracyFilterBtn.addTarget(self, action: #selector(accuracyBtnTapped), for: .touchUpInside)
        recentDateFilterBtn.addTarget(self, action: #selector(recentBtnTapped), for: .touchUpInside)
        priceTopDownFilterBtn.addTarget(self, action: #selector(priceTopDownTapped), for: .touchUpInside)
        priceDownTopFilterBtn.addTarget(self, action: #selector(priceDownTopTapped), for: .touchUpInside)
        
    }
    
    func searchCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let sectionSpacing:CGFloat = 10
        let cellSpacing:CGFloat = 12
        
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 3)
        layout.itemSize = CGSize(width: width/2, height: width/1.2)
        layout.scrollDirection = .vertical
        
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: 100, right: sectionSpacing)
        return layout
        
    }
    
    func callRequest(query:String) {
        
        let url = APIURL.naverShoppingURL
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverID,
            "X-Naver-Client-Secret": APIKey.naverKey
        ]
        
        let param: Parameters = [
            "query": query,
            "display": 30,
            "start": start,
            "sort": apiSortType
        ]
        
        AF.request(url, method: .get, parameters: param, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Product.self) { response in
                print("STATUS: \(response.response?.statusCode ?? 0)")
                switch response.result {
                case .success(let value):
                    print("SUCCESS")
                    
                    self.numberOfResultLabel.text = "\(value.total.formatted())개의 검색 결과"
                    
                    if self.start == 1 {
                        
                        self.list = value
                        
                        self.searchResultCollectionView.scrollToItem(at: IndexPath(item: -1, section: 0), at: .top, animated: false)
                    } else {
                        
                        self.list.items.append(contentsOf: value.items)
                    }
                    self.searchResultCollectionView.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    @objc func likeBtnTapped(sender: UIButton) {
        let index = sender.tag
        let id = list.items[index].productId
        if UserDefaultManager.likedItemID.contains(id) {
            UserDefaultManager.likedItemID.removeAll {$0 == id}
            
        } else {
            UserDefaultManager.likedItemID.append(id)
        }
        searchResultCollectionView.reloadData()
    }
    
    @objc func accuracyBtnTapped() {
        apiSortType = SearchResultSortType.accuracy.rawValue
        
        callRequest(query: query ?? "미정")
        print(accuracyFilterBtn.isFocused)
        btns.forEach { $0.isSelected = false }
        accuracyFilterBtn.isSelected = true
    }
    
    @objc func recentBtnTapped() {
        apiSortType = SearchResultSortType.recentDate.rawValue
        callRequest(query: query ?? "미정")
        btns.forEach { $0.isSelected = false }
        recentDateFilterBtn.isSelected = true
    }
    @objc func priceTopDownTapped() {
        apiSortType = SearchResultSortType.priceTopDown.rawValue
        btns.forEach { $0.isSelected = false }
        priceTopDownFilterBtn.isSelected = true
        callRequest(query: query ?? "미정")
        
    }
    @objc func priceDownTopTapped() {
        apiSortType = SearchResultSortType.priceDownTop.rawValue
        btns.forEach { $0.isSelected = false }
        priceDownTopFilterBtn.isSelected = true
        callRequest(query: query ?? "미정")
    }
}

extension SearchItemDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchResultCollectionView.dequeueReusableCell(withReuseIdentifier: SearchItemDetailCollectionViewCell.identifier, for: indexPath) as! SearchItemDetailCollectionViewCell
        let data = list.items[indexPath.item]
        cell.configUI(data: data, indexPath: indexPath)
        cell.likeBtn.addTarget(self, action: #selector(likeBtnTapped), for: .touchUpInside)
        cell.likeBtn.tag = indexPath.item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SearchResultWebViewViewController()
        vc.searchDataFromPreviousPage = list.items[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchItemDetailVC: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for i in indexPaths {
            if list.items.count - 3 == i.item {
                start += 1
                callRequest(query: query ?? "미정")
            }
        }
    }
}
