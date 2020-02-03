//
//  DetailSegmentSecondViewOwner.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/11/26.
//  Copyright © 2019 Tomoaki Tashiro. All rights reserved.
//

import UIKit

class DetailSegmentSecondViewOwner: NSObject {
    
    @IBOutlet weak var longPassing: UILabel!
    @IBOutlet weak var longShots: UILabel!
    @IBOutlet weak var penalties: UILabel!
    @IBOutlet weak var shortPassing: UILabel!
    @IBOutlet weak var shotPower: UILabel!
    @IBOutlet weak var slidingTackle: UILabel!
    @IBOutlet weak var standingTackle: UILabel!
    @IBOutlet weak var volleys: UILabel!

    var detailSegmentSecondView: UIView!
    
    override init() {
        super.init()
        detailSegmentSecondView = UINib(nibName: "DetailSegmentSecondView", bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as? UIView
    }

    func setLabel(_ player: Player) {

        longPassing.text = String(player.longPassing)
        longPassing.backgroundColor = Constant.setLabelColor(label: longPassing)
        longShots.text = String(player.longShots)
        longShots.backgroundColor = Constant.setLabelColor(label: longShots)
        penalties.text = String(player.penalties)
        penalties.backgroundColor = Constant.setLabelColor(label: penalties)
        shortPassing.text = String(player.shortPassing)
        shortPassing.backgroundColor = Constant.setLabelColor(label: shortPassing)
        shotPower.text = String(player.shotPower)
        shotPower.backgroundColor = Constant.setLabelColor(label: shotPower)
        slidingTackle.text = String(player.slidingTackle)
        slidingTackle.backgroundColor = Constant.setLabelColor(label: slidingTackle)
        standingTackle.text = String(player.standingTackle)
        standingTackle.backgroundColor = Constant.setLabelColor(label: standingTackle)
        volleys.text = String(player.volleys)
        volleys.backgroundColor = Constant.setLabelColor(label: volleys)
    }

}
