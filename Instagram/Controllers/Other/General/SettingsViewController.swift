//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Lộc Xuân  on 23/09/2022.
//

import UIKit
import SafariServices

struct SettingCellModel {
    let title: String
    let handler: (()->Void)
}

final class SettingsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels(){
        data.append([
            SettingCellModel(title: "Edit Profile", handler: { [weak self] in
                self?.didTapOnEditProfile()
            }),
            SettingCellModel(title: "Invite Friends", handler: { [weak self] in
                self?.didTapOnInviteFriend()
            }),
            SettingCellModel(title: "Save Original Posts", handler: { [weak self] in
                self?.didTapOnSavePost()
            })
        ])
        
        data.append([
            SettingCellModel(title: "Terms of Service", handler: { [weak self] in
                self?.openURL(type: .terms)
            }),
            SettingCellModel(title: "Privacy Policy", handler: { [weak self] in
                self?.openURL(type: .privacy)
            }),
            SettingCellModel(title: "Help / Feedback", handler: { [weak self] in
                self?.openURL(type: .help)
            })
        ])
        
        data.append([
            SettingCellModel(title: "Log Out", handler: { [weak self] in
                self?.didTapOnLogOut()
            })
        ])
    }
    
    private func didTapOnEditProfile(){
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    private func didTapOnInviteFriend(){
        
    }
    
    private func didTapOnSavePost(){
        
    }
    
    enum SettingURLType {
        case terms, privacy, help
    }
    private func openURL(type: SettingURLType){
        var urlString: String
        switch (type) {
        case .terms:
            urlString = "https://help.instagram.com/581066165581870"
        case .privacy:
            urlString = "https://help.instagram.com/196883487377501"
        case .help:
            urlString = "https://help.instagram.com"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        
        present(vc, animated: true)
    }

    private func didTapOnLogOut(){
        let alert = UIAlertController(title: "Log Out?", message: "Are you sure want to logout", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { _ in
            AuthManager.shared.logOutUser { successed in
                DispatchQueue.main.async {
                    if successed {
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: false){
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    } else {
                        //Cannot log out
                        fatalError("Cannot log out!")
                    }
                }
            }
        }))
        present(alert, animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
    
}
