//
//  DetailSegmentFourthViewOwner.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/11/26.
//  Copyright © 2019 Tomoaki Tashiro. All rights reserved.
//

import UIKit

class DetailSegmentFourthViewOwner: NSObject {
    
    @IBOutlet weak var aggression: UILabel!
    @IBOutlet weak var positioning: UILabel!
    @IBOutlet weak var composure: UILabel!
    @IBOutlet weak var interceptions: UILabel!
    @IBOutlet weak var vision: UILabel!

    var detailSegmentFourthView: UIView!

    override init() {
      super.init()
      detailSegmentFourthView = UINib(nibName: "DetailSegmentFourthView", bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setLabel(_ player: Player) {
        
        aggression.text = String(player.aggression)
        aggression.backgroundColor = Constant.setLabelColor(label: aggression)
        positioning.text = String(player.positioning)
        positioning.backgroundColor = Constant.setLabelColor(label: positioning)
        composure.text = String(player.composure)
        composure.backgroundColor = Constant.setLabelColor(label: composure)
        interceptions.text = String(player.interceptions)
        interceptions.backgroundColor = Constant.setLabelColor(label: interceptions)
        vision.text = String(player.vision)
        vision.backgroundColor = Constant.setLabelColor(label: vision)
    }

}
