//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Lộc Xuân  on 26/09/2022.
//

import UIKit

struct EditProfileFormModel {
    let label: String
    let placehoder: String
    var value: String?
}

class EditProfileViewController: UIViewController, UITableViewDataSource {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()
    
    private var models = [[EditProfileFormModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        configureModels()
        tableView.dataSource = self
        tableView.tableHeaderView = createTableHeaderView()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func configureModels(){
        let section1Label = ["Name", "Username", "Bio"]
        var section1 = [EditProfileFormModel]()
        for label in section1Label {
            let model = EditProfileFormModel(label: label, placehoder: "Enter \(label)...", value: nil)
            section1.append(model)
        }
        models.append(section1)
        
        let section2Label = ["Email", "Phone", "Gender"]
        var section2 = [EditProfileFormModel]()
        for label in section2Label {
            let model = EditProfileFormModel(label: label, placehoder: "Enter \(label)...", value: nil)
            section2.append(model)
        }
        models.append(section2)
        
    }
    
    
    // MARK: - Table View
    private func createTableHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: view.width,
            height: (view.height/4)).integral
        )
        let size = headerView.height/1.5
        let profilePhotoButton = UIButton(frame: CGRect(
            x: (view.width-size)/2,
            y: (headerView.height-size)/2,
            width: size,
            height: size)
        )
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size/2.0
        profilePhotoButton.tintColor = .label
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.fill"), for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhoto), for: .touchUpInside)
        headerView.addSubview(profilePhotoButton)
        return headerView
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Private Information"
    }
    
    // MARK: - Action
    
    @objc private func didTapProfilePhoto() {
        
    }
    
    @objc private func didTapSave() {
        
    }
    
    @objc private func didTapCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapChangeProfilePicture(){
        let alert = UIAlertController(title: "Change Profile Picture?", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Picture", style: .default, handler: { _ in
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        //Don't understand, reseaching again
        alert.popoverPresentationController?.sourceView = view
        alert.popoverPresentationController?.sourceRect = view.bounds
        present(alert, animated: true)
    }
}

extension EditProfileViewController: FormTableViewCellDelegate {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel?) {
        print(updatedModel?.value ?? "nil")
    }
}
