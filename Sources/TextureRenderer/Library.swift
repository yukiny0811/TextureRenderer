//
//  File.swift
//  TextureRenderer
//
//  Created by Yuki Kuwashima on 2024/12/14.
//

import MetalKit

actor Library {
    
    static let vertexDescriptor: MTLVertexDescriptor = {
        let desc = MTLVertexDescriptor()
        desc.attributes[0].format = .float3
        desc.attributes[0].offset = 0
        desc.attributes[0].bufferIndex = 0
        desc.attributes[1].format = .float2
        desc.attributes[1].offset = 0
        desc.attributes[1].bufferIndex = 1
        desc.layouts[0].stride = MemoryLayout<simd_float3>.stride
        desc.layouts[0].stepRate = 1
        desc.layouts[0].stepFunction = .perVertex
        desc.layouts[1].stride = MemoryLayout<simd_float2>.stride
        desc.layouts[1].stepRate = 1
        desc.layouts[1].stepFunction = .perVertex
        return desc
    }()
     
    static let renderTextureState: MTLRenderPipelineState = {
        let vertFunction = ShaderUtils.library.makeFunction(name: "renderTexture_vert")!
        let fragFunction = ShaderUtils.library.makeFunction(name: "renderTexture_frag")!
        let desc = MTLRenderPipelineDescriptor()
        desc.vertexDescriptor = vertexDescriptor
        desc.vertexFunction = vertFunction
        desc.fragmentFunction = fragFunction
        desc.colorAttachments[0].pixelFormat = .bgra8Unorm
        let state = try! ShaderUtils.device.makeRenderPipelineState(descriptor: desc)
        return state
    }()
}
