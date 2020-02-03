//
//  ReadJson.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2020/01/05.
//  Copyright © 2020 Tomoaki Tashiro. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ReadJson {
    
    var nationList: [Nation] = []
    var clubList: [Club] = []
    
    /// Jsonファイルから国リストを取得
    ///
    /// - Returns: Disposables.create()
    ///
    func getNationList() -> Single<[Nation]> {
        
        return Single<[Nation]>.create(subscribe: { single in
            
            do {
                let path = Bundle.main.path(forResource: "nations", ofType: "json")
                let url = URL(fileURLWithPath: path!)
                let jsonData = try Data(contentsOf: url)
                let nations: [Nation] = try! JSONDecoder().decode([Nation].self, from: jsonData)
                self.nationList = nations
                single(.success(self.nationList))
            } catch {
                    
                single(.error(error))
            }

            return Disposables.create()
        })
    }
    
    /// Jsonファイルからクラブリストを取得
    ///
    /// - Returns: Disposables.create()
    ///
    func getClubList() -> Single<[Club]> {
        
        return Single<[Club]>.create(subscribe: { single in
            
            do {
                let path = Bundle.main.path(forResource: "clubs", ofType: "json")
                let url = URL(fileURLWithPath: path!)
                let jsonData = try Data(contentsOf: url)
                let clubs: [Club] = try! JSONDecoder().decode([Club].self, from: jsonData)
                self.clubList = clubs
                single(.success(self.clubList))
            } catch {
                    
                single(.error(error))
            }

            return Disposables.create()
        })
    }
    
}
