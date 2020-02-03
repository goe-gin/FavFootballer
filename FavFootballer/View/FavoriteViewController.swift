//
//  FavoriteViewController.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/11/06.
//  Copyright © 2019 Tomoaki Tashiro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import RxRealm
import Alertift
import GoogleMobileAds

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var bannerView: GADBannerView!
    
    let disposeBag = DisposeBag()
    var favoritePlayerObject: Results<FavoritePlayer>!
    
    // MARK: - Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 広告表示
        bannerView.adUnitID = "ca-app-pub-6834870074522900/1228635586"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())

        // TableViewCellをセット
        favoriteTableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil),forCellReuseIdentifier:"playerTableViewCell")
        
        // FavoriteViewModelの初期化
        let favoriteViewModel = FavoriteViewModel(dataBase: RealmDb())
        
        // お気に入り選手リストの取得
        self.favoritePlayerObject = favoriteViewModel.getFavoritePlayerObject()
        
        // お気に入り選手リストをTableViewにセット（追加、削除される毎に更新）
        //
        Observable.collection(from: self.favoritePlayerObject)
            .bind(to: favoriteTableView.rx.items) {tableView, row, favoritePlayer in
          let cell = tableView.dequeueReusableCell(withIdentifier: "playerTableViewCell") as! PlayerTableViewCell
          let player = favoriteViewModel.convertFavoritePlayerToPlayer(favoritePlayer)
          self.favoriteCount.text = String(self.favoritePlayerObject.count)
          cell.setCell(player)
          return cell
        }.disposed(by: disposeBag)
        
        // セルをタップでDetailViewに遷移
        //
        Observable.zip(favoriteTableView.rx.itemSelected, favoriteTableView.rx.modelSelected(FavoritePlayer.self))
            .bind{ [unowned self] indexPath, favoritePlayer in
                let selectPlayer = favoriteViewModel.convertFavoritePlayerToPlayer(favoritePlayer)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toDetailViewController", sender: selectPlayer)
                }
                self.favoriteTableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: disposeBag)
        
        // スワイプのセル削除でお気に入り選手を削除
        //
        favoriteTableView.rx.itemDeleted.subscribe(onNext: { [unowned self] indexPath in
            favoriteViewModel.deleteFavoritePlayerForRow(indexPath.row)
            self.favoriteTableView.deselectRow(at: indexPath, animated: true)
            self.favoriteCount.text = "0"
        }).disposed(by: disposeBag)
        
        // エラー状態の取得
        favoriteViewModel.isError.subscribe(onNext: { [weak self] result in
            guard self != nil else {
                return
            }
            if result {
                // アラートを表示
                Alertift.alert(title: "Error", message: "Please Retry")
                .buttonTextColor(.black)
                .action(.default("OK"))
                .show()
            }
        }).disposed(by: disposeBag)
    }
    
    /// DetailViewに選手データを引き継ぐ
    ///
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailViewController" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.player = sender as? Player
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.favoriteCount.text = String(self.favoritePlayerObject.count)
    }

}
