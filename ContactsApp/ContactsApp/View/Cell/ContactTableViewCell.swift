//
//  ContactTableViewCell.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit
import SDWebImage

class ContactTableViewCell: UITableViewCell, ReusableInterface {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var favImgView: UIImageView!
    
    override func awakeFromNib() {
        imgView.addBorder(radius: imgView.bounds.size.width/2)
    }
    
    func updateCell(contact: ContactModel) {
        imgView.sd_setImage(with: contact.getProfilePicUrl(), placeholderImage: UIImage(named: Constants.UI.placeholderImageName))
        lblName.text = contact.fullName
        favImgView.isHidden = !contact.favorite
    }
}
