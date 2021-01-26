//
//  CanavasView.swift
//  DrawingApp
//
//  Created by Gagan  Vishal on 1/26/21.
//

import UIKit

class CanavasView: UIView {

    fileprivate var linesToDraw: [DrawingModel] = []
    fileprivate var defualtStrokeColor = UIColor.black
    fileprivate var defualtStrokeWidth: CGFloat = 1.0

    // MARK: - View Life cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {return}
        drawing(context)
        context.setLineCap(.round)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        linesToDraw.append(DrawingModel(strokeColor: self.defualtStrokeColor, strokeWidth: self.defualtStrokeWidth, points: []))
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint =  touches.first?.location(in: nil) else {return}
        guard  var  lastModel = self.linesToDraw.popLast() else { return }
        lastModel.points.append(touchPoint)
        linesToDraw.append(lastModel)
        setNeedsDisplay()
    }
    // MARK: -
    fileprivate func drawing(_ context: CGContext) {
        linesToDraw.forEach { (model) in
            for (index, point) in model.points.enumerated() {
                if index == 0 {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
            }
            context.setStrokeColor(model.strokeColor.cgColor)
            context.setLineWidth(model.strokeWidth)
            context.strokePath()
        }
    }
    // MARK: - Undo button action
    func undoLastAction() {
        _ = self.linesToDraw.popLast()
        setNeedsDisplay()
    }
    // MARK: - Clear Button Action
    func clearAllActions() {
        self.linesToDraw.removeAll()
        setNeedsDisplay()
    }
    // MARK: - Update slider
    func updateStroke(width: CGFloat) {
        self.defualtStrokeWidth = width
    }
    // MARK: - Update  color
    func updateStroke(color: UIColor) {
        self.defualtStrokeColor = color
    }
}
