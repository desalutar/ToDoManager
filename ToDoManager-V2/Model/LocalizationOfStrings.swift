//
//  LocalizationOfStrings.swift
//  ToDoManager-V2
//
//  Created by Ишхан Багратуни on 06.07.23.
//

import Foundation

extension String {
    var locolized: String {
        NSLocalizedString(
            self,
            comment: "\(self) could not be found in localizable.strings")
    }
}
