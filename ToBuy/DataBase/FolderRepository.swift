//
//  FolderRepository.swift
//  ToBuy
//
//  Created by Joy Kim on 7/8/24.
//

import Foundation
import RealmSwift

final class FolderRepository {
    
    let realm = try! Realm()
 
    // 특정 폴더의 디테일에 레코드(테이블) 추가
    func createItem(_ data: LikedItemTable, folder: Folder) {
        do {
            try realm.write {
                folder.detail.append(data)
                realm.add(data)
                print("Realm save succeed")}
        } catch {
            print("catch error")
        }
    }
    
    // 폴더 레코드 생성
    func createFolder(_ data: Folder) {
        do {
            try realm.write {
                realm.add(data)
                print("Realm save succeed")
            }
        } catch {
            print("catch error")
        }
    }
    
    func detectRealmURL() {
        print(realm.configuration.fileURL ?? "")
    }
    
    func fetchFolder() -> Results<Folder> {
        let value = realm.objects(Folder.self)
        return value
    }
    
    func fetchAlls() -> Results<Folder> {
        return realm.objects(Folder.self).sorted(byKeyPath: "brandName", ascending: true)
    }
    
    func removeFolder(_ folder: Folder) {
        do{
            try realm.write {
                realm.delete(folder.detail)
                realm.delete(folder)
                print("Realm remove succeed")
            }
        } catch {
            print("Folder remove failed")
        }
    }
}

