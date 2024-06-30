//
//  NetworkManager.swift
//  ToBuy
//
//  Created by Joy Kim on 6/30/24.
//

import Foundation

enum ShoppingNetworkError: Error {
case failedRequest
case noData
case invalidResponse
case invalidData
}

typealias NaverShoppingHander = (Product?, ShoppingNetworkError?) -> Void

class ShoppingNaverManager {
    
    static let shared = ShoppingNaverManager()
    private init() {}
    
    func callRequest(query: String, start: Int, apiSortType: String, completionHandler: @escaping NaverShoppingHander) {
        print(#function, Thread.isMainThread)
        
        guard let url = URL(string: APIURL.naverShoppingURL) else {return}
        //https://openapi.naver.com/v1/search/shop.json
        var component = URLComponents()
        component.scheme = "https"
        component.host = "openapi.naver.com"
        component.path = "/v1/search/shop.json"
        component.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "display", value: String(30)),
            URLQueryItem(name: "start", value: String(start)),
            URLQueryItem(name: "sort", value: apiSortType)
        ]
        
        guard let url = component.url else {return}
            
            var request = URLRequest(url: url)
            print(#function, Thread.isMainThread)
            print(request)
        
        request.setValue(APIKey.naverID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue(APIKey.naverKey, forHTTPHeaderField: "X-Naver-Client-Secret" )
        
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                DispatchQueue.main.async {
                    guard error == nil else {
                        print("Failed Request")
                        completionHandler(nil, .failedRequest)
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse
                    else {
                        print("Unable Response")
                        completionHandler(nil, .invalidResponse)
                        return
                    }
                    
                    guard response.statusCode == 200 else {
                        print("failed Response")
                        completionHandler(nil, .failedRequest)
                        return
                    }
                    
                    guard let data = data else {
                        print("No Data Returned")
                        completionHandler(nil, .noData)
                        return
                    }
                    
                    print("이제 식판에 담으면 됨")
                    
                    do {
                        let result = try JSONDecoder().decode(Product.self, from: data)
                        print("success")
                        print(result)
                        completionHandler(result, nil)
                    } catch {
                        print("error")
                        print(error)
                    }
                }
            }.resume()
        }
    }

    
    
    
    //let url = APIURL.naverShoppingURL
    //
    //let header: HTTPHeaders = [
    //    "X-Naver-Client-Id": APIKey.naverID,
    //    "X-Naver-Client-Secret": APIKey.naverKey
    //]
    //
    //let param: Parameters = [
    //    "query": query,
    //    "display": 30,
    //    "start": start,
    //    "sort": apiSortType
    //]
    //
    //AF.request(url, method: .get, parameters: param, headers: header)
    //    .validate(statusCode: 200..<300)
    //    .responseDecodable(of: Product.self) { response in
    //        print("STATUS: \(response.response?.statusCode ?? 0)")
    //        switch response.result {
    //        case .success(let value):
    //            print("SUCCESS")
    //
    //            self.numberOfResultLabel.text = "\(value.total.formatted())개의 검색 결과"
    //
    //            if self.start == 1 {
    //
    //                self.list = value
    //
    //                self.searchResultCollectionView.scrollToItem(at: IndexPath(item: -1, section: 0), at: .top, animated: false)
    //            } else {
    //
    //                self.list.items.append(contentsOf: value.items)
    //            }
    //            self.searchResultCollectionView.reloadData()
    //
    //        case .failure(let error):
    //            print(error)
    //            let alert = UIAlertController(
    //                title: "네트워크 에러",
    //                message: "인터넷 통신에 실패했습니다. 인터넷 연결을 확인한 후 다시 시도해주세요.",
    //                preferredStyle: .alert)
    //            let ok = UIAlertAction(title: "확인", style: .default)
    //            alert.addAction(ok)
    //            self.present(alert, animated: true)
    //        }
    //    }
