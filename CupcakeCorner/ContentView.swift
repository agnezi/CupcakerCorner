//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by itsjagnezi on 17/10/22.
//

import SwiftUI

struct ContentView: View {
	@StateObject var order = Order()
	
	var body: some View {
		NavigationView {
			Form {
				Section {
					Picker("Select your cupcake", selection: $order.data.type) {
						ForEach(Order.OrderStruct.types.indices) {
							Text(Order.OrderStruct.types[$0])
						}
					}
					
					Stepper("Number of cakes: \(order.data.quantity)", value: $order.data.quantity, in: 3...20)
				}
				
				Section {
					Toggle("Any special requests?", isOn: $order.data.specialRequestEnabled.animation())
					
					if order.data.specialRequestEnabled {
						Toggle("Add extra frosting", isOn: $order.data.extraFrosting)
						Toggle("Add extra sprinkles", isOn: $order.data.addSprinkles)
					}
				}
				
				Section {
					NavigationLink {
						AddressView(order: order)
					} label: {
						Text("Delivery details")
					}
				}
			}
			.navigationTitle("Cupcake Corner")
		}
		.preferredColorScheme(.dark)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
