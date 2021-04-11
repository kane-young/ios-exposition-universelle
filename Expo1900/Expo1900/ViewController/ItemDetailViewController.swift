//
//  ItemDetailViewController.swift
//  Expo1900
//
//  Created by 이영우 on 2021/04/11.
//

import Foundation
import UIKit

class ItemDetailViewController: UIViewController {
    
    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var itemDescriptionLabel: UILabel!
    
    var paramTitle: String?
    var paramImage: String?
    var paramDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
    }
    
    private func initializeViews() {
        self.navigationItem.title = paramTitle
        guard let imageName = paramImage else { return }
        self.itemImageView.image = UIImage(named: imageName)
        self.itemDescriptionLabel.text = paramDescription
    }
}
