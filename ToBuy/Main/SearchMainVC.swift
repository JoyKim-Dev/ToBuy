//
//  SearchMainVC.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit
import SnapKit

class SearchMainVC: UIViewController {
    
    let searchBar = SearchBar()
    let lineView = LineView()
    let listTableView = UITableView()
    let emptylistImageView = UIImageView()
    
    var nickname = UserDefaultManager.nickname
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configHierarchy()
        configLayout()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nickname = UserDefaultManager.nickname
        navigationItem.title = "\(nickname)'s ToBuyBag"
        
        if UserDefaultManager.searchKeyword.count == 0 {
            listTableView.isHidden = true
            emptylistImageView.isHidden = false
        } else {
            listTableView.isHidden = false
            emptylistImageView.isHidden = true
            
        }
    }
    
}

extension SearchMainVC: ConfigureBasicSettingProtocol {
    func configHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(lineView)
        view.addSubview(listTableView)
        view.addSubview(emptylistImageView)
        
    }
    
    func configLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptylistImageView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configUI() {
        configureView("\(nickname)'s ToBuyBag")
        
        listTableView.backgroundColor = .red
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(SearchListTableViewCell.self, forCellReuseIdentifier: SearchListTableViewCell.identifier)
        
        //디자인TODO: 최근 검색어가 없어요 label stackview로 추가
        emptylistImageView.image = Image.emptyImage
        emptylistImageView.contentMode = .scaleAspectFit
        
        
    }
    
}

extension SearchMainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(UserDefaultManager.searchKeyword)
        return UserDefaultManager.searchKeyword.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchListTableViewCell.identifier , for: indexPath)
        
        return cell
    }
    
    
    
}



