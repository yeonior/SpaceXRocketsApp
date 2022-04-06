//
//  MainFirstSectionTableViewCell.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 06.04.2022.
//

import UIKit

final class MainFirstSectionTableViewCell: UITableViewCell {
    
    let label: UILabel = {
        $0.font = Font.tableCellTitle.uiFont
        $0.textAlignment = .left
        $0.clipsToBounds = true
        
        return $0
    }(UILabel())
    
    let detailLabel: UILabel = {
        $0.font = Font.tableCellDetailTitle.uiFont
        $0.textAlignment = .right
        $0.clipsToBounds = true
        
        return $0
    }(UILabel())
}
