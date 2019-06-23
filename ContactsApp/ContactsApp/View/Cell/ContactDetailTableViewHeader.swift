//
//  ContactDetailTableViewHeader.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 23/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit
import SDWebImage

protocol ContactDetailTableViewHeaderDelegate: class {
    func didClickFav()
    func didClickEmail()
    func didClickMessage()
    func didClickCall()
}

class ContactDetailTableViewHeader: UITableViewCell, ReusableInterface {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var lblNameView: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    
    weak var delegate: ContactDetailTableViewHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.addBorder(radius: profileImageView.bounds.size.width/2)
    }
    
    func updateDetail(contact: ContactModel?) {
        let placeholder = UIImage(named: Constants.UI.placeholderImageName)
        profileImageView.sd_setImage(with: contact?.getProfilePicUrl(), placeholderImage: placeholder)
        lblNameView.text = contact?.fullName ?? Constants.emptyString
        
        var imageName = Constants.UI.favButtonIconName
        if contact != nil && contact!.favorite {
            imageName = Constants.UI.favButtonIconSelectedName
        }
        favButton.setImage(UIImage(named: imageName), for: .normal)
        
        emailButton.isEnabled = contact?.email != nil
        favButton.isEnabled = contact != nil
        messageButton.isEnabled = contact?.phoneNumber != nil
        callButton.isEnabled = contact?.phoneNumber != nil
    }
    
    //MARK: IBActions
    @IBAction func favClicked(_ sender: UIButton) {
        delegate?.didClickFav()
    }
    
    @IBAction func emailClicked(_ sender: UIButton) {
        delegate?.didClickEmail()
    }
    
    @IBAction func messageClicked(_ sender: UIButton) {
        delegate?.didClickMessage()
    }
    
    @IBAction func callClicked(_ sender: UIButton) {
        delegate?.didClickCall()
    }
}
