//
//  BreedsListResponse.swift
//  rendom
//
//  Created by Ghada Al on 16/05/1440 AH.
//  Copyright © 1440 ghadaalone. All rights reserved.
//

import Foundation
struct BreedsListResponse: Codable {
    let status: String
    let message: [String:[String]]
}
