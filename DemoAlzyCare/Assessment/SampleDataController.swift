//
//  SampleDataController.swift
//  AssessmentSample
//
//  Created by Gaurav on 31/05/24.
//

import Foundation



let userPersonalInfo = PersonalInfo(userName: "gaurav", userFatherName: "ram babu mishra", userMotherName: "madhu mishra", userPhoneNumber: "8882445490", userCountryName: "india", userCityName: "delhi", userBirthDate: "30", userBirthMonth: "january", userBirthYear: "1", userSchoolName: "asvj")



var question1 = [Question(questionText: "What is your Birth date?", options: nil, correctAnswer: userPersonalInfo.userBirthDate, questionImage: nil, questionTextLabel: nil, questionMultiOptions: nil, questionType: .textField, categoryType: .memory)]

var question2 = [Question(questionText: "Name the picture.", options: ["Dog", "Cat", "Lion", "Horse"], correctAnswer: "Dog", questionImage: "Dog", questionTextLabel: nil, questionMultiOptions: nil, questionType: .questionImageView, categoryType: .memory)]

var question3 = [Question(questionText: "All Birds can fly. Penguins are birds. can penguins fly?", options: ["Yes", "No", "Some fly", "Only young can fly"], correctAnswer: "No", questionImage: nil, questionTextLabel: nil, questionMultiOptions: nil, questionType: .options, categoryType: .reasoning)]

var question4 = [Question(questionText: "How many Paises in 5 Ruppes?", options: ["50", "5", "5000", "500"], correctAnswer: "500", questionImage: nil, questionTextLabel: nil, questionMultiOptions: nil, questionType: .options, categoryType: .memory)]

var question5 = [Question(questionText: "You are buing 200 rupees of groceries, how much change you recieve back from 500 rupees?", options: ["200", "300", "500", "400"], correctAnswer: "300", questionImage: nil, questionTextLabel: nil, questionMultiOptions: nil, questionType: .options, categoryType: .logic)]

var question6 = [Question(questionText: "Remember the sequence.", options: nil, correctAnswer: nil, questionImage: nil, questionTextLabel: "🙂😀😂", questionMultiOptions: nil, questionType: .textViewLabel, categoryType: .memory)]

var question7 = [Question(questionText: "Select similar emoji.'😁'", options: ["🙂","😁","😃","😆"], correctAnswer: "😁", questionImage: nil, questionTextLabel: nil, questionMultiOptions: nil, questionType: .options, categoryType: .executiveFunction)]

var question8 = [Question(questionText: "Complete the sequence '👉👆👈_?'", options: ["👈","☝️","👉","👇"], correctAnswer: "👇", questionImage: nil, questionTextLabel: nil, questionMultiOptions: nil, questionType: .options, categoryType: .executiveFunction)]

var question9 = [Question(questionText: "Select Birds from the following.", options: ["Dog,Lion,Tiger", "Sparrow,Penguin,Eagle", "Snake,Lizard,Worm", "Monkey,Cat,Rat"], correctAnswer: "Sparrow,Penguin,Eagle", questionImage: nil, questionTextLabel: nil, questionMultiOptions: nil, questionType: .options, categoryType: .reasoning)]

var question10 = [Question(questionText: "You need to buy 5 buckets and price of 1 bucket is 10 rupees. how much it will cost you?", options: ["40", "55", "500", "50"], correctAnswer: "50", questionImage: nil, questionTextLabel: nil, questionMultiOptions: nil, questionType: .options, categoryType: .logic)]

var question11 = [Question(questionText: "What is this shape?", options: ["Rectangle", "Square", "Cube", "Cuboid"], correctAnswer: "Square", questionImage: "Square", questionTextLabel: nil, questionMultiOptions: nil, questionType: .questionImageView, categoryType: .executiveFunction)]

var question12 = [Question(questionText: "Write down the sequence of emoji that you have seen above.", options: ["🙂😀😂","🙂😂😀","😀🙂😂","😂🙂😀"], correctAnswer: "🙂😀😂", questionImage: nil, questionTextLabel: nil, questionMultiOptions: nil, questionType: .options, categoryType: .memory)]


var assessmentQuestions = [question1, question2, question3, question4, question5, question6, question7, question8, question9, question10, question11, question12]

var userScore = AssessmentScore(totalScore: 0, executiveFunctionScore: 0, logicScore: 0, memoryScore: 0, reasoningScore: 0)
