//
//  UiImageView.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 04/03/2024.
//

import Foundation
import Kingfisher

extension UIImageView {
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: imageURL,placeholder: UIImage(named: "defualtImage"),options: [.transition(ImageTransition.fade(0.5))])
    }
}
