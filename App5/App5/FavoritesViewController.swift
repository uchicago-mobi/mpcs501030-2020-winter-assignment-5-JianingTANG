//
//  FavoritesViewController.swift
//  App5
//
//  Created by Jianing Tang on 2/12/20.
//  Copyright © 2020 Jianing Tang. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!

    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var favoritePlaceList:[Place] = DataManager.sharedInstance.listFavorites()
    
    weak var delegate: PlacesFavoritesDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "favorite")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoritePlaceList:[Place] = DataManager.sharedInstance.listFavorites()
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorite")!
        cell.textLabel!.text = favoritePlaceList[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let favoritePlaceList:[Place] = DataManager.sharedInstance.listFavorites()
        return favoritePlaceList.count
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoritePlaceList:[Place] = DataManager.sharedInstance.listFavorites()
        delegate?.favoritePlace(name: favoritePlaceList[indexPath.row].title!)
        tableView.deselectRow(at: indexPath, animated: true)
        self.closeButton(tableView)
    }
}

protocol PlacesFavoritesDelegate: class {
  func favoritePlace(name: String) -> Void
}
