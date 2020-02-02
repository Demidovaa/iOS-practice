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
    
    static let base = "Тебе предстоит угадать число от 0 до 100"
    static let error = "Ошибка! Введите число от 0 до 100"
    static let success = "Молодец! Ты угадал :)"
    static let repeatSuccess = "Давай поиграем еще? Число от 0 до 100"
    static let many = "Я загадал меньше, попробуй еще :)"
    static let few = "Я загадал больше, попробуй еще :)"
    static let answer = "Загаданное число"
    static let newVar = "Я загадал снова"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoText.text = nil
        startGame()
    }
    
    @IBAction func checkButton(_ sender: Any) {
        if let text = answerUser.text, let value = Int(text){
            userVar = value
            mainText.text = ViewController.base
            comparison()
        } else {
            mainText.text = ViewController.error
            clearTextField()
        }
    }
    
    func comparison(){
        if userVar == randomVar {
            infoText.text = ViewController.success
            removeKeyboard()
            mainText.text = ViewController.repeatSuccess
            startGame()
            clearTextField()
            
        } else if userVar > randomVar {
            infoText.text = ViewController.many
            clearTextField()
        } else {
            infoText.text = ViewController.few
            clearTextField()
        }
    }
    
    @IBAction func fail(_ sender: Any) {
        mainText.text = ViewController.answer + " " + String(randomVar) + "!"
        infoText.text = ViewController.newVar
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
