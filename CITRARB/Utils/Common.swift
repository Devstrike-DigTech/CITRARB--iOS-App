//
//  Common.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import Foundation
import SwiftUI

public var BASE_URL = "https://citrab.onrender.com/api/"
public var APP_NAME = "Coal City Connect"
public var AUTH_TOKEN_KEY = "AuthToken"
public var NEWS_COLOR = Color.blue
public var TV_COLOR = Color.red
public var EYE_WITNESS_COLOR = Color.green
public var MEMBERS_COLOR = Color.mint
public var MARKET_PLACE_COLOR = Color.purple
public var EVENTS_COLOR = Color.pink
public var CONNECT_COLOR = Color.brown
public var MUSIC_COLOR = Color.cyan
public var UPLOADS_COLOR = Color.indigo

public var isLoggedIn: Bool = false
public var token: String = UserDefaults.standard.string(forKey: AUTH_TOKEN_KEY) ?? ""




