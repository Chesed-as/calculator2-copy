//
//  ViewController.swift
//  calculator2
//
//  Created by 韩蕊泽 on 2018/10/28.
//  Copyright © 2018 韩蕊泽. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var screenL: UILabel!
    
    var value1: Double = 0.0
    var value2: Double = 0.0
    var valueT: Double = 0.0
    var result: Double = 0.0
    var operatorFlag: String = ""
    var isDecimalPoint: Bool = false
    var isValue2: Bool = false
    var isOperator: Bool = false
    var isResult: Bool = false
    var error: Bool = false
    
    @IBAction func number(_ sender: UIButton) {
      if !error //若显示错误，则未清屏前不可继续输入任何信息
      { if ((screenL.text == "0" || isResult) && isDecimalPoint == false)
        {screenL.text = ""} //准备开始输入一个新运算数
        if (isOperator == false)
        {
            screenL.text = screenL.text! + sender.currentTitle! //输入第一个运算数的过程
        }
        else{
            if (isValue2 == false)//已输入运算符，但还没有开始输入第二个运算数
            {
                screenL.text = sender.currentTitle //清屏并开始输入第二个运算数
                isDecimalPoint = false //记第二个运算数尚未输入小数点
                isValue2 = true //标记第二个运算数开始输入
            }
            else {screenL.text = screenL.text! + sender.currentTitle!} //输入第二个运算数的过程
        }
      }
    }
    
    @IBAction func point(_ sender: UIButton) {
      if !error
      {
        if !isResult
        {if !isDecimalPoint {screenL.text = screenL.text! + "."; isDecimalPoint = true} }//按按钮后如果未输入过小数点就添加小数点}
        else {screenL.text = "0."; isDecimalPoint = true}
      }
    }
    
    @IBAction func sign(_ sender: UIButton) {
      if !error{
        if !isOperator //如果尚未添加运算符，则把按下运算符时屏幕显示的文本强制转换成double值赋给第一个运算数，同时记录下点击了哪个运算符
        {
            value1 = NSString(string: screenL.text!).doubleValue
            isOperator = true
            switch sender.currentTitle!{
            case "+" : operatorFlag = "+"
            case "-" : operatorFlag = "-"
            case "×" : operatorFlag = "*"
            case "÷" : operatorFlag = "/"
            default : operatorFlag = ""
            }
        }
        else //如果已经添加过运算符，那么此时（再次点击运算符时）为实现连续运算功能，把屏幕信息赋给第二个运算数；通过上一次点击时记录下来的运算符进行相应运算，把结果重新赋给第一个运算数并显示在屏幕上。
        {
            value2 = NSString(string: screenL.text!).doubleValue
            switch operatorFlag {
            case "+" : value1 = value1 + value2
            case "-" : value1 = value1 - value2
            case "*" : value1 = value1 * value2
            case "/" : if (operatorFlag == "/" && value2 == 0.0)
                       {   error = true //除数为零，记为错误
                           operatorFlag = ""
                           isOperator = false   }
                       else{result = value1 / value2}
            default : break
            }
            if(!error){screenL.text = "\(value1)"}
            else{screenL.text = "Error: Divisor must not be zero."}
            isValue2 = false //又是新一轮的运算，此时重回“按过运算符而未输入第二个运算数的状态
            switch sender.currentTitle! //记录运算符
            {
            case "+" : operatorFlag = "+"
            case "-" : operatorFlag = "-"
            case "×" : operatorFlag = "*"
            case "÷" : operatorFlag = "/"
            default : operatorFlag = ""
            }
        }
      }
    }
    
    @IBAction func resultSign(_ sender: UIButton) {
        if isValue2 //若输入第二个运算数的过程中按下等号，即该运算数停止输入；记录下第二运算数的值
        { value2 = NSString(string: screenL.text!).doubleValue }
        
        switch operatorFlag {
        case "+" : result = value1 + value2
        case "-" : result = value1 - value2
        case "*" : result = value1 * value2
        case "/" :if (operatorFlag == "/" && value2 == 0.0)
                  {   error = true //除数为零，记为错误
                      operatorFlag = ""
                      isOperator = false   }
                  else{result = value1 / value2}
        default : break
        }
        isResult = true //作为显示结果后不再继续添加数字或小数点的判断
        isValue2 = false //用于实现连续运算
        isOperator = false //以便实现连续运算功能，使显示结果后又点击运算符时，可以将屏幕内容赋给第一个运算数
        if(!error){screenL.text = "\(result)"}
        else{screenL.text = "Error: Divisor must not be zero."}
    }
    
    @IBAction func persentSign(_ sender: UIButton) {
      if !error{
        valueT = NSString(string: screenL.text!).doubleValue
        valueT = 0.01 * valueT
        screenL.text = "\(valueT)"}
    }
    
    @IBAction func allClear(_ sender: UIButton) {
        value1 = 0.0
        value2 = 0.0
        result = 0.0
        operatorFlag = ""
        isDecimalPoint = false
        isValue2 = false
        isOperator = false
        isResult = false
        screenL.text = "0"
        error = false  }
}
