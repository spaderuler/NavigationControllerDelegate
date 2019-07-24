//
//  DetailTableViewController.swift
//  NavigationControllerDelegate
//
//  Created by donggua on 2019/7/23.
//  Copyright © 2019年 wky. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       title = "list"
        tableView.rowHeight = 54.0
    }

    // MARK: - Table view data source
    let packItems = ["Ice cream money", "Great weather", "Beach ball", "Swimsuit for him", "Swimsuit for her", "Beach games", "Ironing board", "Cocktail mood", "Sunglasses", "Flip flops"]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .none
        cell.textLabel?.text = packItems[(indexPath as NSIndexPath).row]
        cell.imageView?.image = UIImage(named: "summericons_100px_0\((indexPath as NSIndexPath).row).png")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
