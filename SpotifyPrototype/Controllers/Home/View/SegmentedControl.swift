//
//  SegmentedControl.swift
//  SpotifyPrototype
//
//  Created by aiv on 28.11.2022.
//

import UIKit

class SegmentedControl: UIView {
    private var buttonTitles: [String]!
    private var buttons: [UIButton] = []
    private var selectorView: UIView!
    
    var textColor = R.Colors.grey
    var selectorViewColor = R.Colors.salt
    var selectorTextColor = R.Colors.white
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        setupView(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        
        selectorView = UIView(frame: CGRect(x: 0,
                                            y: 50,
                                            width: selectorWidth,
                                            height: 2))
        
        selectorView.backgroundColor = selectorViewColor
        selectorView.layer.cornerRadius = 2
        setupView(selectorView)
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self,
                             action: #selector(SegmentedControl.buttonAction(sender:)),
                             for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = R.Fonts.bold(with: 18)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
    }
    
    @objc func buttonAction(sender: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                let selectorPosition = frame.width / CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
    
    private func updateView() {
        createButton()
        configSelectorView()
        configStackView()
    }
    
    convenience init(frame: CGRect, buttonTitle: [String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitle
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    
    func setButtonTitles(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        updateView()
    }
}

