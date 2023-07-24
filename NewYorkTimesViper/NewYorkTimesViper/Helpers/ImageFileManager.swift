//
//  ImageFileManager.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 23.07.2023.
//

import UIKit

final class ImageFileManager {
    static let shared = ImageFileManager()
    private let folderName = "downloaded_images"
    
    private init() {
        createFolderIfNeeded()
    }
    
    private func createFolderIfNeeded() {
        guard let url = getFolderPath() else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(atPath: url.path, withIntermediateDirectories: true)
            } catch let error {
                print("Error creating folder. \(error.localizedDescription)")
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    private func getImagePath(key: String) -> URL? {
        guard let url = getFolderPath() else { return nil }
        return url.appendingPathExtension(key + ".png")
    }
    
    func add(key: String, image: UIImage) {
       guard
        let data = image.pngData(),
        let url = getImagePath(key: key)
        else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving to file manager. \(error.localizedDescription)")
        }
    }
    
    func get(key: String) -> UIImage? {
        guard
            let url = getImagePath(key: key),
            FileManager.default.fileExists(atPath: url.path)
        else { return nil }
        
        return UIImage(contentsOfFile: url.path)
    }
}
