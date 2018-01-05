//
//  FileManager.swift
//  cobra-iOS
//
//  Created by DickyChengg on 5/9/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import Foundation

extension DModel {
    
    public class filePath {
        public class func bundle(_ fileName: String, _ extensions: String) -> String {
            return Bundle.main.path(forResource: fileName, ofType: extensions) ?? ""
        }
        
        public class func directory(_ fileName: String) -> String {
            let documentsDirectory:NSString = NSSearchPathForDirectoriesInDomains(
                .documentDirectory,
                .userDomainMask,
                true
                )[0] as String as NSString
            let url = NSURL(fileURLWithPath: documentsDirectory as String)
            return url.appendingPathComponent(fileName)?.path ?? ""
        }
        
        public class func directoryURL(_ fileName: String) -> URL {
            return URL(fileURLWithPath: directory(fileName))
        }
    }
    
    public class file {
        
        public class func move(_ source: URL, _ destination: URL) -> Bool {
            debug("url\(DModel.filePath.directory(destination.absoluteString))")
            debug("URL\(DModel.file.exist(source.absoluteString))")
            if DModel.file.exist(destination.absoluteString) || !DModel.file.exist(source.absoluteString) {
                return false
            }
            do {
                try FileManager.default.copyItem(at: source, to: DModel.filePath.directoryURL(destination.absoluteString))
                return true
            }
            catch let error {
                debug("error copying file \(source) : \(error)")
                return false
            }
        }
        
        // just fill the name in the bundle
        public class func move(_ source: String, _ destination: String) -> Bool {
            debug("string\(DModel.filePath.directory(destination))")
            debug("String\(DModel.file.exist(source))")
            if DModel.file.exist(DModel.filePath.directory(destination)) || !DModel.file.exist(source) {
                return false
            }
            do {
                try FileManager.default.copyItem(
                    atPath: source,
                    toPath: DModel.filePath.directory(destination)
                )
                return true
            }
            catch let error {
                debug("error copying file \(source) : \(error)")
                return false
            }
        }
        
        public class bundle {
            class func exist(_ fileName: String) -> Bool {
                return DModel.file.exist(
                    DModel.filePath.bundle(
                        fileName.components(separatedBy: ".")[0],
                        fileName.components(separatedBy: ".")[1]
                    )
                )
            }
            
            public class func read(_ fileName: URL) -> String {
                return DModel.file.read(fileName.absoluteString) ?? "nil"
            }
            
            public class func read(_ fileName: String) -> String {
                return DModel.file.read(
                    DModel.filePath.bundle(
                        fileName.components(separatedBy: ".")[0],
                        fileName.components(separatedBy: ".")[1])
                    ) ?? "nil"
            }
            
            public class func readJson(_ fileName: String) -> NSDictionary?{
                return DModel.file.readJSON(
                    DModel.filePath.bundle(
                        fileName.components(separatedBy: ".")[0],
                        fileName.components(separatedBy: ".")[1])
                    ) ?? NSDictionary()
            }
            
            public class func write(_ fileName: URL, _ value: String) -> String {
                return DModel.file.write(fileName.absoluteString, value) ?? "nil"
            }
            
            public class func write(_ fileName: String, _ value: String) -> String {
                return DModel.file.write(
                    DModel.filePath.bundle(
                        fileName.components(separatedBy: ".")[0],
                        fileName.components(separatedBy: ".")[1]),
                    value
                    ) ?? "nil"
            }
            
            public class func remove(_ fileName: String) -> Bool {
                return DModel.file.remove(
                    DModel.filePath.bundle(
                        fileName.components(separatedBy: ".")[0],
                        fileName.components(separatedBy: ".")[1]
                    )
                )
            }
        }
        
        public class directory {
            public class func exist(_ fileName: String) -> Bool {
                return DModel.file.exist(
                    DModel.filePath.directory(fileName)
                )
            }
            
            public class func read(_ fileName: URL) -> String {
                return DModel.file.read(fileName.absoluteString) ?? "nil"
            }
            
            public class func read(_ fileName: String) -> String {
                return DModel.file.read(
                    DModel.filePath.directory(fileName)
                    ) ?? "nil"
            }
            
            public class func readJson(_ fileName: String) -> NSDictionary {
                return DModel.file.readJSON(
                    DModel.filePath.directory(fileName)
                    ) ?? NSDictionary()
            }
            
            public class func write(_ fileName: URL, _ value: String) -> String {
                return DModel.file.write(fileName.absoluteString, value) ?? "nil"
            }
            
            public class func write(_ fileName: String, _ value: String) -> String {
                return DModel.file.write(
                    DModel.filePath.directory(fileName),
                    value
                    ) ?? "nil"
            }
            
            public class func remove(_ fileName: String) -> Bool {
                return DModel.file.remove(
                    DModel.filePath.directory(fileName)
                )
            }
        }
        
        public class func exist(_ fileName: String) -> Bool {
            return FileManager.default.fileExists(atPath: fileName)
        }
        
        public class func read(_ filePath: String) -> String? {
            do {
//                return try String(contentsOfFile: filePath) // read .txt file
                return try String(
                    contentsOf: URL(string: filePath)!,
                    encoding: String.Encoding.utf8)
            }
            catch {
                return nil
            }
        }
        
        public class func read(_ filePath: URL) -> String? {
            do {
                return try String(
                    contentsOf: filePath,
                    encoding: String.Encoding.utf8)
            }
            catch {
                return nil
            }
        }
        
        public class func readJSON(_ filePath: String) -> NSDictionary? {
            let data = NSData(contentsOfFile: filePath)
            do{
                if let data = data {
                    return try JSONSerialization.jsonObject(with: data as Data, options: [JSONSerialization.ReadingOptions.mutableContainers, JSONSerialization.ReadingOptions.allowFragments]) as? NSDictionary
//                    return NSDictionary() // <-- ganti yg atas
                } else {
                    return NSDictionary()
                }
            }
            catch
            {
                return NSDictionary()
            }
        }
        
        private class func write(_ filePath: String, _ text: String) -> String? {
            do {
                try text.write(
                    to: URL(string: filePath)!,
                    atomically: false,
                    encoding: String.Encoding.utf8)
                return read(filePath)
            }
            catch {
                return nil
            }
        }
        
        private class func remove(_ fileName: String) -> Bool {
            if !exist(fileName) {
                return false
            }
            do {
                try FileManager.default.removeItem(
                    atPath: fileName
                )
                return true
            }
            catch let error {
                debug("error removing file \(fileName) : \(error)")
                return false
            }
        }
    }
}
