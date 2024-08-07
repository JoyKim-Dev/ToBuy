//
//  LikedItemTableRepository.swift
//  ToBuy
//
//  Created by Joy Kim on 7/7/24.
//

import Foundation
import RealmSwift

final class LikedItemTableRepository {
    
    let realm = try! Realm()
    
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
    
    func fetchFolder() -> [Folder] {
        let value = realm.objects(Folder.self)
        return Array(value)
    }
    
    func fetchAlls() -> Results<LikedItemTable> {
        return realm.objects(LikedItemTable.self).sorted(byKeyPath: "title", ascending: true)
    }
    
    func deleteItem(id: String) {
        do {
                    if let item = realm.object(ofType: LikedItemTable.self, forPrimaryKey: id) {
                        try realm.write {
                            realm.delete(item)
                            print("Realm delete succeed")
                        }
                    } else {
                        print("Item not found in Realm")
                    }
                } catch {
                    print("catch error: \(error.localizedDescription)")
                }
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
