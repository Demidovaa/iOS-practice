//
//  ViewController.swift
//  FirstPracticeEpam
//
//  Created by Анастасия Демидова on 31.01.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var answerUser: UITextField!
    
    var randomVar = 0
    var userVar = 0
    
    private let base = "Тебе предстоит угадать число от 0 до 100"
    private let error = "Ошибка! Введите число от 0 до 100"
    private let success = "Молодец! Ты угадал :)"
    private let repeatSuccess = "Давай поиграем еще? Число от 0 до 100"
    private let many = "Я загадал меньше, попробуй еще :)"
    private let few = "Я загадал больше, попробуй еще :)"
    private let answer = "Загаданное число"
    private let newVar = "Я загадал снова"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoText.text = nil
        startGame()
    }
    
    @IBAction func checkButton(_ sender: Any) {
        if let text = answerUser.text, let value = Int(text){
            userVar = value
            mainText.text = base
            comparison()
        } else {
            mainText.text = error
            clearTextField()
        }
    }
    
    func comparison(){
        if userVar == randomVar {
            infoText.text = success
            removeKeyboard()
            mainText.text = repeatSuccess
            startGame()
            
        } else if userVar > randomVar {
            infoText.text = many
        } else {
            infoText.text = few
        }
        clearTextField()
    }
    
    @IBAction func fail(_ sender: Any) {
        mainText.text = "\(answer) \(randomVar)!"
        infoText.text = newVar
        removeKeyboard()
        clearTextField()
        startGame()
    }
    
    func startGame(){
        randomVar = Int.random(in: 0...100)
    }
    
    func clearTextField(){
        answerUser.text = nil
    }
    
    func removeKeyboard(){
        answerUser.resignFirstResponder()
    }
}
