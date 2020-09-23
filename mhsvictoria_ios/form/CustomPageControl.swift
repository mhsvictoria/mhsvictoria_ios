//
//  CustomPageControl.swift
//  mhsvictoria_ios
//
//  Created by Riley Peel on 2020-09-20.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class CustomPageControl: UIView {
    
    var delegate: CustomPageControlDelegate?
    var buttons: [UIButton] = []
    let numButtons = 3
    var selected: Int = 0 {
        didSet {
            updateButtons()
        }
    }
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        setUpView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpView() {
        let lineImgView = UIImageView(image: drawLine())
        self.addSubview(lineImgView)
        lineImgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineImgView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            lineImgView.topAnchor.constraint(equalTo: self.topAnchor, constant: buttonSize / 2 - 2.5)
        ])
        
        for i in 0..<numButtons {
            buttons.append(UIButton())
            if i == selected {
                buttons[i].setImage(drawCircle(num: i, selected: true), for: .normal)
            } else {
                buttons[i].setImage(drawCircle(num: i, selected: false), for: .normal)
            }
            buttons[i].addTarget(self, action: #selector(self.buttonPressed(_:)), for: .touchUpInside)
            buttons[i].isUserInteractionEnabled = true
            self.addSubview(buttons[i])
            self.bringSubviewToFront(buttons[i])
            buttons[i].translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                buttons[i].topAnchor.constraint(equalTo: self.topAnchor),
                buttons[i].widthAnchor.constraint(equalToConstant: buttonSize),
                buttons[i].heightAnchor.constraint(equalToConstant: buttonSize)
                
            ])
        }
        NSLayoutConstraint.activate([
            buttons[1].centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttons[0].trailingAnchor.constraint(equalTo: buttons[1].leadingAnchor, constant: -margin),
            buttons[2].leadingAnchor.constraint(equalTo: buttons[1].trailingAnchor, constant: margin)
        ])
    }
    
    func updateButtons() {
        for i in 0..<buttons.count {
            if i == selected {
                buttons[i].setImage(drawCircle(num: i, selected: true), for: .normal)
            } else {
                buttons[i].setImage(drawCircle(num: i, selected: false), for: .normal)
            }
        }
    }
    
    func drawCircle(num: Int, selected: Bool) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: buttonSize, height: buttonSize))
        let img = renderer.image { ctx in
            var fillColor = unselectedGrey.cgColor
            let black: UIColor = .black
            var strokeColor = black.cgColor
            if selected {
                fillColor = darkGrey.cgColor
                strokeColor = accent.cgColor
            }
            ctx.cgContext.beginPath()
            let rectangle = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
            ctx.cgContext.setFillColor(fillColor)
            ctx.cgContext.setStrokeColor(strokeColor)
            ctx.cgContext.setLineWidth(1)
            let font = UIFont.systemFont(ofSize: 20)
            let string = NSAttributedString(string: "\(num)", attributes: [NSAttributedString.Key.font: font])
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            let textHeight = font.lineHeight
            string.draw(at: CGPoint(x: buttonSize / 2 - 7, y: buttonSize / 2 - textHeight / 2))
        }
        return img
    }
    
    func drawLine() -> UIImage {
        let lineLength = Int(buttonSize) * (numButtons - 2) + numButtons * Int(margin)
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: lineLength, height: 10))
        let img = renderer.image { ctx in
            ctx.cgContext.setStrokeColor(unselectedGrey.cgColor)
            ctx.cgContext.setLineWidth(2)
            ctx.cgContext.move(to: CGPoint(x: 0, y: 5))
            ctx.cgContext.addLine(to: CGPoint(x: CGFloat(lineLength), y: 5))
            ctx.cgContext.strokePath()
        }
        return img
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        for i in 0..<buttons.count {
            if sender == buttons[i] {
                if let del = delegate {
                    del.buttonWasPressed(i)
                }
            }
        }
    }
}

protocol CustomPageControlDelegate {
    func buttonWasPressed(_ number: Int)
}
