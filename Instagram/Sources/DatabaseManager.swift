//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Lộc Xuân  on 14/09/2022.
//

import FirebaseDatabase

class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void ){
        completion(true)
    }
    
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void){
        let key = email.safeDatabaseKey()
        
        database.child(key).setValue(["username": username]){
            error, _ in
            if error == nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
