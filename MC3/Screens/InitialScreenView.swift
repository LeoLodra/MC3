//
//  InitialScreenView.swift
//  MC3
//
//  Created by Leonardo Marhan on 13/08/24.
//

import UIKit

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
    
    let lmpInputContainer: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
    }()
    
    let calendarIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let lmpInput: UIDatePicker = {
        let input = UIDatePicker()
        input.sizeToFit()
        input.preferredDatePickerStyle = .compact
        input.datePickerMode = .date
        input.backgroundColor = .clear
        return input
    }()
    
    let dobLabel: UILabel = {
        let label = UILabel()
        label.text = "What was your date of birth?"
        label.textColor = .black
        label.font = UIFont(name: "Lato-Regular", size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let dobInputContainer: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
    }()
    
    let calendarIcon2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let dobInput: UIDatePicker = {
        let input = UIDatePicker()
        input.sizeToFit()
        input.preferredDatePickerStyle = .compact
        input.datePickerMode = .date
        input.backgroundColor = .clear
        return input
    }()
    
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
        button.backgroundColor = .systemCyan
        
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
        view.addSubview(lmpInputContainer)
        lmpInputContainer.addSubview(calendarIcon)
        lmpInputContainer.addSubview(lmpInput)
        
        view.addSubview(dobLabel)
        view.addSubview(dobInputContainer)
        dobInputContainer.addSubview(calendarIcon2)
        dobInputContainer.addSubview(dobInput)
        
//        view.addSubview(allergiesLabel)
//        view.addSubview(allergiesInput)
        
        view.addSubview(divider)
        view.addSubview(submitButton)
        
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
        lmpInputContainer.translatesAutoresizingMaskIntoConstraints = false
        calendarIcon.translatesAutoresizingMaskIntoConstraints = false
        lmpInput.translatesAutoresizingMaskIntoConstraints = false
        
        dobLabel.translatesAutoresizingMaskIntoConstraints = false
        dobInputContainer.translatesAutoresizingMaskIntoConstraints = false
        calendarIcon2.translatesAutoresizingMaskIntoConstraints = false
        dobInput.translatesAutoresizingMaskIntoConstraints = false
        
//        allergiesLabel.translatesAutoresizingMaskIntoConstraints = false
//        allergiesInput.translatesAutoresizingMaskIntoConstraints = false
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
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
            
            lmpInputContainer.centerYAnchor.constraint(equalTo: lmpLabel.bottomAnchor, constant: 30),
            lmpInputContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            lmpInputContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            lmpInputContainer.heightAnchor.constraint(equalToConstant: 44),
            
            calendarIcon.leadingAnchor.constraint(equalTo: lmpInputContainer.leadingAnchor, constant: 10),
            calendarIcon.centerYAnchor.constraint(equalTo: lmpInputContainer.centerYAnchor),
            calendarIcon.widthAnchor.constraint(equalToConstant: 24),
            calendarIcon.heightAnchor.constraint(equalToConstant: 24),
            
            lmpInput.leadingAnchor.constraint(equalTo: calendarIcon.trailingAnchor, constant: 10),
            lmpInput.centerYAnchor.constraint(equalTo: lmpInputContainer.centerYAnchor),
            lmpInput.trailingAnchor.constraint(equalTo: lmpInputContainer.trailingAnchor, constant: -10),
            
            dobLabel.centerYAnchor.constraint(equalTo: lmpInputContainer.bottomAnchor, constant: 25),
            dobLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dobLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            dobInputContainer.centerYAnchor.constraint(equalTo: dobLabel.bottomAnchor, constant: 30),
            dobInputContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            dobInputContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            dobInputContainer.heightAnchor.constraint(equalToConstant: 44),
            
            calendarIcon2.leadingAnchor.constraint(equalTo: dobInputContainer.leadingAnchor, constant: 10),
            calendarIcon2.centerYAnchor.constraint(equalTo: dobInputContainer.centerYAnchor),
            calendarIcon2.widthAnchor.constraint(equalToConstant: 24),
            calendarIcon2.heightAnchor.constraint(equalToConstant: 24),
            
            dobInput.leadingAnchor.constraint(equalTo: calendarIcon2.trailingAnchor, constant: 10),
            dobInput.centerYAnchor.constraint(equalTo: dobInputContainer.centerYAnchor),
            dobInput.trailingAnchor.constraint(equalTo: dobInputContainer.trailingAnchor, constant: -10),
            
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
}

#Preview {
    InitialScreenView()
}
