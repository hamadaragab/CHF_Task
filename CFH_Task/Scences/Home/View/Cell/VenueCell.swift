//
//  VenueCell.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 04/03/2024.
//

import UIKit

class VenueCell: UITableViewCell {

    @IBOutlet weak var catigoryImage: UIImageView!
    @IBOutlet weak var catigory: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpCell(venue: Venues) {
        name.text = venue.name ?? ""
        catigory.text = venue.categories?.first?.name ?? ""
        location.text = venue.location?.address ?? ""
        if let iconPrefix =  venue.categories?.first?.icon?.prefix, let iconSuffix =  venue.categories?.first?.icon?.suffix {
            let iconUrl = iconPrefix.appending(iconSuffix)
            catigoryImage.setImage(from: iconUrl)
        }
    }
    
}
