//
//  LearnUrlSession.swift
//  CupcakeCorner
//
//  Created by itsjagnezi on 18/10/22.
//

import SwiftUI

struct Response: Codable {
	var results: [Result]
}

struct Result: Codable {
	var trackId: Int
	var trackName: String
	var collectionName: String
}

struct LearnUrlSession: View {
	
	@State private var results = [Result]()
	
    var body: some View {
			List(results, id: \.trackId) { item in
				VStack(alignment: .leading) {
					Text(item.trackName)
						.font(.headline)
					Text(item.collectionName)
				}
			}.task {
					await loadData()
				}
    }
	
	/// Load a list of musics from itunes and set the data to @State `results`
	///
	/// The data is decoded from `json` to `Response` type
	func loadData() async {
		guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
			print("Invalid URL")
			return
		}
		
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			
			if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
				results = decodedResponse.results
			}
		} catch {
			print("Invalid data")
		}
		
		
	}
}

struct LearnUrlSession_Previews: PreviewProvider {
    static var previews: some View {
        LearnUrlSession()
    }
}
