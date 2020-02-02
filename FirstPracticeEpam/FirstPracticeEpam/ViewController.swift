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
    
    var randomVar: Int = 0
    var userVar: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoText.text = nil
        main()
    }
    
    //Кнопка "проверить"
    @IBAction func checkButton(_ sender: Any) {
        let check: Bool = true
        if check == checkUserVar(){
            mainText.text = "Тебе предстоит угадать число от 0 до 100"
            comparison()
        } else {
            mainText.text = "Ошибка! Введите число от 0 до 100"
            clearTextField()
        }
    }
    
    //Функция сравнения 2х значений
    func comparison(){
        if userVar == randomVar {
            infoText.text = "Молодец! Ты угадал :)"
            removeKeyboard()
            mainText.text = "Давай поиграем еще? Число от 0 до 100"
            main()
            clearTextField()
            
        } else if userVar > randomVar {
            infoText.text = "Я загадал меньше, попробуй еще :)"
            clearTextField()
        } else if userVar < randomVar {
            infoText.text = "Я загадал больше, попробуй еще :)"
            clearTextField()
        }
    }
    
    //Кнопка "сдаться"
    @IBAction func fail(_ sender: Any) {
        infoText.text = "Я загадал снова"
        mainText.text = "Загаданное число \(randomVar)!"
        removeKeyboard()
        clearTextField()
        main()
    }
    
    //Генератор случайного числа
    func generateValue() -> Int {
        return Int.random(in: 0...100)
    }
    
    //Получение значения
    func main(){
        randomVar = generateValue()
    }
    
    //Проверка на Int
    func checkUserVar() -> Bool{
        if let text = answerUser.text, let value = Int(text){
            userVar = value
            return true
        } else {
            return false
        }
    }
    
    //Очистка поля от старого значения
    func clearTextField(){
        answerUser.text = nil
    }
    
    //Функция скрывает клавиатуру
    func removeKeyboard(){
        answerUser.resignFirstResponder()
    }
}
