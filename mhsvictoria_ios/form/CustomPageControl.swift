//
//  CustomPageControl.swift
//  mhsvictoria_ios
//
//  Created by Riley Peel on 2020-09-20.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class CustomPageControl: UIView {
    
    let delegate: Any? = nil
    
    var currentPage: Int = 0 {
        didSet {
            
        }
    }
    
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        var buttons: [UIButton] = []
        let numButtons = 3
        for i in 0..<numButtons {
            //initialize buttons
            buttons.append(UIButton())
            if i == currentPage {
                buttons[i].setImage(drawCircle(num: i, selected: true), for: .normal)
            } else {
                buttons[i].setImage(drawCircle(num: i, selected: true), for: .normal)
            }
            buttons[i].addTarget(self, action: #selector(self.buttonPressed(sender:)), for: .touchUpInside)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateButtons() {
        
    }
    
    func drawCircle(num: Int, selected: Bool) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: dotSize, height: dotSize))
        let img = renderer.image { ctx in
            //draw image
            ctx.cgContext.beginPath()
            let rectangle = CGRect(x: 0, y: 0, width: 20, height: 20)
            //ctx.cgContext.setFillColor(unselectedGrey.cgColor)
            //ctx.cgContext.setStrokeColor(accent.cgColor)
            //ctx.cgContext.setLineWidth(1)
            //let font = UIFont.systemFont(ofSize: 20)
            //let string = NSAttributedString(string: "\(num)", attributes: [NSAttributedString.Key.font: font])
            ctx.cgContext.addEllipse(in: rectangle)
            //ctx.cgContext.strokeEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fill)
            //string.draw(at: CGPoint(x: 5, y: -2))
            //string.draw(in: rectangle)
        }
        return img
    }
    
    func drawLine() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: dotSize + 30, height: 10))
        let img = renderer.image { ctx in
            ctx.cgContext.setStrokeColor(dark_grey.cgColor)
            ctx.cgContext.setLineWidth(2)

            ctx.cgContext.move(to: CGPoint(x: 0, y: 5))
            ctx.cgContext.addLine(to: CGPoint(x: 100, y: 5))
            ctx.cgContext.strokePath()
        }
        
        return img
    }
    
    @objc func buttonPressed(sender: UIButton) {
        if let del = delegate {
            //del.goToPage(sender.pageNumber)
        }
    }
}
