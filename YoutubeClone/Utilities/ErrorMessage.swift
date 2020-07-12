//
//  ErrorMessage.swift
//  YoutubeClone
//
//  Created by Ajay Choudhary on 12/07/20.
//  Copyright © 2020 Ajay Choudhary. All rights reserved.
//

enum ErrorMessage: String, Error {
    case invalidRequest = "Inavlid request. Please try again"
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from server. Please try again."
    case invalidData = "Data received from the server was invalid. Please try again."
}
