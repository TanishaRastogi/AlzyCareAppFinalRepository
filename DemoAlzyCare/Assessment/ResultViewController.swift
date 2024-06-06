//
//  ResultViewController.swift
//  AssessmentSample
//
//  Created by Gaurav on 31/05/24.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var totalLabel: UILabel!
    
    @IBOutlet var memoryLabel: UILabel!
    
    @IBOutlet var LogicLabel: UILabel!
    
    @IBOutlet var executiveLabel: UILabel!
    @IBOutlet var resoningLabel: UILabel!
    
    
    @IBOutlet var totalProgressView: CircularProgressView!
    
    @IBOutlet var memoryProgressView: UIProgressView!
    @IBOutlet var logicProgressView: UIProgressView!
    @IBOutlet var executiveProgressView: UIProgressView!
    @IBOutlet var reasoningProgressView: UIProgressView!
    
    
    @IBOutlet var updateLabelBasedOnScore: UILabel!
    
    @IBOutlet var continueToPlannerButton: UIButton!
    
    
    
    let maxTotalScore = 22
    let maxMemoryScore = 8
    let maxLogicScore = 4
    let maxReasoningScore = 4
    let maxExecutiveFunctionScore = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        // Calculate percentages
        let totalPercentage = calculatePercentage(score: userScore.totalScore, maxScore: maxTotalScore)
        let memoryPercentage = calculatePercentage(score: userScore.memoryScore, maxScore: maxMemoryScore)
        let logicPercentage = calculatePercentage(score: userScore.logicScore, maxScore: maxLogicScore)
        let reasoningPercentage = calculatePercentage(score: userScore.reasoningScore, maxScore: maxReasoningScore)
        let executivePercentage = calculatePercentage(score: userScore.executiveFunctionScore, maxScore: maxExecutiveFunctionScore)
        
        // Update labels to show percentages
        totalLabel.text = "\(totalPercentage)%"
        memoryLabel.text = "\(memoryPercentage)%"
        LogicLabel.text = "\(logicPercentage)%"
        resoningLabel.text = "\(reasoningPercentage)%"
        executiveLabel.text = "\(executivePercentage)%"
        
        // Update progress views to reflect percentages
        memoryProgressView.progress = Float(memoryPercentage) / 100.0
        logicProgressView.progress = Float(logicPercentage) / 100.0
        reasoningProgressView.progress = Float(reasoningPercentage) / 100.0
        executiveProgressView.progress = Float(executivePercentage) / 100.0
        
        // Update circular progress view for total score
        totalProgressView.setProgressWithAnimation(duration: 1.0, value: Float(totalPercentage) / 100.0)
        
        // Update label based on total score
        updateLabelBasedOnTotalScore(totalPercentage)
    }
    
    func updateLabelBasedOnTotalScore(_ totalPercentage: Int) {
        if totalPercentage >= 77 {
            updateLabelBasedOnScore.text = "Your test results indicate that you are at no risk of Alzheimer's."
            continueToPlannerButton.isHidden = false
        } else if totalPercentage >= 68 && totalPercentage <= 76 {
            updateLabelBasedOnScore.text = "Your test results suggest you might be in the mild stage of Alzheimer's."
            continueToPlannerButton.isHidden = false
        } else {
            updateLabelBasedOnScore.text = "Your test results indicate you might be severely affected by Alzheimer's, and it's advisable to consult a specialist"
            continueToPlannerButton.isHidden = true
        }
    }
    
    func calculatePercentage(score: Int, maxScore: Int) -> Int {
        return Int((Double(score) / Double(maxScore)) * 100)
    }
    @IBAction func exitButtonTapped(_ sender: UIBarButtonItem) {
        // Reset all scores
        userScore.totalScore = 0
            userScore.memoryScore = 0
            userScore.logicScore = 0
            userScore.reasoningScore = 0
            userScore.executiveFunctionScore = 0
            
            // Print to confirm reset (for debugging)
            print("Scores reset to 0")
            
            // Navigate back to the initial screen or dismiss the view controller
            self.navigationController?.popToRootViewController(animated: true)
    }
}
