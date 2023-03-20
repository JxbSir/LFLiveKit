//
//  DenoiseUtils.h
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, NSLevel) {
    kLow,
    kModerate,
    kHigh,
    kVeryHigh
};

@interface DenoiseUtils : NSObject

- (int)nsProcessByData:(NSData *)data
            sampleRate:(uint32_t)sampleRate
          samplesCount:(int)samplesCount
                 level:(NSLevel)level;

@end

NS_ASSUME_NONNULL_END
