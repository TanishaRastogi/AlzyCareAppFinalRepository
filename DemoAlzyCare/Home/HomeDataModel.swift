//
//  HomeDataModel.swift
//  DemoAlzyCare
//
//  Created by Batch-2 on 03/06/24.
//

import Foundation

struct category{
    var image: String
    var name: String
}

struct SuggestedGame{
    var gameImage: String
    var gameName: String
}

struct ProfileInfo{
    let userName: String
    var userEmoji: String
    let userEmail: String
    let userPhoneNumber: String
    let userAddress: String
    let userDOB: Date
    
//    if true then male and caregiver, else female or patient
    let userType: Bool
    let userGender: Bool
    
}

let userProfile = ProfileInfo(userName: "Gaurav Mishra", userEmoji: "", userEmail: "david@gmail.com", userPhoneNumber: "+91-8882445490", userAddress: "Delhi", userDOB: Date(), userType: true, userGender: true)

class SuggestedDataModel{
    static var suggestedGames = [SuggestedGame(gameImage: "Word Puzzle", gameName: "Word Puzzle"), SuggestedGame(gameImage: "Hangman", gameName: "Hangman"), SuggestedGame(gameImage: "ScattergoriesBox", gameName: "ScattergoriesBox"), SuggestedGame(gameImage: "Guess the Time", gameName: "Guess the Time"), SuggestedGame(gameImage: "Calculate", gameName: "Calculate")]
}

//class DataModel{
//    static var categories = [category(image: "Diary", name: "Diary"), category(image: "Meditation", name: "Meditation"), category(image: "Story Book", name: "Story Book")]
//}

//import Foundation
//struct PersonalInfo{
//    let userName: String
//    let userFatherName: String
//    let userMotherName: String
//    let userPhoneNumber: String
//    let userCountryName: String
//    let userCityName: String
//    let userBirthDate: String
//    let userBirthMonth: String
//    let userBirthYear: String
//    let userSchoolName: String
//
//}
//
//let userPersonalInfo = PersonalInfo(userName: "gaurav", userFatherName: "ram babu mishra", userMotherName: "madhu mishra", userPhoneNumber: "8882445490", userCountryName: "india", userCityName: "delhi", userBirthDate: "30", userBirthMonth: "january", userBirthYear: "1", userSchoolName: "asvj")
//
//struct Question {
//    let questionText: String
//    let options: [String]?
//    let correctAnswer: String?
//    let questionImage: String?
//    let questionTextLabel: String?
//    let questionMultiOptions: [String]?
//    let questionType: QuestionType
//    let categoryType: CategoryType
//}
//
//enum CategoryType{
//    case memory, logic, reasoning, executiveFunction
//}
//
//enum QuestionType{
//    case textFeild, questionImageView, options, textViewLabel
//}
//
//
//
////struct Category {
////    let name: String
////    var questions: [Question]
////}
//
//
//var question1 = [Question(questionText: "What is your Birth date?", options: nil, correctAnswer: userPersonalInfo.userBirthDate, questionImage: nil, questionTextLabel: nil, questionMultiOptions: nil, questionType: .textFeild, categoryType: .memory)]
//
//var question2 = [Question(questionText: "Name the picture.", options: ["Dog", "Cat", "Lion", "Horse"], correctAnswer: "Dog", questionImage: "Dog", questionTextLabel: nil, questionMultiOptions: nil, questionType: .questionImageView, categoryType: .memory)]
//
//var question3 = [Question(questionText: "All Birds can fly. Penguins are birds. can penguins fly?", options: ["Yes", "No", "Some fly", "Only young can fly"], correctAnswer: "No", questionImage: nil, questionTextLabel: nil, questionMultiOptions: nil, questionType: .options, categoryType: .memory)]
//
//var question4 = [Question(questionText: "How many Paises in 5 Ruppes?", options: ["50", "5", "5000", "500"], correctAnswer: "500", questionImage: nil, questionTextLabel: nil, questionMultiOptions: nil, questionType: .options, categoryType: .memory)]
//
//var question5 = [Question(questionText: "You are buing 200 rupees of groceries, how much change you recieve back from 500 rupees?", options: ["200", "300", "500", "400"], correctAnswer: "300", questionImage: nil, questionTextLabel: nil, questionMultiOptions: nil, questionType: .options, categoryType: .memory)]
//
//var question6 = [Question(questionText: "Remember the sequence.", options: nil, correctAnswer: nil, questionImage: nil, questionTextLabel: "🙂😀😂", questionMultiOptions: nil, questionType: .textViewLabel, categoryType: .memory)]
//
//var question7 = [Question(questionText: "Select similar emoji.", options: ["🙂","😁","😃","😆"], correctAnswer: "😁", questionImage: nil, questionTextLabel: nil, questionMultiOptions: nil, questionType: .options, categoryType: .memory)]
//
//var question8 = [Question(questionText: "Complete the sequence '👉👆👈_?'", options: ["👈","☝️","👉","👇"], correctAnswer: "👇", questionImage: nil, questionTextLabel: nil, questionMultiOptions: nil, questionType: .options, categoryType: .memory)]
//
//var question9 = [Question(questionText: "Select Birds from the following.", options: ["Dog,Lion,Tiger", "Sparrow,Penguin,Eagle", "Snake,Lizard,Worm", "Monkey,Cat,Rat"], correctAnswer: "parrow,Penguin,Eagle", questionImage: nil, questionTextLabel: nil, questionMultiOptions: nil, questionType: .options, categoryType: .memory)]
//
//var question10 = [Question(questionText: "You need to buy 5 buckets and price of 1 bucket is 10 rupees. how much it will cost you?", options: ["40", "55", "500", "50"], correctAnswer: "50", questionImage: nil, questionTextLabel: nil, questionMultiOptions: nil, questionType: .options, categoryType: .memory)]
//
//var question11 = [Question(questionText: "What is this shape?", options: ["Rectangle", "Square", "Cube", "Cuboid"], correctAnswer: "Square", questionImage: "Square", questionTextLabel: nil, questionMultiOptions: nil, questionType: .questionImageView, categoryType: .memory)]
//
//var question12 = Question(questionText: "Write down the sequence of emoji that you have seen above.", options: ["🙂😀😂","🙂😂😀","😀🙂😂","😂🙂😀"], correctAnswer: "🙂😀😂", questionImage: nil, questionTextLabel: nil, questionMultiOptions: nil, questionType: .options, categoryType: .memory)
//
//
//var assessmentQuestions = [
//    question1, question2, question3, question4, question5, question6, question7, question8, question8, question9, question10, question11, question12
//] as [Any]
//
//struct AssessmentScore{
//    var totalScore: Int
//    var memoryScore: Int
//    var reasoningScore: Int
//    var logicScore: Int
//    var executiveFunctionScore: Int
//
//}
//
//
//
//var userAssessmentScore = AssessmentScore(totalScore: 16, memoryScore: 4, reasoningScore: 4, logicScore: 4, executiveFunctionScore: 4)

