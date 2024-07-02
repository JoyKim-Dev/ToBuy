//
//  SearchMainVC.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit
import SnapKit


final class SearchMainVC: UIViewController {
    
    private let searchBar = SearchBar()
    private let lineView = LineView()
    private let listTableView = UITableView()
    private let emptylistImageView = UIImageView()
    
    private let headerLabel = UILabel()
    private let noSearchWorldLabel = UILabel()
    private let headerDeleteAllBtn = UIButton()
    
    private var nickname = UserDefaultManager.nickname
   
    
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
    
    private func reloadSearchView() {
        if UserDefaultManager.searchKeyword.count == 0 {
            listTableView.isHidden = true
            emptylistImageView.isHidden = false
            noSearchWorldLabel.isHidden = false
            listTableView.reloadData()
        } else {
            listTableView.isHidden = false
            emptylistImageView.isHidden = true
            noSearchWorldLabel.isHidden = true
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
        view.addSubview(noSearchWorldLabel)
        
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
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        noSearchWorldLabel.snp.makeConstraints { make in
            make.top.equalTo(emptylistImageView.snp.bottom).inset(100)
            make.centerX.equalTo(view)
        }
    }
    
    func configUI() {
        configureView("\(nickname)'s ToBuyBag")
        emptylistImageView.contentMode = .scaleAspectFill
        
        hideKeyboardWhenTappedAround()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(SearchListTableViewCell.self, forCellReuseIdentifier: SearchListTableViewCell.identifier)
        
        searchBar.delegate = self
        
        noSearchWorldLabel.text = "최근 검색어가 없어요 🥹 \n원하시는 상품을 검색해보세요"
        noSearchWorldLabel.font = Font.heavy20
        noSearchWorldLabel.textColor = Color.black
        noSearchWorldLabel.numberOfLines = 0
        noSearchWorldLabel.textAlignment = .center
        
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
        return UserDefaultManager.searchKeyword.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchListTableViewCell.identifier , for: indexPath) as! SearchListTableViewCell
        cell.configUI(searchKeywordRow: indexPath.row)
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtnTapped), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

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
     
        let trimmedText = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            
            if !trimmedText.isEmpty {
                UserDefaultManager.searchKeyword.insert(searchBar.text!, at: 0)
                searchBar.text = ""
                
                let vc = SearchItemDetailVC()
                vc.searchWordFromPreviousPage = UserDefaultManager.searchKeyword[0]
                
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let alert = UIAlertController(title: "검색어 오류", message: "검색어를 입력해 주세요.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }

    }

}



