//
//  DetailViewController.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/11/06.
//  Copyright © 2019 Tomoaki Tashiro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseStorage
import FirebaseUI
import Alertift
import GoogleMobileAds

class DetailViewController: UIViewController {
    
    var player: Player!
    var detailSegmentFirstViewOwner: DetailSegmentFirstViewOwner!
    var detailSegmentSecondViewOwner: DetailSegmentSecondViewOwner!
    var detailSegmentThirdViewOwner: DetailSegmentThirdViewOwner!
    var detailSegmentFourthViewOwner: DetailSegmentFourthViewOwner!
    var detailSegmentFifthViewOwner: DetailSegmentFifthViewOwner!
    var detailSegmentSixthViewOwner: DetailSegmentSixthViewOwner!
    
    var isFavorite: Bool = false
    var count: Int = 0
    var favoriteButtonImage: UIImage!
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var faceImage: UIImageView!
    @IBOutlet weak var nationImage: UIImageView!
    @IBOutlet weak var nationName: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var version: UILabel!
    @IBOutlet weak var overallRating: UILabel!
    @IBOutlet weak var potential: UILabel!
    @IBOutlet weak var clubName: UILabel!
    @IBOutlet weak var contract: UILabel!
    @IBOutlet weak var realFace: UILabel!
    @IBOutlet weak var preferredFoot: UILabel!
    @IBOutlet weak var weakFoot: UILabel!
    @IBOutlet weak var skillMoves: UILabel!
    @IBOutlet weak var attackingWorkRate: UILabel!
    @IBOutlet weak var defensiveWorkRate: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var detailSegmentButton: UISegmentedControl!
    @IBOutlet weak var bannerView: GADBannerView!
    
    let disposeBag = DisposeBag()
    
    // MARK: - Function
    
    override func loadView() {
        super.loadView()
        
        // 選手ステータスを表示するsubViewをセット
        detailSegmentFirstViewOwner = DetailSegmentFirstViewOwner()
        self.view.addSubview(detailSegmentFirstViewOwner.detailSegmentFirstView)
        detailSegmentSecondViewOwner = DetailSegmentSecondViewOwner()
        self.view.addSubview(detailSegmentSecondViewOwner.detailSegmentSecondView)
        detailSegmentThirdViewOwner = DetailSegmentThirdViewOwner()
        self.view.addSubview(detailSegmentThirdViewOwner.detailSegmentThirdView)
        detailSegmentFourthViewOwner = DetailSegmentFourthViewOwner()
        self.view.addSubview(detailSegmentFourthViewOwner.detailSegmentFourthView)
        detailSegmentFifthViewOwner = DetailSegmentFifthViewOwner()
        self.view.addSubview(detailSegmentFifthViewOwner.detailSegmentFifthView)
        detailSegmentSixthViewOwner = DetailSegmentSixthViewOwner()
        self.view.addSubview(detailSegmentSixthViewOwner.detailSegmentSixthView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 選手ステータスを表示するsubViewのレイアウトを設定
        detailSegmentFirstViewOwner.detailSegmentFirstView.topAnchor.constraint(equalTo:self.detailSegmentButton.bottomAnchor, constant: 0.0).isActive = true
        detailSegmentFirstViewOwner.detailSegmentFirstView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 0.0).isActive = true
        detailSegmentFirstViewOwner.detailSegmentFirstView.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant: 0.0).isActive = true
            detailSegmentFirstViewOwner.setLabel(player)
        
