//
//  FilterViewController.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/11/06.
//  Copyright © 2019 Tomoaki Tashiro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alertift
import GoogleMobileAds

class FilterViewController: UIViewController {
    
    let disposeBag = DisposeBag()
        
    @IBOutlet weak var versionSegmentButton: UISegmentedControl!
    @IBOutlet weak var rangeStatusField: UITextField!
    @IBOutlet weak var rangeMinField: UITextField!
    @IBOutlet weak var rangeMaxField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var nationField: UITextField!
    @IBOutlet weak var clubField: UITextField!
    @IBOutlet weak var positionField: UITextField!
    @IBOutlet weak var preferredFootField: UITextField!
    @IBOutlet weak var weakFootField: UITextField!
    @IBOutlet weak var skillMovesField: UITextField!
    @IBOutlet weak var attackingWorkRateField: UITextField!
    @IBOutlet weak var defensiveWorkRateField: UITextField!
    @IBOutlet weak var realFaceField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var bannerView: GADBannerView!
        
    // MARK: - Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 広告表示
        bannerView.adUnitID = "ca-app-pub-6834870074522900/1228635586"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        // filterViewModelの初期化
        let filterViewModel = FilterViewModel(dataBase: ReadJson())
        
        // PickerViewの選択肢をセット
        preparPickerView(filterViewModel)
        
        // 入力されたフィルタ条件をセット
        setFilterConditionsValue(filterViewModel)
        
