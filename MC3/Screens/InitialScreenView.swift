//
//  InitialScreenView.swift
//  MC3
//
//  Created by Leonardo Marhan on 13/08/24.
//

import UIKit

class InitialScreenView: UIViewController {
    
    let nameInput: UITextField = {
        let input = UITextField()
        input.placeholder = "Name"
        input.borderStyle = .roundedRect
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    let weightInput: UITextField = {
        let input = UITextField()
        input.placeholder = "Weight Before Pregnancy"
        input.borderStyle = .roundedRect
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    let heightInput: UITextField = {
        let input = UITextField()
        input.placeholder = "Height"
        input.borderStyle = .roundedRect
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        view.addSubview(nameInput)
        view.addSubview(weightInput)
        view.addSubview(heightInput)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameInput.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            nameInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            nameInput.heightAnchor.constraint(equalToConstant: 40),
            
            weightInput.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: 114),
            weightInput.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 160),
            weightInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.38),
            weightInput.heightAnchor.constraint(equalToConstant: 40),
            
            heightInput.centerXAnchor.constraint(equalTo: view.trailingAnchor, constant: -114),
            heightInput.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 160),
            heightInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.38),
            heightInput.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

#Preview {
    InitialScreenView()
}
