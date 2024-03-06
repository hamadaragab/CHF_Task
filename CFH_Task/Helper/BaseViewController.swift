//
//  BaseViewController.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import Foundation
import SwiftMessages
class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func showHud(showLoding: Bool){
        if showLoding {
            self.view.isUserInteractionEnabled = false
            spinner().showAddedto(self.view)
        }else {
            self.view.isUserInteractionEnabled = true
            spinner().hideFrom(self.view)
        }
    }
    func showToast(title: String, message: String, status: Theme) {
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(status, iconStyle: .default )
        success.configureDropShadow()
        success.configureContent(title: title, body: message)
        success.button?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.duration = .seconds(seconds: 3)
        successConfig.presentationStyle = .top
        successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        SwiftMessages.show(config: successConfig, view: success)
    }
   
}
