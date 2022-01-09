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
    var autoPlayButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 205, y: 50, width: 100, height: 30))
        button.setTitle("AUTOPLAY", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = UIFont(name: "Arial", size: 15)
        button.addTarget(self, action: #selector(autoGestures(_:)), for: .touchUpInside)
        return button
    }()
    
    var  gameEndLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 10, width: 120, height:  50))
        label.text = "game not ended"
        label.font = UIFont(name: "Arial", size: 20)
        label.textColor = .white
        return label
    }()

    
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

        holder.backgroundColor = .clear
        gameScreenInMain()

    }
   
    private func gameScreenInMain() {
        DispatchQueue.main.async {
            self.gameScreen()
        }
    }
    private  func gameScreen(){
        newNumber()
        let boxSize : CGFloat = holder.frame.size.width / 4;
        
        let backView = UIView(frame: CGRect(x: 0, y: 200, width: boxSize * 4 + 5, height: boxSize * 4 + 4))
        backView.backgroundColor = .lightGray
        holder.addSubview(backView)
        
        
//        autoPlayButton.setTitle("AUTOPLAY", for: .normal)
//        autoPlayButton.setTitleColor(.black, for: .normal)
//        autoPlayButton.backgroundColor = .orange
//        autoPlayButton.addTarget(self, action: #selector(autoGestures(_:)), for: .touchUpInside)
        holder.addSubview(autoPlayButton)
        
        for i in 0..<4{
            for j in 0..<4{
                let box1 = UILabel(frame: CGRect(x: CGFloat(j) * boxSize + 3, y: boxSize * CGFloat(i) + 206, width: boxSize - 7, height: boxSize - 7))
                box1.textColor = .black
                box1.backgroundColor = colourAssign(number: matrix[i][j])
                box1.textAlignment = .center
                if matrix[i][j] == 0{
                    box1.text = ""
                }
                else{
                    box1.text = "\(matrix[i][j])"
                }
                holder.addSubview(box1)
            }
        }
        
        let scoreLabel = UILabel(frame: CGRect(x: 210, y: 100, width: boxSize + 10, height: boxSize - 30))
        scoreLabel.textColor = .white
        scoreLabel.text = "score : \(updatedScore)"
        scoreLabel.font = UIFont(name: "Arial ", size: 10)
        scoreLabel.backgroundColor = .lightGray
        scoreLabel.textAlignment = .center
        holder.addSubview(scoreLabel)
        
        let mainLabel = UILabel(frame: CGRect(x: 10, y: 0, width: boxSize + 100, height: boxSize + 100))
        mainLabel.text = "2048"
        mainLabel.font = UIFont(name: "Arial", size: 50)
        mainLabel.textColor = .lightGray
        holder.addSubview(mainLabel)
        
        holder.addSubview(gameEndLabel)

    }
    
    // to give diff colours to blocks based on their number
    
    private func colourAssign(number : Int) -> UIColor{
        
            let base = 0xf0ddc9
            let high = 0xf07e05
            var currcolour = base
            let increment = (high - base)/100
            var x = 1
            if number != 0{
                while number >= 2^x{
                    x += 1
                }
            }
            currcolour = base - increment * x
            
            return UIColor(
                red: CGFloat((currcolour & 0xFF0000) >> 16) / 255.0,
                green:CGFloat((currcolour & 0x00FF00) >> 8) / 255.0 ,
                blue: CGFloat(currcolour & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        
        
    }
    
    // to assign 2 at random spots    ??? how to assign 2 at random two positions in beginning

    private func newNumber(){
        DispatchQueue.global(qos: .background).async {                                      //**********
            var numberGenerated : Bool = false
            while numberGenerated == false{
                let i = Int.random(in: 0...3)
                let j = Int.random(in: 0...3)
                if self.self.matrix[i][j] == 0{
                    self.self.matrix[i][j] = 2
                    numberGenerated = true
                }
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
        gameScreenInMain()
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
        
        gameScreenInMain()
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
        
        gameScreenInMain()
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

        gameScreenInMain()
    }
    
    @objc func autoGestures(_ sender : UIButton){
        DispatchQueue.global(qos: .background).async {
            self.detectEndGame()
            var counter = 0
            var prevnum = 5
            while  self.endGame == false{
                let autoGesture = Int.random(in: 0...3)
                if prevnum != autoGesture{
                     prevnum = autoGesture
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
                counter += 1
                print("inside while loop \(counter)")
                usleep(100000)
                self.detectEndGame()
            }
            print("game ended")
            self.gameEnded()
        }

    }
    
    
    @objc func gameEnded(){
        detectEndGame()
        if endGame == true{
            DispatchQueue.main.async {
//                self.autoPlayButton.setTitle("GAME ENDED!", for: .normal)
//                self.autoPlayButton.setTitleColor(.black, for: .normal)
//                self.autoPlayButton.backgroundColor = .red
                self.gameEndLabel.text = "GAME OVER!"
                self.gameEndLabel.font = UIFont(name: "Arial", size: 15)
                self.gameEndLabel.textColor = .red
                
            }
        }
    }
    
    
    private func detectEndGame(){
        for i in 0...3{
            for j in 0...2{
                if matrix[i][j] == matrix[i][j+1]{
                    endGame = false
                    return
                }
            }
            
        }
        
        for j in 0...3{
            for i in 0...2{
                if matrix[i][j] == matrix[i+1][j]{
                    endGame = false
                    return
                }
            }
            
        }
        
        for i in 0...3{
            for k in 0...3{
                if matrix[i][k] == 0{
                    endGame = false
                    return
                }
            }
        }
        endGame = true
        return
        
    }
    


}


// to do -
// dont pick same num again


// blank if 0

// why autplay declaration inside  gamescreen doesnt work
//score label
