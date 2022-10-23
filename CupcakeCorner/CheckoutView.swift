//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by itsjagnezi on 19/10/22.
//

import SwiftUI

struct CheckoutView: View {
	
	@ObservedObject var order: Order
	
	@State private var alertMessage = ""
	@State private var showingAlert = false
	@State private var alertTitle = ""
	
	private let cupcakeSize: CGFloat = 50
	@State private var offset = CGSize.zero
	
	let feedback = Feedback()
	
	
	
	var drag: some Gesture {
		DragGesture()
			.onChanged { value in
				offset = CGSize(
					width: value.startLocation.x + value.translation.width - cupcakeSize/2,
					height: value.startLocation.y + value.translation.height - cupcakeSize/2
				)
			}
	}
	
	
	var body: some View {
		VStack {
			AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
				image
					.resizable()
					.scaledToFit()
					.cornerRadius(8)
			} placeholder: {
				ProgressView()
			}
			.frame(height: 233)
			
			Text("Your total is \(order.data.cost, format: .currency(code: "BRL"))")
				.font(.title)
			
			HStack {
				ForEach(0..<order.data.quantity) { _ in
					Text("🧁")
						.font(.largeTitle)
						.offset(offset)
						.gesture(drag)
				}
			}
			
			Button("Place Order") {
				Task {
					await placeOrder()
				}
				feedback.vibrate()
			}
			.padding()
		}
		.navigationTitle("Check out")
		.navigationBarTitleDisplayMode(.inline)
		.alert(alertTitle, isPresented: $showingAlert) {
			Button("OK") { }
		} message: {
			Text(alertMessage)
		}
	}
	
	func placeOrder() async {
		guard let encoded = try? JSONEncoder().encode(order.data) else {
			print("Failed to encode order")
			return
		}
		
		let url = URL(string: "https://reqres.in/api/cupcakes")!
		var request = URLRequest(url: url)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpMethod = "POST"
		
		do {
			let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
			
			let decodedOrder = try JSONDecoder().decode(Order.OrderStruct.self, from: data)
			alertTitle = "Thank you!"
			alertMessage = "Your order for \(decodedOrder.quantity)x \(Order.OrderStruct.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
			showingAlert = true
		} catch {
			alertTitle = "Oops! We have an error here"
			alertMessage = "Something happend! We will sove it ASAP!"
			showingAlert = true
		}
	}
	
}

struct CheckoutView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			CheckoutView(order: Order())
		}
	}
}
