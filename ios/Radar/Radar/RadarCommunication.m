//
//  RadarCommunication.m
//  Radar
//
//  Copyright (c) 2013 Cedexis. All rights reserved.
//

#import "RadarCommunication.h"

@implementation RadarCommunication

@synthesize data = _data;
@synthesize completion = _completion;

- (NSString *)url {
    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendString:@"http://"];
    [result appendString:[self.data hostname]];
    
    for (NSString *current in [self.data pathParts]) {
        //NSLog(@"Current: %@", current);
        [result appendFormat:@"/%@", current];
    }
    
    // Add query string
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    NSString *cacheBusting = [NSString stringWithFormat:@"rnd=%@", uuidString];
    NSString *queryString = [self.data queryString];

    if (0 < [queryString length]) {
        [result appendFormat:@"?%@&%@", queryString, cacheBusting];
    }
    else {
        [result appendFormat:@"?%@", cacheBusting];
    }
    
    // URL-encoding
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
        NULL, (CFStringRef)result, NULL, NULL, kCFStringEncodingUTF8));
}

- (NSDictionary *)toDictionary {
    return [self.data toDictionary];
}

@end
