//
//  GenericMessageView.swift
//  Movies
//
//  Created by DESARROLLO on 8/01/21.
//

import UIKit

protocol GenericMessageViewDelegate: AnyObject {
    func didTapActionButton(action: Message.ButtonItem)
}

final class GenericMessageView: UIView, NibLoadableView {

    private var action: Message.ButtonItem?

    // MARK: - IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton! {
        didSet {
            actionButton.layer.cornerRadius = 8
        }
    }

    // MARK: Public variables
    weak var delegate: GenericMessageViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension GenericMessageView {
    func configureView(message: Message) {
        self.action = message.action
        if let title = message.title {
            titleLabel.text = title
            titleLabel.isHidden = false
        } else {
            titleLabel.isHidden = true
        }
        if let description = message.description {
            messageLabel.text = description
            messageLabel.isHidden = false
        } else {
            messageLabel.isHidden = true
        }
        if let action = message.action {
            actionButton.setTitle(action.title, for: .normal)
            actionButton.isHidden = false
        } else {
            actionButton.isHidden = true
        }
    }
}

// MARK: IBActions
private extension GenericMessageView {
    @IBAction func didTapAction(_: Any) {
        guard let action = action else {
            return
        }
        delegate?.didTapActionButton(action: action)
    }
}
