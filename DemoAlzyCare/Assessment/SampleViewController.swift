//
//  SampleViewController.swift
//  AssessmentSample
//
//  Created by Gaurav on 29/05/24.
//

import UIKit

class SampleViewController: UIViewController {
    
    var answer: String = ""
    var currentQuestionType: QuestionType = .none
    var CurrentCategoryType: CategoryType = .none
    var userResponse: String = ""
    
    
    @IBOutlet var assessmentProgressView: UIProgressView!
    @IBOutlet var assessmentQuestionLabel: UILabel!
    @IBOutlet var nextQuestionButton: UIButton!
    
    
    @IBOutlet var textFeildStack: UIStackView!
    @IBOutlet var textFeildView: UITextField!
    
    
    @IBOutlet var optionsStack: UIStackView!
    @IBOutlet var optionButtons: [UIButton]!
    
    
    
    @IBOutlet var textViewStack: UIStackView!
    @IBOutlet var textViewLabel: UILabel!
    
    
    @IBOutlet var imageOptionsStack: UIStackView!
    @IBOutlet var imageOptionView: UIImageView!
    @IBOutlet var imageOptionButtons: [UIButton]!
    
    var questionIndex = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Reset scores when starting a new test
            resetScores()
            
            setupTapGesture()
            updateUI()
            // Do any additional setup after loading the view.
        }
        
        func resetScores() {
            userScore.totalScore = 0
            userScore.executiveFunctionScore = 0
            userScore.logicScore = 0
            userScore.memoryScore = 0
            userScore.reasoningScore = 0
        }
        
        func updateUI() {
            let index = assessmentQuestions[questionIndex].randomElement()
            assessmentQuestionLabel.text = index?.questionText
            currentQuestionType = index!.questionType
            CurrentCategoryType = index!.categoryType
            nextQuestionButton.isEnabled = false
            
            if let currentAnswer = index?.correctAnswer {
                answer = currentAnswer
            }
            resetButtonStates()
            
            textFeildStack.isHidden = true
            optionsStack.isHidden = true
            textViewStack.isHidden = true
            imageOptionsStack.isHidden = true
            
            switch index?.questionType {
            case .textField:
                textFeildStack.isHidden = false
                
            case .textViewLabel:
                textViewStack.isHidden = false
                textViewLabel.text = index?.questionTextLabel
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [self] in
                    nextQuestionButton.isEnabled = true
                }
                
            case .options:
                optionButtons[0].setTitle(index?.options?[0], for: .normal)
                optionButtons[1].setTitle(index?.options?[1], for: .normal)
                optionButtons[2].setTitle(index?.options?[2], for: .normal)
                optionButtons[3].setTitle(index?.options?[3], for: .normal)
                optionsStack.isHidden = false
                
            case .questionImageView:
                imageOptionView.image = UIImage(named: index?.questionImage ?? "")
                imageOptionButtons[0].setTitle(index?.options?[0], for: .normal)
                imageOptionButtons[1].setTitle(index?.options?[1], for: .normal)
                imageOptionButtons[2].setTitle(index?.options?[2], for: .normal)
                imageOptionButtons[3].setTitle(index?.options?[3], for: .normal)
                imageOptionsStack.isHidden = false
                
            default:
                break
            }
            
            let totalQuestions = assessmentQuestions.count
            let progress = Float(questionIndex + 1) / Float(totalQuestions)
            assessmentProgressView.setProgress(progress, animated: true)
        }
        
        func resetButtonStates() {
            // Reset option buttons
            for button in optionButtons {
                button.backgroundColor = .systemBackground
            }
            // Reset image option buttons
            for button in imageOptionButtons {
                button.backgroundColor = .systemBackground
            }
        }
        
        func updateScore() {
            userScore.totalScore += 2
            print("score - \(userScore.totalScore)")
            
            switch CurrentCategoryType {
            case .executiveFunction:
                userScore.executiveFunctionScore += 2
            case .logic:
                userScore.logicScore += 2
            case .memory:
                userScore.memoryScore += 2
            case .reasoning:
                userScore.reasoningScore += 2
            default:
                print("Hello")
            }
        }
        
        func checkAnswer(userResponse: String) {
            switch currentQuestionType {
            case .options, .questionImageView, .textField:
                if userResponse == answer {
                    updateScore()
                }
            default:
                print("Hello")
            }
        }
        
        @IBAction func nextQuestionButtonTapped(_ sender: UIButton) {
            if questionIndex < 11 {
                questionIndex += 1
            } else {
                questionIndex = 0
                print(userScore.totalScore)
                print(userScore.reasoningScore)
                print(userScore.executiveFunctionScore)
                print(userScore.memoryScore)
                print(userScore.logicScore)
                performSegue(withIdentifier: "Result", sender: .none)
            }
            checkAnswer(userResponse: userResponse)
            updateUI()
        }
        
        @IBAction func optionButtonTapped(_ sender: UIButton) {
            resetButtonStates()
            sender.backgroundColor = UIColor(red: 204.0/255.0, green: 187.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            userResponse = sender.titleLabel!.text!
            nextQuestionButton.isEnabled = true
        }
        
        @IBAction func imageOptionButtonTapped(_ sender: UIButton) {
            resetButtonStates()
            sender.backgroundColor = UIColor(red: 204.0/255.0, green: 187.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            userResponse = sender.titleLabel!.text!
            nextQuestionButton.isEnabled = true
        }
        
        @IBAction func textFeildEdited(_ sender: UITextField) {
            userResponse = sender.text!
            print(userResponse)
            nextQuestionButton.isEnabled = true
        }
        
        private func setupTapGesture() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
        }
        
        @objc private func dismissKeyboard() {
            view.endEditing(true)
        }
    }
