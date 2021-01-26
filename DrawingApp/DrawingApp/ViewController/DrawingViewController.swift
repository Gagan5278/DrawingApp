//
//  ViewController.swift
//  DrawingApp
//
//  Created by Gagan  Vishal on 1/26/21.
//

import UIKit

class DrawingViewController: UIViewController {
    let drawingView = CanavasView()
    let undoButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Undo", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(undoButtonAction(sender:)), for: .touchUpInside)
        return btn
    }()
    let clearButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Clear", for: .normal)
        btn.addTarget(self, action: #selector(clearButtonAction(sender:)), for: .touchUpInside)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    let colorButton: UIButton  = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Choose Color", for: .normal)
        btn.addTarget(self, action: #selector(colorPicker(sender:)), for: .touchUpInside)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    let sliderView: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1.0
        slider.maximumValue = 10.0
        slider.addTarget(self, action: #selector(sliderUpdate(slider:)), for: .valueChanged)
        return slider
    }()
    var stackView: UIStackView = {
        let stkView =  UIStackView()
        stkView.distribution = .fillEqually
        stkView.translatesAutoresizingMaskIntoConstraints = false
        stkView.spacing = 10
        return stkView
    }()
    // MARK: - View Controller life cycle
    override func loadView() {
        super.loadView()
        self.view = drawingView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cannvasViewSetup()
    }
    // MARK: -
    fileprivate func cannvasViewSetup() {
        self.drawingView.backgroundColor = .systemBackground
        self.stackView.addArrangedSubviews(undoButton, clearButton, colorButton, sliderView)
        self.view.addSubview(self.stackView)
        NSLayoutConstraint.activate([
            self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.stackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    // MARK: - Undo action
    @objc fileprivate func undoButtonAction(sender: UIButton) {
        self.drawingView.undoLastAction()
    }
    // MARK: - Clear button action
    @objc fileprivate func clearButtonAction(sender: UIButton) {
        self.drawingView.clearAllActions()
    }
    // MARK: - Slider Value change
    @objc fileprivate func sliderUpdate(slider: UISlider) {
        self.drawingView.updateStroke(width: CGFloat(slider.value))
    }
    // MARK: - Color Picker
    @objc fileprivate func colorPicker(sender: UIButton) {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
}

// MARK: - UIColorPickerViewControllerDelegate
extension DrawingViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.drawingView.updateStroke(color: viewController.selectedColor)
        stackView.backgroundColor = viewController.selectedColor
    }
}
