//
//  ViewController.swift
//  2048
//
//  Created by Shubham on 12/22/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var holder : UIView!
    
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
    
    var matrix : [[Int]] = [[0,0,0,0] , [0,0,0,0] , [0,0,0,0] , [0,0,0,0]]
    let updatedScore = ""
    
    
    
    
    
    private func gameScreen(){
        newNumber()
        let boxSize : CGFloat = holder.frame.size.width / 4;
        
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
    
   // func to find number of non zero elements in a row
    @objc func numRow(array : [Int]) -> Int{
        var count = 0
        for i in 0..<4{
            if array[i] != 0{
                count += 1
            }
        }
        return count
    }
    
    // for left swipe gesture
    
    @objc func leftSwipe(){
        var counter = 0
        for i in 0..<4{
            for j in 0..<4{
                if matrix[i][j] != 0{
                    matrix[i][counter] = matrix[i][j]
                    counter += 1
                }
            }
        }
        
        
        for i in 0..<4{
            var numberOfElements = numRow(array: matrix[i])
            if numberOfElements == 2{
                for j in 0..<2{
                    if matrix[i][j] == matrix[i][j+1]{
                        matrix[i][j] = matrix[i][j] + matrix[i][j+1]
                        matrix[i][j+1] = 0
                    }
                }
            }
            else if numberOfElements == 3{
                for j in 0..<2{
                    if matrix[i][j] == matrix[i][j+1]{
                        matrix[i][j] = matrix[i][j] + matrix[i][j+1]
                        matrix[i][j+1] = matrix[i][j+2]
                        matrix[i][j+2] = 0
                    }
                }
            }
            else if numberOfElements == 4{
                for j in 0..<
            }
        }
    }
    
    // for right swipe gesture
    
    @objc func rightSwipe(){
        var counter = 3
        for i in 0..<4{
            for j in stride(from: 3, through: 0, by: -1){
                if matrix[i][j] != 0{
                    matrix[i][counter] = matrix[i][j]
                    counter -= 1
                }
            }
        }
        
        
        for i in 0..<4{
            for j in stride(from: 3, to: 0, by: -1){
                if matrix[i][j] == matrix[i][j-1]{
                    matrix[i][j] = matrix[i][j] + matrix[i][j-1]
                }
            }
        }
        
    }
    
    // for up swipe gesture
    
    @objc func upSwipe() -> [[Int]]{
        var counter = 0
        for j in 0..<4{
            for i in 0..<4{
                if matrix[i][j] != 0{
                    matrix[counter][j] = matrix[i][j]
                    counter += 1
                }
            }
        }
        
        
        for j in 0..<4{
            for i in 0..<4{
                if matrix[i][j] == matrix[i+1][j]{
                    matrix[i][j] = matrix[i][j] + matrix[i+1][j]
                }
            }
        }
        
        return matrix
    }
    
    // for bottom swipe
    
    @objc func bottomSwipe(){
        var counter = 3
        for j in 0..<4{
            for i in stride(from: 3, through: 0, by: -1){
                if matrix[i][j] != 0{
                    matrix[counter][j] = matrix[i][j]
                    counter -= 1
                }
            }
        }
        
        
//        for j in 0..<4{
//            for i in 3...0{
//                if matrix
//            }
//        }
        
        
    }
    
    // to update the score
    
//    @objc func updateScore() -> Int {
//
//    }


}

