//
//  DetailSegmentFifthViewOwner.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/11/26.
//  Copyright © 2019 Tomoaki Tashiro. All rights reserved.
//

import UIKit

class DetailSegmentFifthViewOwner: NSObject {
    
    @IBOutlet weak var gkDiving: UILabel!
    @IBOutlet weak var gkHandling: UILabel!
    @IBOutlet weak var gkKicking: UILabel!
    @IBOutlet weak var gkPositioning: UILabel!
    @IBOutlet weak var gkReflexes: UILabel!

    var detailSegmentFifthView: UIView!

    override init() {
     super.init()
     detailSegmentFifthView = UINib(nibName: "DetailSegmentFifthView", bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setLabel(_ player: Player) {

        gkDiving.text = String(player.gkDiving)
        gkDiving.backgroundColor = Constant.setLabelColor(label: gkDiving)
        gkHandling.text = String(player.gkHandling)
        gkHandling.backgroundColor = Constant.setLabelColor(label: gkHandling)
        gkKicking.text = String(player.gkKicking)
        gkKicking.backgroundColor = Constant.setLabelColor(label: gkKicking)
        gkPositioning.text = String(player.gkPositioning)
        gkPositioning.backgroundColor = Constant.setLabelColor(label: gkPositioning)
        gkReflexes.text = String(player.gkReflexes)
        gkReflexes.backgroundColor = Constant.setLabelColor(label: gkReflexes)
    }

}
