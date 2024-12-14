//
//  ContentView.swift
//  SampleMacOS
//
//  Created by Yuki Kuwashima on 2024/12/14.
//

import SwiftUI
import TextureRenderer
import MetalKit

struct ContentView: View {
    
    let texture: MTLTexture = {
        let loader = MTKTextureLoader(device: MTLCreateSystemDefaultDevice()!)
        return try! loader.newTexture(
            name: "test",
            scaleFactor: 1,
            bundle: .main,
            options: [
                .textureUsage: NSNumber(value: MTLTextureUsage.shaderRead.rawValue | MTLTextureUsage.shaderWrite.rawValue),
            ]
        )
    }()
    
    var body: some View {
        TextureView(texture: texture)
    }
}