        // フィルタ条件を渡してListへ戻る
        applyButton.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {
                return
            }
            let listViewController = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-2] as! ListViewController
            listViewController.filterConditions.accept(filterViewModel.filterConditions.value)
            _ = self.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
        
        // 入力されたフィルタ条件をリセット
        resetButton.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {
                return
            }
            filterViewModel.resetFilterConditions()
            self.resetLabelText()
        }.disposed(by: disposeBag)
        
        // エラー状態の取得
        filterViewModel.isError.subscribe(onNext: { [weak self] result in
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
    
    /// PickerViewの選択肢をセット
    ///
    private func preparPickerView(_ filterViewModel: FilterViewModel) {
        
        let statusRange = Constant.setStatusRange()
        let ageRange = Constant.setAgeRange()
        
        let rangeStatusPickerView = UIPickerView()
        rangeStatusField.inputView = rangeStatusPickerView
        rangeStatusField.text = Constant.rangeList[0]
        
        Observable.just(Constant.rangeList).bind(to: rangeStatusPickerView.rx.itemTitles) { _, status in
            return status
        }.disposed(by: disposeBag)
        
        rangeStatusPickerView.rx.modelSelected(String.self).map { status in
            return status.first
        }.bind(to: rangeStatusField.rx.text).disposed(by: disposeBag)
        
        let rangeMinPickerView = UIPickerView()
        rangeMinField.inputView = rangeMinPickerView
        rangeMinField.text = String(Constant.defaultRangeMin)
        
        Observable.just(statusRange).bind(to: rangeMinPickerView.rx.itemTitles) { _, value in
            return value
        }.disposed(by: disposeBag)
        
        rangeMinPickerView.rx.modelSelected(String.self).map { value in
            return value.first
        }.bind(to: rangeMinField.rx.text).disposed(by: disposeBag)
        
        let rangeMaxPickerView = UIPickerView()
        rangeMaxField.inputView = rangeMaxPickerView
        rangeMaxField.text = String(Constant.defaultRangeMax)
        
        Observable.just(statusRange.reversed()).bind(to: rangeMaxPickerView.rx.itemTitles) { _, value in
            return value
        }.disposed(by: disposeBag)
        
        rangeMaxPickerView.rx.modelSelected(String.self).map { value in
            return value.first
        }.bind(to: rangeMaxField.rx.text).disposed(by: disposeBag)
        
        let agePickerView = UIPickerView()
        ageField.inputView = agePickerView
        
        Observable.just(ageRange).bind(to: agePickerView.rx.itemTitles) { _, value in
            return value
        }.disposed(by: disposeBag)
        
        agePickerView.rx.modelSelected(String.self).map { value in
            return value.first
        }.bind(to: ageField.rx.text).disposed(by: disposeBag)
        
        let nationPickerView = UIPickerView()
        nationField.inputView = nationPickerView
        
        filterViewModel.getNationList()
        
        filterViewModel.nationList.asObservable().bind(to: nationPickerView.rx.itemTitles) { (_, nation) in
            return nation
        }.disposed(by: disposeBag)
        
        nationPickerView.rx.modelSelected(String.self).map { nation in
            return nation.first
        }.bind(to: nationField.rx.text).disposed(by: disposeBag)
        
        let clubPickerView = UIPickerView()
        clubField.inputView = clubPickerView
        
        filterViewModel.getClubList()
        
        filterViewModel.clubList.asObservable().bind(to: clubPickerView.rx.itemTitles) { (_, club) in
            return club
        }.disposed(by: disposeBag)
        
        clubPickerView.rx.modelSelected(String.self).map { club in
            return club.first
        }.bind(to: clubField.rx.text).disposed(by: disposeBag)
        
        let positionPickerView = UIPickerView()
        positionField.inputView = positionPickerView
        
        Observable.just(Constant.positionList).bind(to: positionPickerView.rx.itemTitles) { _, position in
            return position
        }.disposed(by: disposeBag)
        
        positionPickerView.rx.modelSelected(String.self).map { position in
            return position.first
        }.bind(to: positionField.rx.text).disposed(by: disposeBag)

        let preferredFootPickerView = UIPickerView()
        preferredFootField.inputView = preferredFootPickerView
        
        Observable.just(Constant.preferredFootList).bind(to: preferredFootPickerView.rx.itemTitles) { _, preferredFoot in
            return preferredFoot
        }.disposed(by: disposeBag)
        
        preferredFootPickerView.rx.modelSelected(String.self).map { preferredFoot in
            return preferredFoot.first
        }.bind(to: preferredFootField.rx.text).disposed(by: disposeBag)
        
        let weakFootPickerView = UIPickerView()
        weakFootField.inputView = weakFootPickerView
        
        Observable.just(Constant.skillList).bind(to: weakFootPickerView.rx.itemTitles) { _, weakFoot in
            return weakFoot
        }.disposed(by: disposeBag)
        
        weakFootPickerView.rx.modelSelected(String.self).map { weakFoot in
            return weakFoot.first
        }.bind(to: weakFootField.rx.text).disposed(by: disposeBag)
        
        let skillMovesPickerView = UIPickerView()
        skillMovesField.inputView = skillMovesPickerView
        
        Observable.just(Constant.skillList).bind(to: skillMovesPickerView.rx.itemTitles) { _, skillMoves in
            return skillMoves
        }.disposed(by: disposeBag)
        
        skillMovesPickerView.rx.modelSelected(String.self).map { skillMoves in
            return skillMoves.first
        }.bind(to: skillMovesField.rx.text).disposed(by: disposeBag)
        
        let attackingWorkRatePickerView = UIPickerView()
        attackingWorkRateField.inputView = attackingWorkRatePickerView
        
        Observable.just(Constant.workRateList).bind(to: attackingWorkRatePickerView.rx.itemTitles) { _, attackingWorkRate in
            return attackingWorkRate
        }.disposed(by: disposeBag)
        
        attackingWorkRatePickerView.rx.modelSelected(String.self).map { attackingWorkRate in
            return attackingWorkRate.first
        }.bind(to: attackingWorkRateField.rx.text).disposed(by: disposeBag)
        
        let defensiveWorkRatePickerView = UIPickerView()
        defensiveWorkRateField.inputView = defensiveWorkRatePickerView
        
        Observable.just(Constant.workRateList).bind(to: defensiveWorkRatePickerView.rx.itemTitles) { _, defensiveWorkRate in
            return defensiveWorkRate
        }.disposed(by: disposeBag)
        
        defensiveWorkRatePickerView.rx.modelSelected(String.self).map { defensiveWorkRate in
            return defensiveWorkRate.first
        }.bind(to: defensiveWorkRateField.rx.text).disposed(by: disposeBag)
        
        let realFacePickerView = UIPickerView()
        realFaceField.inputView = realFacePickerView
        
        Observable.just(Constant.realFaceList).bind(to: realFacePickerView.rx.itemTitles) { _, realFace in
            return realFace
        }.disposed(by: disposeBag)
        
        realFacePickerView.rx.modelSelected(String.self).map { realFace in
            return realFace.first
        }.bind(to: realFaceField.rx.text).disposed(by: disposeBag)
    }
    
    /// 入力されたフィルタ条件をセット
    ///
    private func setFilterConditionsValue(_ filterViewModel: FilterViewModel) {
        
        // 検索する選手のバージョンを切り替え
        _ = versionSegmentButton.rx.selectedSegmentIndex.bind { value in
            switch Int(value) {
                case 0:
                    filterViewModel.setFilterConditions(["version" : Constant.versionList[0]])
                case 1:
                    filterViewModel.setFilterConditions(["version" : Constant.versionList[1]])
                default:
                    filterViewModel.setFilterConditions(["version" : Constant.versionList[1]])
            }
        }
        
        rangeStatusField.rx.text.orEmpty.asObservable().subscribe { [weak self] value in
            guard self != nil else {
                return
            }
            filterViewModel.setFilterConditions(["rangeStatus" : value.element!])
        }.disposed(by: disposeBag)
        
        rangeMinField.rx.text.orEmpty.asObservable().subscribe { [weak self] value in
            guard self != nil else {
                return
            }
            filterViewModel.setFilterConditions(["rangeMin" : value.element!])
        }.disposed(by: disposeBag)
        
        rangeMaxField.rx.text.orEmpty.asObservable().subscribe { [weak self] value in
            guard self != nil else {
                return
            }
            filterViewModel.setFilterConditions(["rangeMax" : value.element!])
        }.disposed(by: disposeBag)
        
        ageField.rx.text.orEmpty.asObservable().subscribe { [weak self] value in
            guard self != nil else {
                return
            }
            filterViewModel.setFilterConditions(["age" : value.element!])
        }.disposed(by: disposeBag)
        
        nationField.rx.text.orEmpty.asObservable().subscribe { [weak self] value in
            guard self != nil else {
                return
            }
            filterViewModel.setFilterConditions(["nation" : value.element!])
        }.disposed(by: disposeBag)
        
        clubField.rx.text.orEmpty.asObservable().subscribe { [weak self] value in
            guard self != nil else {
                return
            }
            filterViewModel.setFilterConditions(["club" : value.element!])
        }.disposed(by: disposeBag)
        
        positionField.rx.text.orEmpty.asObservable().subscribe { [weak self] value in
            guard self != nil else {
                return
            }
            filterViewModel.setFilterConditions(["position" : value.element!])
        }.disposed(by: disposeBag)
        
        preferredFootField.rx.text.orEmpty.asObservable().subscribe { [weak self] value in
            guard self != nil else {
                return
            }
            filterViewModel.setFilterConditions(["preferredFoot" : value.element!])
        }.disposed(by: disposeBag)
        
        weakFootField.rx.text.orEmpty.asObservable().subscribe { [weak self] value in
            guard self != nil else {
                return
            }
            filterViewModel.setFilterConditions(["weakFoot" : value.element!])
        }.disposed(by: disposeBag)
        
        skillMovesField.rx.text.orEmpty.asObservable().subscribe { [weak self] value in
            guard self != nil else {
                return
            }
            filterViewModel.setFilterConditions(["skillMoves" : value.element!])
        }.disposed(by: disposeBag)

        attackingWorkRateField.rx.text.orEmpty.asObservable().subscribe { [weak self] value in
            guard self != nil else {
                return
            }
            filterViewModel.setFilterConditions(["attackingWorkRate" : value.element!])
        }.disposed(by: disposeBag)
        
        defensiveWorkRateField.rx.text.orEmpty.asObservable().subscribe { [weak self] value in
            guard self != nil else {
                return
            }
            filterViewModel.setFilterConditions(["defensiveWorkRate" : value.element!])
        }.disposed(by: disposeBag)
        
        realFaceField.rx.text.orEmpty.asObservable().subscribe { [weak self] value in
            guard self != nil else {
                return
            }
            filterViewModel.setFilterConditions(["realFace" : value.element!])
        }.disposed(by: disposeBag)
    }
    
    /// 選択肢テキストフィールドの初期化
    ///
    private func resetLabelText() {
        
        self.rangeStatusField.text = Constant.rangeList[0]
        self.rangeMinField.text = String(Constant.defaultRangeMin)
        self.rangeMaxField.text = String(Constant.defaultRangeMax)
        self.ageField.text = nil
        self.nationField.text = nil
        self.clubField.text = nil
        self.positionField.text = nil
        self.preferredFootField.text = nil
        self.weakFootField.text = nil
        self.skillMovesField.text = nil
        self.attackingWorkRateField.text = nil
        self.defensiveWorkRateField.text = nil
        self.realFaceField.text = nil
    }

}
