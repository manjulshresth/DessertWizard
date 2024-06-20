//
//  ImageLoader.swift
//  DessertWizard
//
//  Created by Manjul Shrestha on 6/17/24.
//

import SwiftUI

@MainActor final class ImageLoader: ObservableObject{
    @Published var image : Image? = nil
    
    func load(fromURLString urlString: String) async {
        guard let uiImage = await NetworkManager.shared.downloadImage(fromUrlString: urlString) else { return }
        self.image = Image(uiImage: uiImage)
    }
}

struct MealThumbImage: View {
    @StateObject private var loader = ImageLoader()
    let urlString: String
    
    var body: some View {
        if let image = loader.image {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Image(.dessertPlaceholder)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onAppear {
                    Task{
                        await loader.load(fromURLString: urlString)
                    }
                }
        }
    }
}
