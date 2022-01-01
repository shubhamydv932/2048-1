//
//  ViewController.swift
//  2048
//
//  Created by Shubham on 12/22/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var holder : UIView!
    
    var endGame : Bool = true
    
    
    var matrix : [[Int]] = [[0,0,0,0] , [0,0,0,0] , [0,0,0,0] , [0,0,0,0]]
    var updatedScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipe))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)

    
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipe))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)

    
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(upSwipe))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)

    
        let swipeBottom = UISwipeGestureRecognizer(target: self, action: #selector(bottomSwipe))
        swipeBottom.direction = .down
        self.view.addGestureRecognizer(swipeBottom)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        holder.backgroundColor = .white
        gameScreen()
        

    }
   
    
    private  func gameScreen(){
        newNumber()
        let boxSize : CGFloat = holder.frame.size.width / 4;
        
        
        let autoGestureButton = UIButton(frame: CGRect(x: 10, y: 10, width: boxSize + 50, height: boxSize - 30))
        autoGestureButton.setTitle("AUTOPLAY", for: .normal)
        autoGestureButton.setTitleColor(.green, for: .normal)
        autoGestureButton.backgroundColor = .lightGray
        autoGestureButton.addTarget(self, action: #selector(autoGestures(_:)), for: .touchUpInside)
        holder.addSubview(autoGestureButton)
        
        for i in 0..<4{
            for j in 0..<4{
                let box1 = UILabel(frame: CGRect(x: CGFloat(j) * boxSize, y: boxSize * CGFloat(i) + 200, width: boxSize, height: boxSize))
                box1.textColor = .black
                box1.backgroundColor = .lightGray
                box1.textAlignment = .center
                box1.text = "\(matrix[i][j])"
                holder.addSubview(box1)
            }
        }
        
        let scoreLabel = UILabel(frame: CGRect(x: 210, y: 100, width: boxSize + 5, height: boxSize - 30))
        scoreLabel.textColor = .white
        scoreLabel.text = "score : \(updatedScore)"
        scoreLabel.font = UIFont(name: "Arial ", size: 20)
        scoreLabel.backgroundColor = .lightGray
        holder.addSubview(scoreLabel)
        
        let mainLabel = UILabel(frame: CGRect(x: 10, y: 30, width: boxSize + 100, height: boxSize + 100))
        mainLabel.text = "2048"
        mainLabel.font = UIFont(name: "Arial", size: 50)
        mainLabel.textColor = .lightGray
        holder.addSubview(mainLabel)
    }
    
    // to assign 2 at random spots    ??? how to assign 2 at random two positions in beginning

    @objc func newNumber(){
        var numberGenerated : Bool = false
        while numberGenerated == false{
            let i = Int.random(in: 0...3)
            let j = Int.random(in: 0...3)
            if matrix[i][j] == 0{
                matrix[i][j] = 2
                numberGenerated = true
            }
        }
    }
    
    
    // for left swipe gesture
    
    @objc func leftSwipe(){
        for i in 0..<4{
            var counter = 0
            for j in 0..<4{
                if matrix[i][j] != 0{
                    matrix[i][counter] = matrix[i][j]
                    counter += 1
                }
            }
        }
        
        
        for i in 0..<4{
            for j in 0..<3{
                if matrix[i][j] == matrix[i][j+1]{
                    matrix[i][j] = 2 * matrix[i][j]
                    updatedScore = updatedScore + matrix[i][j]
                    for k in j+1..<4{
                        if k == 3{
                            matrix[i][k] = 0
                        }
                        else{
                            matrix[i][k] = matrix[i][k+1]
                        }
                    }
                }
            }
        }
        gameScreen()
    }
    
    // for right swipe gesture
    
    @objc func rightSwipe(){
        for i in 0..<4{
            var counter = 3
            for j in stride(from: 3, through: 0, by: -1){
                if matrix[i][j] != 0{
                    matrix[i][counter] = matrix[i][j]
                    counter -= 1
                }
            }
        }
        
        for i in 0..<4{
            for j in stride(from: 3, through: 1, by: -1){
                if matrix[i][j] == matrix[i][j-1]{
                    matrix[i][j] = 2 * matrix[i][j]
                    updatedScore = updatedScore + matrix[i][j]
                    for k in stride(from: j-1, through: 0, by: -1){
                        if k == 0{
                            matrix[i][k] = 0
                        }
                        else{
                            matrix[i][k] = matrix[i][k-1]
                        }
                    }
                }
            }
        }
        
        gameScreen()
    }
    
    // for up swipe gesture
    
    @objc func upSwipe(){
        for j in 0..<4{
            var counter = 0
            for i in 0..<4{
                if matrix[i][j] != 0{
                    matrix[counter][j] = matrix[i][j]
                    counter += 1
                }
            }
        }
        
        
        for j in 0..<4{
            for i in 0..<3{
                if matrix[i][j] == matrix[i+1][j]{
                    matrix[i][j] = 2 * matrix[i][j]
                    updatedScore = updatedScore + matrix[i][j]
                    for k in i+1..<4{
                        if k == 3{
                            matrix[k][j] = 0
                        }
                        else{
                            matrix[k][j] = matrix[k+1][j]
                        }
                    }
                }
            }
        }
        
        gameScreen()
    }
    
    // for bottom swipe
    
    @objc func bottomSwipe(){
        for j in 0..<4{
            var counter = 3
            for i in stride(from: 3, through: 0, by: -1){
                if matrix[i][j] != 0{
                    matrix[counter][j] = matrix[i][j]
                    counter -= 1
                }
            }
        }
        
        for j in 0..<4{
            for i in stride(from: 3, through: 1, by: -1){
                if matrix[i][j] == matrix[i-1][j]{
                    matrix[i][j] = 2 * matrix[i][j]
                    updatedScore = updatedScore + matrix[i][j]
                    for k in stride(from: i-1, through: 0, by: -1){
                        if k == 0{
                            matrix[k][j] = 0
                        }
                        else{
                            matrix[k][j] = matrix[k-1][j]
                        }
                    }
                }
            }
        }

        gameScreen()
    }
    
    @objc func autoGestures(_ sender : UIButton){
        DispatchQueue.main.async {
            self.detectEndGame()
            while  self.endGame == false{
                let autoGesture = Int.random(in: 0...3)
                switch autoGesture{
                    case 0:
                        self.leftSwipe()
                    case 1:
                        self.rightSwipe()
                    case 2:
                        self.upSwipe()
                    case 3:
                        self.bottomSwipe()
                    default:
                        self.gameEnded()
                        
                }
            }
        }

    }
    
    
    @objc func gameEnded(){
        detectEndGame()
        if endGame == true{
            view.backgroundColor = .black
        }
    }
    
    
    private func detectEndGame(){
        for i in 0...3{
            for j in 0...2{
                if matrix[i][j] == matrix[i][j+1]{
                    endGame = false
                }
            }
            
        }
        
        for j in 0...3{
            for i in 0...2{
                if matrix[i][j] == matrix[i+1][j]{
                    endGame = false
                }
            }
            
        }
        
        for i in 0...3{
            for k in 0...3{
                if matrix[i][k] == 0{
                    endGame = false
                }
            }
        }
        
    }
    
//    private func updateScore() -> Int{
//        for i in 0...3{
//            for j in 0...3{
//                if matrix[i][j] > 2{
//                    updatedScore = updatedScore + matrix[i][j]
//                }
//            }
//        }
//        return updatedScore
//    }


}


// end game detect. display game over
// auto play button
// score update
