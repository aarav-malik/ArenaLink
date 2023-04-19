import SwiftUI

let matches: [Game] = [
    Game(homeTeam: "LA Galaxy", awayTeam: "San Jose Earthquakes", homeScore: 3, awayScore: 2),
    Game(homeTeam: "LA Galaxy", awayTeam: "Portland Timbers", homeScore: 1, awayScore: 0),
    Game(homeTeam: "New York Red Bulls", awayTeam: "D.C. United", homeScore: 2, awayScore: 1)
]


let gamesToday: [Game] = [
    Game(homeTeam: "LA Galaxy", awayTeam: "New York Red Bulls", homeScore: 3, awayScore: 2)
]

struct Game: Hashable {
    let homeTeam: String
    let awayTeam: String
    let homeScore: Int
    let awayScore: Int
    
}



