//
//  AddContactTableViewHeader.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 23/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit

protocol AddContactTableViewHeaderDelegate: class {
    func didClickCameraButton()
}

class AddContactTableViewHeader: UITableViewCell, ReusableInterface {

    @IBOutlet weak var profileImageView: UIImageView!
    weak var delegate: AddContactTableViewHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.addBorder(radius: profileImageView.bounds.size.width/2)
    }
    
    func updateProfilePic(url: URL?) {
        let placeholder = UIImage(named: Constants.UI.placeholderImageName)
        profileImageView.sd_setImage(with: url, placeholderImage: placeholder)
    }
    
    func updateProfilePic(image: UIImage) {
        profileImageView.image = image
    }
    
    //MARK: IBActions
    @IBAction func cameraClicked(_ sender: UIButton) {
        delegate?.didClickCameraButton()
    }
}
