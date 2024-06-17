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
    
    let headerLabel = UILabel()
    let headerDeleteAllBtn = UIButton()
    
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
        reloadSearchView()
       
    }
    
    func reloadSearchView() {
        if UserDefaultManager.searchKeyword.count == 0 {
            listTableView.isHidden = true
            emptylistImageView.isHidden = false
            listTableView.reloadData()
        } else {
            listTableView.isHidden = false
            emptylistImageView.isHidden = true
            listTableView.reloadData()
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
            make.top.equalTo(lineView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptylistImageView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func configUI() {
        configureView("\(nickname)'s ToBuyBag")
        
        hideKeyboardWhenTappedAround()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(SearchListTableViewCell.self, forCellReuseIdentifier: SearchListTableViewCell.identifier)
        
        searchBar.delegate = self
        
        //디자인TODO: 최근 검색어가 없어요 label stackview로 추가
        emptylistImageView.image = Image.emptyImage
        emptylistImageView.contentMode = .scaleAspectFit
        
        headerLabel.text = "최근 검색"
        headerLabel.font = Font.semiBold15
        
        headerDeleteAllBtn.setTitle("전체 삭제", for: .normal)
        headerDeleteAllBtn.titleLabel?.font = Font.semiBold14
        headerDeleteAllBtn.setTitleColor(Color.orange, for: .normal)
        headerDeleteAllBtn.addTarget(self, action: #selector(deleteAllTapped), for: .touchUpInside)
    }
    
   
    
    @objc func deleteBtnTapped(_ sender: UIButton) {
        
        UserDefaultManager.searchKeyword.remove(at: sender.tag)
        reloadSearchView()
        
    }
    
    @objc func deleteAllTapped() {
        
        UserDefaultManager.searchKeyword.removeAll()
        reloadSearchView()
    }
    
}

extension SearchMainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        headerView.addSubview(headerLabel)
        headerView.addSubview(headerDeleteAllBtn)
        
        
        headerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(headerView)
            make.leading.equalTo(headerView.safeAreaLayoutGuide).inset(10)
        }
        headerDeleteAllBtn.snp.makeConstraints { make in
            make.centerY.equalTo(headerView)
            make.trailing.equalTo(headerView.safeAreaLayoutGuide).inset(10)
        }
        
        return headerView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(UserDefaultManager.searchKeyword)
        return UserDefaultManager.searchKeyword.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchListTableViewCell.identifier , for: indexPath) as! SearchListTableViewCell
        cell.configUI(searchKeywordRow: indexPath.row)
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtnTapped), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("검색 결과 vc로 이동")
        
        let vc = SearchItemDetailVC()
        vc.searchWordFromPreviousPage = UserDefaultManager.searchKeyword[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    
   
    
}

extension SearchMainVC: UISearchBarDelegate {
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text == nil {
            return false
        } else {
            return true
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        print("검색 결과 \(searchBar.text!) vc로 이동")
        UserDefaultManager.searchKeyword.insert(searchBar.text!, at: 0)
        searchBar.text = ""
        
        
        let vc = SearchItemDetailVC()
        vc.searchWordFromPreviousPage = UserDefaultManager.searchKeyword[0]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



