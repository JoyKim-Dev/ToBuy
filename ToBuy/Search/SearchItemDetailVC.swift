//
//  SearchItemDetailVC.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit
import SnapKit
import Alamofire

class SearchItemDetailVC: UIViewController {
    
    lazy var numberOfResultLabel = UILabel()
    let accuracyFilterBtn = FilterBtn(btnTitle: "정확도")
    let recentDateFilterBtn = FilterBtn(btnTitle: "날짜순")
    let priceTopDownFilterBtn = FilterBtn(btnTitle: "가격높은순")
    let priceDownTopFilterBtn = FilterBtn(btnTitle: "가격낮은순")
    
    lazy var filterStackView = UIStackView()
    lazy var searchResultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: searchCollectionViewLayout())
    
    var searchWordFromPreviousPage: String?
    
    var list = Product(lastBuildDate: "", total: 1, start: 1 , display: 1, items: [])
    var start = 1
    var apiSortType = "sim"
    
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
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(95)
            make.height.equalTo(30)
        }
        
        searchResultCollectionView.snp.makeConstraints { make in
            make.top.equalTo(filterStackView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func configUI() {
        
        callRequest(query: String(searchWordFromPreviousPage!))
        print(searchWordFromPreviousPage!)
        
        configureView(searchWordFromPreviousPage!)
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
        print(#function)
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
            "start": 1,
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
 
}

extension SearchItemDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("셀갯수: \(list.items.count)")
        return list.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchResultCollectionView.dequeueReusableCell(withReuseIdentifier: SearchItemDetailCollectionViewCell.identifier, for: indexPath) as! SearchItemDetailCollectionViewCell
        let data = list.items[indexPath.item]
        cell.configUI(data: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SearchResultWebViewViewController()
        vc.searchWordFromPreviousPage = list.items[indexPath.item].title
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

extension SearchItemDetailVC: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for i in indexPaths {
            if list.items.count - 3 == i.item {
                start += 1
                print("현재페이지 \(start)")
                callRequest(query: searchWordFromPreviousPage!)
                
            }
        }
        
    }
    
    
}
