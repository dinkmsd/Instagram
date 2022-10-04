//
//  StorageManager.swift
//  Instagram
//
//  Created by Lộc Xuân  on 14/09/2022.
//

import FirebaseStorage

class StorageManager {
    static let shared = StorageManager()
    private let bucket = Storage.storage().reference()
    
    public enum IGManagerStorageError: Error {
        case failedToDownload
    }
    
    // MARK: - Public:
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, IGManagerStorageError>) -> Void) {
        bucket.child(reference).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            
            completion(.success(url))
        }

    }
}


