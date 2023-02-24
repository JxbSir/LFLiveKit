//
//  XBHardwareH265VideoEncoder.h
//

#import "LFVideoEncoding.h"

@interface XBHardwareH265VideoEncoder : NSObject<LFVideoEncoding>

#pragma mark - Initializer
///=============================================================================
/// @name Initializer
///=============================================================================
- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (nullable instancetype)new UNAVAILABLE_ATTRIBUTE;

@end
