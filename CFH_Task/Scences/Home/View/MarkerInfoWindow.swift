//
//  MarkerInfoWindow.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 05/03/2024.
//

import UIKit

class MarkerInfoWindow: UIView {
    @IBOutlet weak var catigoryImage: UIImageView!
    @IBOutlet weak var catigory: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    func setUpView(venue: Venues) {
        name.text = venue.name ?? ""
        catigory.text = venue.categories?.first?.name ?? ""
        location.text = venue.location?.address ?? ""
        if let iconPrefix =  venue.categories?.first?.icon?.prefix, let iconSuffix =  venue.categories?.first?.icon?.suffix {
            let iconUrl = iconPrefix.appending(iconSuffix)
            catigoryImage.setImage(from: iconUrl)
        }
    }
    class func createMyClassView() -> MarkerInfoWindow {
            let myClassNib = UINib(nibName: "MarkerInfoWindow", bundle: nil)
            return myClassNib.instantiate(withOwner: nil, options: nil)[0] as! MarkerInfoWindow
        }
}
