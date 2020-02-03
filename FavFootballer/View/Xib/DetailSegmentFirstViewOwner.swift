//
//  DetailSegmentFirstViewOwner.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/11/24.
//  Copyright © 2019 Tomoaki Tashiro. All rights reserved.
//

import UIKit

class DetailSegmentFirstViewOwner: NSObject {
    

    @IBOutlet weak var ballControl: UILabel!
    @IBOutlet weak var crossing: UILabel!
    @IBOutlet weak var curve: UILabel!
    @IBOutlet weak var marking: UILabel!
    @IBOutlet weak var dribbling: UILabel!
    @IBOutlet weak var fkAccuracy: UILabel!
    @IBOutlet weak var finishing: UILabel!
    @IBOutlet weak var headingAccuracy: UILabel!
    
    var detailSegmentFirstView: UIView!
    
    override init() {
        super.init()
        detailSegmentFirstView = UINib(nibName: "DetailSegmentFirstView", bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as? UIView
    }

    func setLabel(_ player: Player) {

        ballControl.text = String(player.ballControl)
        ballControl.backgroundColor = Constant.setLabelColor(label: ballControl)
        crossing.text = String(player.crossing)
        crossing.backgroundColor = Constant.setLabelColor(label: crossing)
        curve.text = String(player.curve)
        curve.backgroundColor = Constant.setLabelColor(label: curve)
        marking.text = String(player.marking)
        marking.backgroundColor = Constant.setLabelColor(label: marking)
        dribbling.text = String(player.dribbling)
        dribbling.backgroundColor = Constant.setLabelColor(label: dribbling)
        fkAccuracy.text = String(player.fkAccuracy)
        fkAccuracy.backgroundColor = Constant.setLabelColor(label: fkAccuracy)
        finishing.text = String(player.finishing)
        finishing.backgroundColor = Constant.setLabelColor(label: finishing)
        headingAccuracy.text = String(player.headingAccuracy)
        headingAccuracy.backgroundColor = Constant.setLabelColor(label: headingAccuracy)
    }

}
