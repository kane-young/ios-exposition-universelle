//
//  ExpoDescriptionViewController.swift
//  Expo1900
//
//  Created by 이영우 on 2021/04/09.
//

import UIKit
import Foundation

class ExpoDescriptionViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var visitorsLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var itemListButton: UIButton!
    @IBOutlet private weak var leftOnButtonImageView: UIImageView!
    @IBOutlet private weak var rightOnButtonImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
        self.navigationItem.title = "메인"
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction private func pushNextPage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "KoreanItemsEntryVC")
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    private func initializeViews() {
        let decoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "exposition_universelle_1900") else { return }
        do {
            let result = try decoder.decode(Exposition.self, from: dataAsset.data)
            titleLabel.text = changeTitle(result.title)
            titleLabel.textAlignment = .center
            visitorsLabel.text = "방문객 : \(result.visitorsStringFormat)"
            locationLabel.text = "개최지 : \(result.location)"
            durationLabel.text = "개최 기간 : \(result.duration)"
            descriptionLabel.text = result.description
        } catch {
            print(error.localizedDescription)
        }
        posterImageView.image = UIImage(named: "poster")
        itemListButton.setTitle("한국의 출품작 보러가기", for: .normal)
        leftOnButtonImageView.image = UIImage(named: "flag")
        rightOnButtonImageView.image = UIImage(named: "flag")
    }
    
    private func changeTitle(_ title: String) -> String {
        return title.replacingOccurrences(of: "(", with: "\n(")
    }
}
