//
//  XBDenoiseUtils.m
//

#import "DenoiseUtils.h"

#include "dr_wav.h"
#include "timing.h"
#include "noise_suppression.h"

#ifndef nullptr
#define nullptr 0
#endif

@implementation DenoiseUtils

- (int)nsProcessByData:(NSData *)data
            sampleRate:(uint32_t)sampleRate
          samplesCount:(int)samplesCount
                 level:(NSLevel)level {
    int16_t *buffer = (int16_t *)data.bytes;
    if (buffer == nullptr) return -1;
    if (samplesCount == 0) return -1;
    size_t samples = MIN(160, sampleRate / 100);
    if (samples == 0) return -1;
    uint32_t num_bands = 1;
    int16_t *input = buffer;
    size_t nTotal = (samplesCount / samples);
    NsHandle *nsHandle = WebRtcNs_Create();
    int status = WebRtcNs_Init(nsHandle, sampleRate);
    if (status != 0) {
        printf("WebRtcNs_Init fail\n");
        return -1;
    }
    status = WebRtcNs_set_policy(nsHandle, (int)level);
    if (status != 0) {
        printf("WebRtcNs_set_policy fail\n");
        return -1;
    }
    for (int i = 0; i < nTotal; i++) {
        int16_t *nsIn[1] = {input};   //ns input[band][data]
        int16_t *nsOut[1] = {input};  //ns output[band][data]
        WebRtcNs_Analyze(nsHandle, nsIn[0]);
        WebRtcNs_Process(nsHandle, (const int16_t *const *) nsIn, num_bands, nsOut);
        input += samples;
    }
    WebRtcNs_Free(nsHandle);
    
    return 1;
}

@end
