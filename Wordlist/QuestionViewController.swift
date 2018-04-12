//
//  QuestionViewController.swift
//  Wordlist
//
//  Created by Marina Goto on 2018/04/12.
//  Copyright © 2018年 lifeistech. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    var isAnswered: Bool = false //回答or次の問題にいくかの判定
    var wordArray: [Dictionary<String, String>] = [] //UserDefaultsの配列
    var shuffleWordArray: [Dictionary<String, String>] = [] //シャッフル配列
    var nowNumber: Int = 0 //回答数
    
    let saveData = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        answerLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    //view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wordArray = saveData.array(forKey: "WORD") as! [Dictionary<String, String>]
        //shuffle
        shuffle()
        questionLabel.text = shuffleWordArray[nowNumber]["english"]
    }
    
    //shuffle
    func shuffle() {
        while wordArray.count > 0 {
            let index = Int(arc4random()) % wordArray.count
            shuffleWordArray.append(wordArray[index])
            wordArray.remove(at: index)
        }
    }
    
    @IBAction func nextButtonTapped() {
        //回答したか
        if isAnswered {
            //次の問題
            nowNumber += 1
            answerLabel.text = ""
            
            //次の問題を表示するか
            if nowNumber < shuffleWordArray.count {
                //表示
                questionLabel.text = shuffleWordArray[nowNumber]["english"]
                // false
                isAnswered = false
                // ボタンのタイトル変更
                nextButton.setTitle("答えを表示", for: .normal)
            } else {
                // finish
                self.performSegue(withIdentifier: "toFinishView", sender: nil)
            }
        } else {
            //答えを表示
            answerLabel.text = shuffleWordArray[nowNumber]["japanese"]
            //true
            isAnswered = true
            //ボタンのタイトル変更
            nextButton.setTitle("次へ", for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
