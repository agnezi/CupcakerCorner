//
//  LearnAsyncImage.swift
//  CupcakeCorner
//
//  Created by itsjagnezi on 18/10/22.
//

import SwiftUI

struct LearnAsyncImage: View {
    var body: some View {
			AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
				if let image = phase.image {
					image
						.resizable()
						.scaledToFit()
				} else if phase.error != nil {
					Text("There was an error loading the image.")
				} else {
					ProgressView()
				}
			}
			.frame(width: 200, height: 200)
    }
}

struct LearnAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        LearnAsyncImage()
    }
}
