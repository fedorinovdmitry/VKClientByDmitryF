//
//  DateFormater + RuDate.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 11.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import Foundation

extension DateFormatter {
    static func giveRuFormat(date: TimeInterval) -> String {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        let date = Date(timeIntervalSince1970: date)
        return dt.string(from: date)
    }
}
