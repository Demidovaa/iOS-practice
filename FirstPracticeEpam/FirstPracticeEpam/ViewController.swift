//
//  ViewController.swift
//  FirstPracticeEpam
//
//  Created by Анастасия Демидова on 31.01.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainLabel: UILabel! 
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var counterLabel: UILabel!
    
    private var range: RangeSetting!
    private var generatedNumber = 0
    private var actionCounter = 0
    private var games = [Game]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSettings()
        infoLabel.text = nil
        counterLabel.text = nil
    }
    
    private func getSettings() {
        if let minData = DataBaseHelper.getObject(for: RangeSetting.minKey),
            let maxData = DataBaseHelper.getObject(for: RangeSetting.maxKey),
            let min = minData as? Int,
            let max = maxData as? Int {
            range = RangeSetting(min, max)
        } else {
            openSettings(allowClosing: false, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
        guard range != nil else { return }
        mainLabel.text = "base".localized() + "\n" + range.description
        startGame()
    }
    
    private func openSettings(allowClosing: Bool, animated: Bool) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let settingsViewController = storyBoard.instantiateViewController(
            withIdentifier: "SettingsViewController") as? SettingsViewController {
            
            settingsViewController.delegate = self
            settingsViewController.allowClosing = allowClosing
            navigationController?.pushViewController(settingsViewController,
                                                     animated: animated)
        }
    }
    
    @IBAction func settingsButtonPressed() {
        openSettings(allowClosing: true, animated: true)
    }
    
    @IBAction func checkButtonPressed() {
        if actionCounter == 0 {
            counterLabel.text = nil
        }
        
        if let text = inputTextField.text, !text.isEmpty {
            mainLabel.text = "base".localized() + "\n" + range.description
            actionCounter += 1
            compare()
        } else {
            mainLabel.text = "error".localized() + "\n" + range.description
            clearTextField()
        }
    }
    
    func compare() {
        guard let value = Int(inputTextField.text ?? "") else { return }
        clearTextField()
        
        if value == generatedNumber {
            counterLabel.text = "counterSuccess".localized() + "\(actionCounter)"
            mainLabel.text = "repeatSuccess".localized() + "\n" + range.description
            infoLabel.text = "success".localized()
            finishGame()
        } else if value > generatedNumber {
            infoLabel.text = "many".localized()
        } else {
            infoLabel.text = "few".localized()
        }
    }
    
    @IBAction func fail(_ sender: Any) {
        infoLabel.text = "newVar".localized()
        mainLabel.text = "answer".localized() + " \(generatedNumber)!"
        counterLabel.text = "counterFail".localized() + "\(actionCounter)"
        finishGame()
    }
    
    func startGame() {
        generatedNumber = Int.random(in: range.min ... range.max)
        actionCounter = 0
    }
    
    func finishGame() {
        let game = Game(range: range, attempts: actionCounter)
        games.append(game)
        clearTextField()
        removeKeyboard()
        startGame()
    }
    
    func clearTextField() {
        inputTextField.text = nil
    }
    
    func removeKeyboard() {
        inputTextField.resignFirstResponder()
    }
    
    @IBAction func statistics(_ sender: Any) {
        performSegue(withIdentifier: "Statistics", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Statistics" {
            if let statistics = segue.destination as? StatisticsViewController {
                statistics.items = games
            }
        }
    }
}

extension ViewController: SettingsDelegate {    
    func didUpdateSettings(range: RangeSetting) {
        self.range = range
        DataBaseHelper.save(object: range.min, for: RangeSetting.minKey)
        DataBaseHelper.save(object: range.max, for: RangeSetting.maxKey)
        generatedNumber = Int.random(in: range.min ... range.max)
        mainLabel.text = "base".localized() + "\n" + range.description
        counterLabel.text = nil
        infoLabel.text = nil
    }
}
