// This file is part of the FidelityFX SDK.
//
// Copyright (C) 2024 Advanced Micro Devices, Inc.
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files(the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions :
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#include "fullscreen.hlsl"
#include "spd_common.h"

//--------------------------------------------------------------------------------------
// Constant Buffer
//--------------------------------------------------------------------------------------
// Fullscreen.hlsl binds to b0, so contants need to start at b1 if using fullscreen.hlsl
cbuffer constants : register(b0)
{
    SPDDownsampleInfo DownsampleInfo;
}

//--------------------------------------------------------------------------------------
// Texture definitions
//--------------------------------------------------------------------------------------
Texture2D        inputTex         : register(t0);
SamplerState     linearSampler    : register(s0);

//--------------------------------------------------------------------------------------
// Main function
//--------------------------------------------------------------------------------------
float4 mainPS(VertexOut input) : SV_Target
{
    float2 texCoord = input.UVOut * DownsampleInfo.OutSize;
    texCoord = texCoord * DownsampleInfo.InvSize * 2.0;

    return inputTex.Sample(linearSampler, texCoord);
}
