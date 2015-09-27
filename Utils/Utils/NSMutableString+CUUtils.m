#import "NSMutableString+CUUtils.h"
#import "NSString+CUUtils.h"

@implementation NSMutableString (CUUtils)

- (void)replaceOccurrencesOfString:(NSString *)pattern withString:(NSString *)replaceStr {
    [self replaceOccurrencesOfString:pattern
                          withString:replaceStr
                             options:0
                               range:self.fullRange];
}

@end
