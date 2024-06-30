//
//  ImageResource.swift
//  ToBuy
//
//  Created by Joy Kim on 6/30/24.
//

import UIKit

enum Icon {
    static let search = UIImage(systemName: "magnifyingglass")
    static let person = UIImage(systemName: "person")
    static let clock = UIImage(systemName: "clock")
    static let chevronRight = UIImage(systemName: "chevron.right")
    static let chevronLeft = UIImage(systemName: "chevron.left")
    static let xMark = UIImage(systemName: "xmark")
    static let cameraFill = UIImage(systemName: "camera.fill")
    static let likeSelected = UIImage(named: "like_selected")!.withRenderingMode(.alwaysOriginal)
    static let likeUnSelected = UIImage(named: "like_unselected")!.withRenderingMode(.alwaysOriginal)
}

enum Image {
    static let mainImage = UIImage(named: "toBuyMainIcon")
    static let emptyImage = UIImage(named: "emptyBag")
}
