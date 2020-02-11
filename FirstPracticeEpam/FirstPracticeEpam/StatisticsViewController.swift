//
//  StatisticsViewController.swift
//  FirstPracticeEpam
//
//  Created by Анастасия Демидова on 08.02.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

struct Game {
    let range: RangeSetting
    let attempts: Int
}

class StatisticsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var items = [Game]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension StatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count + 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "info".localized()
        } else {
            return "gameNumber".localized() + "\(section)"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "counterGame".localized()
            cell.detailTextLabel?.text = "\(items.count)"
            return cell
        }
        
        let game = items[indexPath.section - 1]
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "range".localized()
            cell.detailTextLabel?.text = game.range.description
        } else {
            cell.textLabel?.text = "attempts".localized()
            cell.detailTextLabel?.text = "\(game.attempts)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
