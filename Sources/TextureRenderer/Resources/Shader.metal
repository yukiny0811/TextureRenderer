//
//  File.metal
//  TextureRenderer
//
//  Created by Yuki Kuwashima on 2024/12/14.
//

#include <metal_stdlib>
using namespace metal;

struct RasterizerData {
    float4 position [[ position ]];
    float2 uv;
};

struct Vertex {
    float3 position [[ attribute(0) ]];
    float2 uv [[ attribute(1) ]];
};

vertex RasterizerData renderTexture_vert
(
 const Vertex vIn [[ stage_in ]]
 ) {
    RasterizerData data;
    data.position = float4(vIn.position, 1.0);
    data.uv = vIn.uv;
    return data;
}

fragment half4 renderTexture_frag
(
 RasterizerData rd [[stage_in]],
 texture2d<half, access::sample> tex [[ texture(0) ]]
 ) {
    constexpr sampler textureSampler (coord::normalized, address::repeat, filter::linear);
    const half4 sampledColor = tex.sample(textureSampler, float2(rd.uv.x, rd.uv.y));
    return sampledColor;
}
