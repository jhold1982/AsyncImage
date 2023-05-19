//
//  ContentView.swift
//  AsyncImage
//
//  Created by Justin Hold on 5/18/23.
//

import SwiftUI

extension Image {
	func imageModifier() -> some View {
		self
			.resizable()
			.scaledToFit()
	}
	func iconModifier() -> some View {
		self
			.imageModifier()
			.frame(maxWidth: 128)
			.foregroundColor(.purple)
			.opacity(0.5)
	}
}

struct ContentView: View {
	private let imageURL: String = "https://credo.academy/credo-academy@3x.png"
    var body: some View {
        VStack {
			// MARK: BASIC
//			AsyncImage(url: URL(string: imageURL))
			
			// MARK: SCALE
//			AsyncImage(url: URL(string: imageURL), scale: 3.0)
			
			// MARK: CUSTOM PLACEHOLDER
//			AsyncImage(url: URL(string: imageURL)) { image in
//				image
//					.imageModifier()
//			} placeholder: {
//				Image(systemName: "photo.circle.fill")
//					.iconModifier()
//			}
//			.padding(40)
			
			// MARK: PHASE
//			AsyncImage(url: URL(string: imageURL)) { phase in
//				// Success: The image successfully loaded
//				// Failure: The image failed to load
//				// Empty: No image is loaded
//				if let image = phase.image {
//					image
//						.imageModifier()
//				} else if phase.error != nil {
//					Image(systemName: "ant.circle.fill")
//						.iconModifier()
//				} else {
//					Image(systemName: "photo.circle.fill")
//						.iconModifier()
//				}
//			}
//			.padding(40)
			
			// MARK: ANIMATION
			AsyncImage(url: URL(string: imageURL), transaction: Transaction(animation: .spring(
				response: 0.5,
				dampingFraction: 0.6,
				blendDuration: 0.25
			))) { phase in
				switch phase {
				case .success(let image):
					image
						.imageModifier()
//						.transition(.move(edge: .bottom))
//						.transition(.slide)
						.transition(.scale)
				case .failure(_):
					Image(systemName: "ant.circle.fill")
						.iconModifier()
				case .empty:
					Image(systemName: "photo.circle.fill")
						.iconModifier()
				@unknown default:
					ProgressView()
				}
			}
			.padding(40)
		}
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
