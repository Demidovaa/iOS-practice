//
//  SettingsViewController.swift
//  FirstPracticeEpam
//
//  Created by Анастасия Демидова on 05.02.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//
import UIKit

struct RangeSetting {
    static let minKey = "RangeSetting.min"
    static let maxKey = "RangeSetting.max"
    
    var min: Int
    var max: Int
    
    init(_ min: Int, _ max: Int) {
        self.min = min
        self.max = max
    }
    
    var description: String {
        return "[\(min) - \(max)]"
    }
}

//MARK: Protocol 
protocol SettingsDelegate {
    func didUpdateSettings(range: RangeSetting)
}

class SettingsViewController: UIViewController {
    @IBOutlet weak var minTextField: UITextField!
    @IBOutlet weak var maxTextField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    var allowClosing: Bool = true
    var delegate: SettingsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = !allowClosing
        infoLabel.text = "setRange".localized()
    }
    
    @IBAction private func save() {
        guard let minText = minTextField.text,
            let maxText = maxTextField.text,
            let min = Int(minText),
            let max = Int(maxText),
            min < max else {
                showError()
                return
        }
        
        let range = RangeSetting(min, max)
        DataBaseHelper.save(object: range.max, for: RangeSetting.maxKey)
        DataBaseHelper.save(object: range.min, for: RangeSetting.minKey)
        delegate?.didUpdateSettings(range: range)
        navigationController?.popViewController(animated: true)
    }
    
    private func showError() {
        infoLabel.text = "error".localized()
        minTextField.text = nil
        maxTextField.text = nil
    }
}
