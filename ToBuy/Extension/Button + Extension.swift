//
//  FilterBtn.swift
//  ToBuy
//
//  Created by Joy Kim on 6/16/24.
//

import UIKit

extension UIButton.Configuration {
    
    static func filteredButton(title: String) -> UIButton{
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .large
        configuration.title = title
        configuration.attributedTitle?.font = Font.semiBold15
        configuration.baseForegroundColor = .red
        configuration.background.strokeColor = .red
        configuration.baseBackgroundColor = Color.white
        configuration.automaticallyUpdateForSelection = true
        configuration.buttonSize = .small
        configuration.titleAlignment = .center
        configuration.titlePadding = .greatestFiniteMagnitude
        let button = UIButton(configuration: configuration, primaryAction: nil)
        let handler: (UIButton) -> Void = { button in
            var configUpdate = button.configuration
         
            switch button.state {
            case.selected:
                configUpdate?.baseBackgroundColor = Color.darkGray
                configUpdate?.baseForegroundColor = Color.white
                configUpdate?.background.strokeColor = Color.darkGray
            default:
                configUpdate?.baseBackgroundColor = Color.white
                configUpdate?.baseForegroundColor = Color.darkGray
                configUpdate?.background.strokeColor = Color.darkGray
            }
            button.configuration = configUpdate
        }
        button.configurationUpdateHandler = handler
        return button
    }
}
