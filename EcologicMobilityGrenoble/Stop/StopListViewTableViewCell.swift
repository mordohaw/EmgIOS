//
//  StopListViewTableViewCell.swift
//  EcologicMobilityGrenoble
//
//  Created by Xamarin on 15/01/2018.
//  Copyright © 2018 iut. All rights reserved.
//

import UIKit

class StopListViewTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var lines: UILabel!
    @IBOutlet weak var latitude: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
