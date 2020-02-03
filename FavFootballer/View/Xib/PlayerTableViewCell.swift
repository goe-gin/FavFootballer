//
//  playerTableViewCell.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/09/05.
//  Copyright © 2019年 Tomoaki Tashiro. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseUI

class PlayerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var faceImage: UIImageView!
    @IBOutlet weak var nationName: UILabel!
    @IBOutlet weak var nationImage: UIImageView!
    @IBOutlet weak var clubName: UILabel!
    @IBOutlet weak var overallRating: UILabel!
    @IBOutlet weak var potential: UILabel!
    @IBOutlet weak var position: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(_ player: Player) {
        
        let facePlaceholder = UIImage(named: "face_placeholder.png")!
        let nationPlaceholder = UIImage(named: "nation_placeholder.png")!
        name.text = player.name
        nationName.text = player.nationName
        clubName.text = player.clubName
        overallRating.text = String(player.overallRating)
        overallRating.backgroundColor = Constant.setLabelColor(label: overallRating)
        potential.text = String(player.potential)
        potential.backgroundColor = Constant.setLabelColor(label: potential)
        position.text = player.position.joined(separator: " ")
        let faceRef = Storage.storage().reference().child(player.faceImageURL)
        faceImage.sd_setImage(with: faceRef, placeholderImage: facePlaceholder)
        let nationRef = Storage.storage().reference().child(player.nationImageURL)
        nationImage.sd_setImage(with: nationRef, placeholderImage: nationPlaceholder)
    }
    
}
