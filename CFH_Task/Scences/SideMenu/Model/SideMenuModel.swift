//
//  SideMenuModel.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 04/03/2024.
//

import Foundation
enum SideMenuItems: String {
    case Home = "Home"
    case Profile = "Profile"
    case TermsAndCondition = "Terms and condition"
    case Logout = "Logout"
}
struct SideMenuModel {
    
    let image: String
    let title: SideMenuItems
    init(image: String, title: SideMenuItems) {
        self.image = image
        self.title = title
    }
    
}

