//
//  WeightInputView.swift
//  MC3
//
//  Created by Leonardo Marhan on 17/08/24.
//

import UIKit

class WeightInputView: UIView {
    
    private let weightInput: UITextField = {
        let input = UITextField()
        input.layer.borderWidth = 1
        input.layer.cornerRadius = 10
        input.layer.borderColor = UIColor.systemGray4.cgColor
        input.placeholder = "0"
        input.borderStyle = .roundedRect
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    private let kgLabel: UILabel = {
        let label = UILabel()
        label.text = "Kg"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(weightInput)
        addSubview(kgLabel)
        
        NSLayoutConstraint.activate([
            weightInput.leadingAnchor.constraint(equalTo: leadingAnchor),
            weightInput.topAnchor.constraint(equalTo: topAnchor),
            weightInput.bottomAnchor.constraint(equalTo: bottomAnchor),
            weightInput.trailingAnchor.constraint(equalTo: kgLabel.leadingAnchor, constant: -8),
            
            kgLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            kgLabel.centerYAnchor.constraint(equalTo: weightInput.centerYAnchor)
        ])
    }
    
    var weightValue: String {
        return weightInput.text ?? ""
    }
    
    func setWeightValue(value: String) {
        weightInput.text = value
    }
}
