// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let repositories = try? JSONDecoder().decode(Repositories.self, from: jsonData)

import Foundation

// MARK: - Repository
struct Repository: Codable {
    let name: String
    let description: String?
}
