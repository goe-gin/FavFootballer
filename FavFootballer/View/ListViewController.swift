//
//  ListViewController.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/09/01.
//  Copyright © 2019年 Tomoaki Tashiro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import Alertift
import PKHUD
import GoogleMobileAds

class ListViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    let filterConditions = BehaviorRelay<[String : String]>(value: [:])
    let disposeBag = DisposeBag()
        
    // MARK: - Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 広告表示
        bannerView.adUnitID = "ca-app-pub-6834870074522900/1228635586"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        // TableViewCellをセット
        listTableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil),forCellReuseIdentifier:"playerTableViewCell")
        
        // ListViewModelの初期化
        let listViewModel = ListViewModel(dataBase: FirestoreDb())

        // 選手リストの取得  
        self.filterConditions.asObservable().subscribe({ [weak self] filterConditions in
            guard self != nil else {
                return
            }
            listViewModel.getPlayerList(filterConditions.element!)
        }).disposed(by: disposeBag)
        
        // 選手リストをTableViewにセット
        listViewModel.playerList.asObservable().bind(to: listTableView.rx.items) { (tableView, row, player) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "playerTableViewCell") as! PlayerTableViewCell
            cell.setCell(player)
            return cell
        }.disposed(by: disposeBag)
        
        // セルをタップでDetailViewに遷移
        listTableView.rx.itemSelected.subscribe(onNext: { [unowned self] indexPath in
            let selectPlayer = listViewModel.playerList.value[indexPath.row]
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toDetailViewController", sender: selectPlayer)
            }
            self.listTableView.deselectRow(at: indexPath, animated: true)

        }).disposed(by: disposeBag)
        
        // 選手リストの有無の取得
        listViewModel.isEmpty.subscribe(onNext: { [weak self] result in
            guard self != nil else {
                return
            }
            if result {
                // アラートを表示
                Alertift.alert(title: "No Results Found", message: "Please Change Conditions")
                .buttonTextColor(.black)
                .action(.default("OK"))
                .show()
            }
        }).disposed(by: disposeBag)
        
        // 読み込み状態の取得
        listViewModel.isLoading.subscribe(onNext: { [weak self] result in
            guard self != nil else {
                return
            }
            if result {
                // HUD表示
                HUD.show(.progress)
            } else {
                // HUD非表示
                HUD.hide()
            }
        }).disposed(by: disposeBag)
        
        // エラー状態の取得
        listViewModel.isError.subscribe(onNext: { [weak self] result in
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

}


