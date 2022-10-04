//
//  FormTableViewCell.swift
//  Instagram
//
//  Created by Lộc Xuân  on 28/09/2022.
//

import UIKit

protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell (_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel?)
}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate {

    static let identifier = "FormTableViewCell"
    private var model: EditProfileFormModel?
    
    public weak var delegate: FormTableViewCellDelegate?
    
    private let formLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(textField)
        textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: EditProfileFormModel) {
        self.model = model
        formLabel.text = model.label
        textField.placeholder = model.placehoder
        textField.text = model.value
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        textField.placeholder = nil
        textField.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Assign frame
        formLabel.frame = CGRect(
            x: 5,
            y: 0,
            width: contentView.width/3,
            height: contentView.height
        )
        textField.frame = CGRect(
            x: formLabel.right+5,
            y: 0,
            width: contentView.width-10-formLabel.width,
            height: contentView.height
        )
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        guard let model = model else {
            print("Trigger")

            return true
        }
        delegate?.formTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }
}
