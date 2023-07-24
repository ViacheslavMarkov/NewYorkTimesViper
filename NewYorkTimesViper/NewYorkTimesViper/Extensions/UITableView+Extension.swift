//
//  File.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 24.07.2023.
//

import UIKit

extension UITableView {
    func isLastCellVisible(_ currentCellIndexPath: IndexPath) -> Bool {
        guard numberOfSections > 0 else { return false }

        let lastSection = numberOfSections - 1
        let rows = numberOfRows(inSection: lastSection)
        guard rows > 0 else { return false }

        let lastRow = rows - 1
        let lastIndexPath = IndexPath(row: lastRow, section: lastSection)
        return lastIndexPath == currentCellIndexPath
    }
}
