//
//  DetailSegmentSixthViewOwner.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/11/26.
//  Copyright © 2019 Tomoaki Tashiro. All rights reserved.
//

import UIKit

class DetailSegmentSixthViewOwner: NSObject {
    
    @IBOutlet weak var trait1: UILabel!
    @IBOutlet weak var trait2: UILabel!
    @IBOutlet weak var trait3: UILabel!
    @IBOutlet weak var trait4: UILabel!
    @IBOutlet weak var trait5: UILabel!
    @IBOutlet weak var trait6: UILabel!
    @IBOutlet weak var trait7: UILabel!
    @IBOutlet weak var trait8: UILabel!

   var detailSegmentSixthView: UIView!

   override init() {
    super.init()
    detailSegmentSixthView = UINib(nibName: "DetailSegmentSixthView", bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as? UIView
   }
   
   func setLabel(_ player: Player) {
    
    var traits: [String] = []
        
    for i in 0..<8 {
        
        if player.trait.indices.contains(i) {
            
            traits.append(player.trait[i])
        } else {
            
            traits.append("")
        }
    }
    
    trait1.text = traits[0]
    trait2.text = traits[1]
    trait3.text = traits[2]
    trait4.text = traits[3]
    trait5.text = traits[4]
    trait6.text = traits[5]
    trait7.text = traits[6]
    trait8.text = traits[7]
   }

}
