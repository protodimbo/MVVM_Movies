//
//  PhotoService.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import UIKit

final class PhotoService {
    private let cacheLifetime: TimeInterval = 60 * 60 * 24 * 7

    // MARK: - Helpers

    private static let pathName: String = {
        let pathName = "images"
        guard let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return pathName }
        let url = cacheDir.appendingPathComponent(pathName, isDirectory: true)

        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }

        return pathName
    }()

    private func getFilePath(path: String) -> String? {
        guard let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }

        let hashName = String(describing: path.hashValue)

        return cacheDir.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }

    private func saveImageToCache(path: String, image: UIImage) {
        guard let filePath = getFilePath(path: path) else { return }

        let date = image.pngData()

        FileManager.default.createFile(atPath: filePath, contents: date, attributes: nil)
    }

    private func getImageFromCache(path: String) -> UIImage? {
        guard let filename = getFilePath(path: path),
              let info = try? FileManager.default.attributesOfItem(atPath: filename),
              let modificationDate = info[.modificationDate] as? Date else { return nil }

        let lifetime = Date().timeIntervalSince(modificationDate)

        guard lifetime <= cacheLifetime,
              let image = UIImage(contentsOfFile: filename) else { return nil }

        return image
    }

    private func loadPhoto(by path: String, completionHandler: @escaping (UIImage) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "image.tmdb.org"
        urlComponents.path = "/t/p/w500\(path)"
        guard let url = urlComponents.url, let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else { return }
        completionHandler(image)
    }

    // MARK: - API

    func getPhoto(path: String, completionHandler: @escaping (UIImage) -> Void) {
        if let photo = getImageFromCache(path: path) {
            completionHandler(photo)
        } else {
            loadPhoto(by: path, completionHandler: completionHandler)
        }
    }
}
