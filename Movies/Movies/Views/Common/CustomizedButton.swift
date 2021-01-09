//
//  CustomizedButton.swift
//  Movies
//
//  Created by DESARROLLO on 8/01/21.
//

import UIKit

@IBDesignable class CustomizedButton: UIButton {

    private var activityIndicator: UIActivityIndicatorView?
    private var isActivityAnimating = false

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var activityIndicatorColor: UIColor? = UIColor.color(named: .orange) {
        didSet {
            createActivityIndicator()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    override func prepareForInterfaceBuilder() {
        sharedInit()
    }

    private func sharedInit() {
        layer.cornerRadius = cornerRadius
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension CustomizedButton {

    // MARK: - Activity indicator

    func startActivityIndicator(animated: Bool = true) {
        createActivityIndicator()

        isUserInteractionEnabled = false
        activityIndicator?.startAnimating()
        isActivityAnimating = true

        UIView.animate(withDuration: animated ? 0.2 : 0, animations: {
            self.activityIndicator?.alpha = 1
        }, completion: nil)
    }

    func stopActivityIndicator(animated: Bool = true) {
        isUserInteractionEnabled = true
        activityIndicator?.stopAnimating()
        isActivityAnimating = false
        UIView.animate(withDuration: animated ? 0.2 : 0, animations: {
            self.activityIndicator?.alpha = 0
        }, completion: nil)
    }

    private func createActivityIndicator() {
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView()
            if let indicator = activityIndicator {
                addSubview(indicator)
                indicator.translatesAutoresizingMaskIntoConstraints = false
                indicator.alpha = 0
                indicator.hidesWhenStopped = false
                addConstraint(NSLayoutConstraint(item: indicator,
                                                 attribute: .centerX,
                                                 relatedBy: .equal,
                                                 toItem: self,
                                                 attribute: .centerX,
                                                 multiplier: 1,
                                                 constant: 0))

                addConstraint(NSLayoutConstraint(item: indicator,
                                                 attribute: .centerY,
                                                 relatedBy: .equal,
                                                 toItem: self,
                                                 attribute: .centerY,
                                                 multiplier: 1,
                                                 constant: 0))
                layoutIfNeeded()
            }
        }
        activityIndicator?.style = .medium
        activityIndicator?.color = activityIndicatorColor
    }
}
