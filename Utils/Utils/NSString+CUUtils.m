#import "NSString+CUUtils.h"
#import <CommonCrypto/CommonDigest.h>

#define NSSTRING_CUUTILS_SEPARATOR_COMMA @","
#define NSSTRING_CUUTILS_SEPARATOR_SEMICOLON @";"

@implementation NSString (CUUtils)

- (NSString *)firstLetter {
    if (self.length <= 1)
        return self;
    return [self substringToIndex:1];
}

- (BOOL)containsString:(NSString *)string {
    return string ? [self rangeOfString:string].location != NSNotFound : NO;
}

- (BOOL)startsWith:(NSString *)string {
    return [self rangeOfString:string].location == 0;
}

- (BOOL)endsWith:(NSString *)string {
    return [self rangeOfString:string options:NSBackwardsSearch].location + string.length == self.length;
}

- (NSString *)stringByTrimming {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSRange)fullRange {
    return NSMakeRange(0, self.length);
}

- (NSString *)stringByDeletingOccurrencesOfString:(NSString *)string {
    return [self stringByReplacingOccurrencesOfString:string withString:@""];
}

- (CGFloat)heightWithFont:(UIFont *)font
       constrainedToWidth:(CGFloat)width {
    NSDictionary *attrs = @{ NSFontAttributeName : font };
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attrs
                                     context:nil];

    return rect.size.height;
}

// код подправил отсюда http://stackoverflow.com/questions/2099349/using-objective-c-cocoa-to-unescape-unicode-characters-ie-u1234/11615076#11615076
- (NSString *)stringByDecodingUnicode {
    // unescape quotes and backwards slash
    NSString *unescapedString = [self stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    unescapedString = [unescapedString stringByReplacingOccurrencesOfString:@"\\\\" withString:@"\\"];
    
    // tokenize based on unicode escape char
    NSMutableString *tokenizedString = [NSMutableString string];
    NSScanner *scanner = [NSScanner scannerWithString:unescapedString];
    // без этого прогладывает пробелы
    scanner.charactersToBeSkipped = nil;
    while ([scanner isAtEnd] == NO) {
        // read up to the first unicode marker
        // if a string has been scanned, it's a token
        // and should be appended to the tokenized string
        NSString *token = nil;
        [scanner scanUpToString:@"\\u" intoString:&token];
        if (token && token.length > 0) {
            [tokenizedString appendString:token];
            continue;
        }

        [scanner setScanLocation:scanner.scanLocation + 2];
        unsigned value;
        if ([scanner scanHexInt:&value]) {            [tokenizedString appendString:[NSString stringWithFormat:@"%C", (unichar)value]];
        } else {
            break;
        }
    }
    
    [tokenizedString replaceOccurrencesOfString:@"\\n"
                                     withString:@"\n"
                                        options:0
                                          range:tokenizedString.fullRange];

    return tokenizedString;
}

- (BOOL)isSetterString {
    if (self.length > 4) {
        BOOL startsWithSet = [self startsWith:@"set"];
        if (startsWithSet) {
            // после set должна идти заглавная буква
            char forthChar = [self characterAtIndex:3];
            BOOL forthCharIsUppercase = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:forthChar];
            if (forthCharIsUppercase) {
                // строка должна содержать двоеточие
                if ([self containsString:@":"]) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

- (NSArray *)componentsSeparatedBySemicolonOrComma:(BOOL)trimSpaces {
    NSString *pureString = trimSpaces ? [self stringByReplacingOccurrencesOfString:@" " withString:@""] : self;
    
    NSString *separatorString = ([pureString containsString:NSSTRING_CUUTILS_SEPARATOR_SEMICOLON]
                                ? NSSTRING_CUUTILS_SEPARATOR_SEMICOLON
                                : NSSTRING_CUUTILS_SEPARATOR_COMMA);

    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:separatorString];
    pureString = [pureString stringByTrimmingCharactersInSet:set];
    return [pureString componentsSeparatedByString:separatorString];
}

- (NSString *)md5Hash {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0],
            result[1],
            result[2],
            result[3],
            result[4],
            result[5],
            result[6],
            result[7],
            result[8],
            result[9],
            result[10],
            result[11],
            result[12],
            result[13],
            result[14],
            result[15]
            ];
}

+ (NSString *)uuidString {
    // Returns a UUID
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    CFRelease(uuid);
    
    return uuidString;
}

@end
