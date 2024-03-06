//
//  SideMenuCell.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 04/03/2024.
//

import UIKit

class SideMenuCell: UITableViewCell {
    @IBOutlet weak var sideMenuImage: UIImageView!
    @IBOutlet weak var sideMenuTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setUpCell(sideMenuItem: SideMenuModel) {
        self.sideMenuImage.image = UIImage(named: sideMenuItem.image)
        self.sideMenuTitle.text = sideMenuItem.title.rawValue
    }
    
}
