//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Bruke on 8/5/22.
//

import Foundation

extension FileManager {
    static var documentsDirecotry: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
