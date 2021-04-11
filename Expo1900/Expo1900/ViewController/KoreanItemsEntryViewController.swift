//
//  KoreanItemsEntryViewController.swift
//  Expo1900
//
//  Created by 이영우 on 2021/04/10.
//

import UIKit

class KoreanItemsEntryViewController: UIViewController {
    @IBOutlet weak var itemEntryTableView: UITableView!
    var itemData: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "한국의 출품작"
        decodeData()
        // Do any additional setup after loading the view.
        let koreanEntryTableViewCell = UINib(nibName: String(describing: KoreanEntryTableViewCell.self), bundle: nil)
        self.itemEntryTableView.register(koreanEntryTableViewCell, forCellReuseIdentifier: "koreanEntryTableViewCell")
        self.itemEntryTableView.delegate = self
        self.itemEntryTableView.dataSource = self
    }
    
    private func decodeData() {
        let decoder: JSONDecoder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "items", bundle: .main) else {
            return
        }
        do {
            itemData = try decoder.decode([Item].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension KoreanItemsEntryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let detailViewController = storyboard.instantiateViewController(identifier: "detailItemVC") as? ItemDetailViewController else {
            return
        }
        
        detailViewController.paramTitle = self.itemData[indexPath.row].name
        detailViewController.paramImage = self.itemData[indexPath.row].imageName
        detailViewController.paramDescription = self.itemData[indexPath.row].description
        
        self.navigationController?.pushViewController(detailViewController, animated: false)
    }
}

extension KoreanItemsEntryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = itemEntryTableView.dequeueReusableCell(withIdentifier: "koreanEntryTableViewCell", for: indexPath) as? KoreanEntryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setCell(itemData[indexPath.row])
        return cell
    }
}