        detailSegmentSecondViewOwner.detailSegmentSecondView.topAnchor.constraint(equalTo:self.detailSegmentButton.bottomAnchor, constant: 0.0).isActive = true
        detailSegmentSecondViewOwner.detailSegmentSecondView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 0.0).isActive = true
        detailSegmentSecondViewOwner.detailSegmentSecondView.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant: 0.0).isActive = true
            detailSegmentSecondViewOwner.setLabel(player)
        
        detailSegmentThirdViewOwner.detailSegmentThirdView.topAnchor.constraint(equalTo:self.detailSegmentButton.bottomAnchor, constant: 0.0).isActive = true
        detailSegmentThirdViewOwner.detailSegmentThirdView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 0.0).isActive = true
        detailSegmentThirdViewOwner.detailSegmentThirdView.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant: 0.0).isActive = true
            detailSegmentThirdViewOwner.setLabel(player)
        
        detailSegmentFourthViewOwner.detailSegmentFourthView.topAnchor.constraint(equalTo:self.detailSegmentButton.bottomAnchor, constant: 0.0).isActive = true
        detailSegmentFourthViewOwner.detailSegmentFourthView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 0.0).isActive = true
        detailSegmentFourthViewOwner.detailSegmentFourthView.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant: 0.0).isActive = true
            detailSegmentFourthViewOwner.setLabel(player)
        
        detailSegmentFifthViewOwner.detailSegmentFifthView.topAnchor.constraint(equalTo:self.detailSegmentButton.bottomAnchor, constant: 0.0).isActive = true
        detailSegmentFifthViewOwner.detailSegmentFifthView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 0.0).isActive = true
        detailSegmentFifthViewOwner.detailSegmentFifthView.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant: 0.0).isActive = true
            detailSegmentFifthViewOwner.setLabel(player)
        
        detailSegmentSixthViewOwner.detailSegmentSixthView.topAnchor.constraint(equalTo:self.detailSegmentButton.bottomAnchor, constant: 0.0).isActive = true
        detailSegmentSixthViewOwner.detailSegmentSixthView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 0.0).isActive = true
        detailSegmentSixthViewOwner.detailSegmentSixthView.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant: 0.0).isActive = true
            detailSegmentSixthViewOwner.setLabel(player)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 広告表示
        bannerView.adUnitID = "ca-app-pub-6834870074522900/1228635586"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        // DetailViewModelの初期化
        let detailViewModel = DetailViewModel(dataBase: RealmDb())
        
        // お気に入りに登録されているか確認
        detailViewModel.isExistsFavoritePlayer(player)
        
        // お気に入りの状態に応じたお気に入りボタンをセット
        detailViewModel.isExists.subscribe(onNext: { [unowned self] isExists in
            if isExists == true {
                self.favoriteButtonImage = UIImage(named: "favorite_on")
            } else {
                self.favoriteButtonImage = UIImage(named: "favorite_off")
            }
            self.isFavorite = isExists
            self.favoriteButton.setImage(self.favoriteButtonImage, for: UIControl.State.normal)
        }).disposed(by: disposeBag)
        
        // 選手データをラベルにセット
        setStatusLabel()

        // 選手ステータスの表示を初期化
        initSegmentView()
        
        // お気に入り登録数を取得
        detailViewModel.getFavoritePlayerCount()
        
        detailViewModel.count.subscribe(onNext: { [unowned self] count in
            self.count = count
        }).disposed(by: disposeBag)
        
        // お気に入りボタンのタップでお気に入り登録/削除
        favoriteButton.rx.tap.subscribe { [unowned self] _ in
            if self.isFavorite == true {
                self.favoriteButtonImage = UIImage(named: "favorite_off")
                self.isFavorite = false
                detailViewModel.deleteFavoritePlayer(self.player)
                self.count -= 1
            } else {
                // お気に入り登録数が100件で登録不可
                if self.count == 100 { return }
                self.favoriteButtonImage = UIImage(named: "favorite_on")
                self.isFavorite = true
                detailViewModel.addFavoritePlayer(self.player)
                self.count += 1
            }
            
            self.favoriteButton.setImage(self.favoriteButtonImage, for: UIControl.State.normal)
        }.disposed(by: disposeBag)
        
        // 選手ステータスの表示を切り替え
        _ = detailSegmentButton.rx.selectedSegmentIndex.bind { value in
            self.hiddenSegumentView()
            
            switch Int(value) {
                case 0:
                    self.detailSegmentFirstViewOwner.detailSegmentFirstView.isHidden = false
                case 1:
                    self.detailSegmentSecondViewOwner.detailSegmentSecondView.isHidden = false
                case 2:
                    self.detailSegmentThirdViewOwner.detailSegmentThirdView.isHidden = false
                case 3:
                    self.detailSegmentFourthViewOwner.detailSegmentFourthView.isHidden = false
                case 4:
                    self.detailSegmentFifthViewOwner.detailSegmentFifthView.isHidden = false
                case 5:
                    self.detailSegmentSixthViewOwner.detailSegmentSixthView.isHidden = false
                default:
                    self.detailSegmentFirstViewOwner.detailSegmentFirstView.isHidden = false
            }
        }
        
        // エラー状態の取得
        detailViewModel.isError.subscribe(onNext: { [weak self] result in
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
    
    /// 選手データのラベルをセット
    ///
    private func setStatusLabel() {
        
        let facePlaceholder = UIImage(named: "face_placeholder.png")!
        let nationPlaceholder = UIImage(named: "nation_placeholder.png")!
        fullName.text = player.fullName
        let faceRef = Storage.storage().reference().child(player.faceImageURL)
        faceImage.sd_setImage(with: faceRef, placeholderImage: facePlaceholder)
        nationName.text = player.nationName
        let nationRef = Storage.storage().reference().child(player.nationImageURL)
        nationImage.sd_setImage(with: nationRef, placeholderImage: nationPlaceholder)
        age.text = String(player.age)
        height.text = String(player.height)
        weight.text = String(player.weight)
        position.text = player.position.joined(separator: " ")
        version.text = player.version
        overallRating.text = String(player.overallRating)
        overallRating.backgroundColor = Constant.setLabelColor(label: overallRating)
        potential.text = String(player.potential)
        potential.backgroundColor = Constant.setLabelColor(label: potential)
        clubName.text = player.clubName
        contract.text = player.contract
        realFace.text = player.realFace
        preferredFoot.text = player.preferredFoot
        weakFoot.text = String(player.weakFoot)
        skillMoves.text = String(player.skillMoves)
        attackingWorkRate.text = player.attackingWorkRate
        defensiveWorkRate.text = player.defensiveWorkRate
    }
    
    /// 選手ステータスの表示を初期化
    ///
    private func initSegmentView() {
        
        detailSegmentFirstViewOwner.detailSegmentFirstView.isHidden = false
        detailSegmentSecondViewOwner.detailSegmentSecondView.isHidden = true
        detailSegmentThirdViewOwner.detailSegmentThirdView.isHidden = true
        detailSegmentFourthViewOwner.detailSegmentFourthView.isHidden = true
        detailSegmentFifthViewOwner.detailSegmentFifthView.isHidden = true
        detailSegmentSixthViewOwner.detailSegmentSixthView.isHidden = true
    }
    
    /// 選手ステータスを全て非表示
    ///
    private func hiddenSegumentView() {
        
        detailSegmentFirstViewOwner.detailSegmentFirstView.isHidden = true
        detailSegmentSecondViewOwner.detailSegmentSecondView.isHidden = true
        detailSegmentThirdViewOwner.detailSegmentThirdView.isHidden = true
        detailSegmentFourthViewOwner.detailSegmentFourthView.isHidden = true
        detailSegmentFifthViewOwner.detailSegmentFifthView.isHidden = true
        detailSegmentSixthViewOwner.detailSegmentSixthView.isHidden = true
    }
    
}
