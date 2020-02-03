//
//  DetailSegmentThirdViewOwner.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/11/26.
//  Copyright © 2019 Tomoaki Tashiro. All rights reserved.
//

import UIKit

class DetailSegmentThirdViewOwner: NSObject {
    
    @IBOutlet weak var acceleration: UILabel!
    @IBOutlet weak var agility: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var jumping: UILabel!
    @IBOutlet weak var reactions: UILabel!
    @IBOutlet weak var sprintSpeed: UILabel!
    @IBOutlet weak var stamina: UILabel!
    @IBOutlet weak var strength: UILabel!

    var detailSegmentThirdView: UIView!

    override init() {
       super.init()
       detailSegmentThirdView = UINib(nibName: "DetailSegmentThirdView", bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as? UIView
    }

    func setLabel(_ player: Player) {
        
        acceleration.text = String(player.acceleration)
        acceleration.backgroundColor = Constant.setLabelColor(label: acceleration)
        agility.text = String(player.agility)
        agility.backgroundColor = Constant.setLabelColor(label: agility)
        balance.text = String(player.balance)
        balance.backgroundColor = Constant.setLabelColor(label: balance)
        jumping.text = String(player.jumping)
        jumping.backgroundColor = Constant.setLabelColor(label: jumping)
        reactions.text = String(player.reactions)
        reactions.backgroundColor = Constant.setLabelColor(label: reactions)
        sprintSpeed.text = String(player.sprintSpeed)
        sprintSpeed.backgroundColor = Constant.setLabelColor(label: sprintSpeed)
        stamina.text = String(player.stamina)
        stamina.backgroundColor = Constant.setLabelColor(label: stamina)
        strength.text = String(player.strength)
        strength.backgroundColor = Constant.setLabelColor(label: strength)
    }

}
