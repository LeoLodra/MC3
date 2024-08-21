//
//  InitialScreenView.swift
//  MC3
//
//  Created by Leonardo Marhan on 13/08/24.
//

import UIKit
import SwiftUI

class InitialScreenView: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi, Strong Mother.\nLet’s start your pregnancy journey!"
        label.textColor = .black
        label.font = UIFont(name: "Lato-Bold", size: 34)
        label.numberOfLines = 0
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Share important details about you and your pregnancy to receive the best possible recommendation."
        label.textColor = .black
        label.font = UIFont(name: "Lato-Light", size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "What is your name?"
        label.textColor = .black
        label.font = UIFont(name: "Lato-Regular", size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let nameInput: UITextField = {
        let input = UITextField()
        input.layer.borderWidth = 1
        input.layer.cornerRadius = 10
        input.layer.borderColor = UIColor.systemGray4.cgColor
        input.placeholder = "0"
        input.placeholder = "Your Name"
        input.borderStyle = .roundedRect
        return input
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.text = "How much is your weight before pregnancy?"
        label.textColor = .black
        label.font = UIFont(name: "Lato-Regular", size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let weightInput = WeightInputView()
    
    let currWeightLabel: UILabel = {
        let label = UILabel()
        label.text = "How much is your weight currently?"
        label.textColor = .black
        label.font = UIFont(name: "Lato-Regular", size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let currWeightInput = WeightInputView()
    
    let heightInput = HeightInputView()
    
    let lmpLabel: UILabel = {
        let label = UILabel()
        label.text = "When was the first day of your last menstrual period (LMP)?"
        label.textColor = .black
        label.font = UIFont(name: "Lato-Regular", size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let lmpInput = DateInputView()
    
    let dobLabel: UILabel = {
        let label = UILabel()
        label.text = "What was your date of birth?"
        label.textColor = .black
        label.font = UIFont(name: "Lato-Regular", size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let dobInput = DateInputView()
    
    //    let allergiesLabel: UILabel = {
    //        let label = UILabel()
    //        label.text = "Let us know of any food allergies"
    //        label.textColor = .black
    //        label.font = UIFont(name: "Lato-Regular", size: 15)
    //        label.numberOfLines = 0
    //        return label
    //    }()
    //
    //    let allergiesInput: UIButton = {
    //        let button = UIButton(type: .system)
    //        button.setTitle("Add Restriction", for: .normal)
    //        button.setTitleColor(.black, for: .normal)
    //        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 17)
    //
    //        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
    //        button.tintColor = .black
    //
    //        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
    //
    //        button.layer.borderWidth = 1.5
    //        button.layer.cornerRadius = 20
    //        return button
    //    }()
    
    let divider: UIView = {
        let view = UIView()
        view.layer.borderWidth = 5
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.systemGray4
        return view
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start my journey", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 17)
        button.backgroundColor = .blueprimary
        
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        
        view.addSubview(nameLabel)
        view.addSubview(nameInput)
        
        view.addSubview(weightLabel)
        view.addSubview(weightInput)
        
        view.addSubview(currWeightLabel)
        view.addSubview(currWeightInput)
        
        view.addSubview(heightInput)
        
        view.addSubview(lmpLabel)
        view.addSubview(lmpInput)
        
        view.addSubview(dobLabel)
        view.addSubview(dobInput)
        
        //        view.addSubview(allergiesLabel)
        //        view.addSubview(allergiesInput)
        
        view.addSubview(divider)
        view.addSubview(submitButton)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        
        disableAutoresizing()
        setupConstraints()
    }
    
    func disableAutoresizing() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameInput.translatesAutoresizingMaskIntoConstraints = false
        
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightInput.translatesAutoresizingMaskIntoConstraints = false
        
        currWeightLabel.translatesAutoresizingMaskIntoConstraints = false
        currWeightInput.translatesAutoresizingMaskIntoConstraints = false
        
        heightInput.translatesAutoresizingMaskIntoConstraints = false
        
        lmpLabel.translatesAutoresizingMaskIntoConstraints = false
        lmpInput.translatesAutoresizingMaskIntoConstraints = false
        
        dobLabel.translatesAutoresizingMaskIntoConstraints = false
        dobInput.translatesAutoresizingMaskIntoConstraints = false
        
        //        allergiesLabel.translatesAutoresizingMaskIntoConstraints = false
        //        allergiesInput.translatesAutoresizingMaskIntoConstraints = false
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            
            subtitleLabel.centerYAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            
            nameLabel.centerYAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 35),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            nameInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameInput.centerYAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 25),
            nameInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameInput.heightAnchor.constraint(equalToConstant: 44),
            
            weightLabel.centerYAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 35),
            weightLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            weightLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8),
            
            weightInput.centerYAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 25),
            weightInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            weightInput.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -12),
            weightInput.heightAnchor.constraint(equalToConstant: 44),
            
            currWeightLabel.centerYAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 35),
            currWeightLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
            currWeightLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            currWeightInput.centerYAnchor.constraint(equalTo: currWeightLabel.bottomAnchor, constant: 25),
            currWeightInput.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            currWeightInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            currWeightInput.heightAnchor.constraint(equalToConstant: 44),
            
            heightInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            heightInput.centerYAnchor.constraint(equalTo: weightInput.bottomAnchor, constant: 55),
            heightInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            heightInput.heightAnchor.constraint(equalToConstant: 44),
            
            lmpLabel.centerYAnchor.constraint(equalTo: heightInput.bottomAnchor, constant: 35),
            lmpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lmpLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            lmpInput.centerYAnchor.constraint(equalTo: lmpLabel.bottomAnchor, constant: 30),
            lmpInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            lmpInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            lmpInput.heightAnchor.constraint(equalToConstant: 44),
            
            dobLabel.centerYAnchor.constraint(equalTo: lmpInput.bottomAnchor, constant: 25),
            dobLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dobLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            dobInput.centerYAnchor.constraint(equalTo: dobLabel.bottomAnchor, constant: 30),
            dobInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            dobInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            dobInput.heightAnchor.constraint(equalToConstant: 44),
            
            //            allergiesLabel.centerYAnchor.constraint(equalTo: dobInput.bottomAnchor, constant: 35),
            //            allergiesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            //            allergiesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            //
            //            allergiesInput.centerYAnchor.constraint(equalTo: allergiesLabel.bottomAnchor, constant: 30),
            //            allergiesInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            //            allergiesInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            //            allergiesInput.heightAnchor.constraint(equalToConstant: 45),
            
            divider.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -20),
            divider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -8),
            divider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 8),
            divider.heightAnchor.constraint(equalToConstant: 1),
            
            submitButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            submitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            submitButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    @objc func submitButtonTapped() {
        if validateInputs() == "" {
            let goalsScreen = UIHostingController(rootView: GoalsScreenView())
            goalsScreen.modalPresentationStyle = .fullScreen
            present(goalsScreen, animated: true, completion: nil)
        } else {
            showAlert(message: validateInputs())
        }
    }
    
    func validateInputs() -> String {
        if !InputValidator.isValidName(nameInput.text ?? "") {
            return "Please fill your name"
        }
        
        else if !InputValidator.isValidWeight(weightInput.weightValue) {
            return "Please fill your weight before pregnancy"
        }
        
        else if !InputValidator.isValidWeight(currWeightInput.weightValue) {
            return "Please fill your current weight"
        }
        
        else if !InputValidator.isValidHeight(heightInput.heightValue) {
            return "Please fill your height"
        }
        
        else if !InputValidator.isValidDate(lmpInput.selectedDate) {
            return "Please fill the date of the first day of your LMP correctly"
        }
        
        else if !InputValidator.isValidDate(dobInput.selectedDate) {
            return "Please fill your date of birth correctly"
        }
        
        return ""
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

#Preview {
    InitialScreenView()
}
