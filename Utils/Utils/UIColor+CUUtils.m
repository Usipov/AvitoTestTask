#import "UIColor+CUUtils.h"
#import "CUUtils.h"

static NSCache *__colorsCache = nil;

@implementation UIColor (CUUtils)

+ (void)initialize {
    __colorsCache = [NSCache new];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
	int r = (hex >> 16) & 0xFF;
	int g = (hex >> 8) & 0xFF;
	int b = (hex) & 0xFF;
	
	return [UIColor colorWithRed:r / 255.0f
						   green:g / 255.0f
							blue:b / 255.0f
						   alpha:1.0f];
}

- (NSUInteger)RGBHex {
    CGFloat red, green, blue, alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    NSInteger ired, igreen, iblue;
    ired = roundf(red * 255);
    igreen = roundf(green * 255);
    iblue = roundf(blue * 255);
    NSUInteger result = (ired << 16) | (igreen << 8) | iblue;
    return result;
}

+ (UIColor *)colorForName:(NSString *)colorName dark:(BOOL)dark {
    NSString *colorFullName = [colorName stringByAppendingFormat:@"-%i", dark];
    UIColor *color = [__colorsCache objectForKey:colorFullName];
    if (! color) {
        color = dark ? [self darkColorForName:colorName] : [self lightColorForName:colorName];
        if (color) {
            [__colorsCache setObject:color forKey:colorFullName];
        }
    }
    return color;
}

+ (UIColor *)lightColorForName:(NSString *)colorName {
    if ([colorName isEqualToString:@"green"])   return [UIColor colorWithRGBHex:0x94B74C];
    if ([colorName isEqualToString:@"yellow"])  return [UIColor colorWithRGBHex:0xFFDB4C];
    if ([colorName isEqualToString:@"orange"])  return [UIColor colorWithRGBHex:0xFF944C];
    if ([colorName isEqualToString:@"blue"])    return [UIColor colorWithRGBHex:0x70B7DB];
    if ([colorName isEqualToString:@"red"])     return [UIColor colorWithRGBHex:0xFF4C4C];
    if ([colorName isEqualToString:@"grey"])    return [UIColor colorWithRGBHex:0xB7B7B7];
    
    if ([colorName isEqualToString:@"lightgreen"])  return [UIColor colorWithRGBHex:0xCCDCA3];
    if ([colorName isEqualToString:@"lightyellow"]) return [UIColor colorWithRGBHex:0xFFEFA0];
    if ([colorName isEqualToString:@"lightorange"]) return [UIColor colorWithRGBHex:0xFCCAA4];
    if ([colorName isEqualToString:@"lightblue"])   return [UIColor colorWithRGBHex:0xBBDAEF];
    if ([colorName isEqualToString:@"lightred"])    return [UIColor colorWithRGBHex:0xFAA7A7];
    if ([colorName isEqualToString:@"lightgrey" ])  return [UIColor colorWithRGBHex:0xDBDBDA];
    return nil;
}

+ (UIColor *)darkColorForName:(NSString *)colorName {
    if ([colorName isEqualToString:@"green"])   return [UIColor colorWithRGBHex:0x94944D];
    if ([colorName isEqualToString:@"yellow"])  return [UIColor colorWithRGBHex:0xFFB84D];
    if ([colorName isEqualToString:@"orange"])  return [UIColor colorWithRGBHex:0xFF714D];
    if ([colorName isEqualToString:@"blue"])    return [UIColor colorWithRGBHex:0x7194DB];
    if ([colorName isEqualToString:@"red"])     return [UIColor colorWithRGBHex:0xDB4D4D];
    if ([colorName isEqualToString:@"grey"])    return [UIColor colorWithRGBHex:0x949494];
    
    if ([colorName isEqualToString:@"lightgreen"])  return [UIColor colorWithRGBHex:0xC9C9A5];
    if ([colorName isEqualToString:@"lightyellow"]) return [UIColor colorWithRGBHex:0xFCDBA2];
    if ([colorName isEqualToString:@"lightorange"]) return [UIColor colorWithRGBHex:0xF6B5A3];
    if ([colorName isEqualToString:@"lightblue"])   return [UIColor colorWithRGBHex:0xB7C6EC];
    if ([colorName isEqualToString:@"lightred"])    return [UIColor colorWithRGBHex:0xE4A5A5];
    if ([colorName isEqualToString:@"lightgrey" ])  return [UIColor colorWithRGBHex:0xCACACA];
    return nil;
}

+ (UIColor *)colorFromRGBString:(NSString *)rgbString {
    UIColor *color = nil;
    
    if ([rgbString containsString:@"rgb("]) {
        NSArray *colorComponents = [[[rgbString stringByReplacingOccurrencesOfString:@"rgb(" withString:@""]
                                    stringByReplacingOccurrencesOfString:@")" withString:@""]
        componentsSeparatedByString:@","];
        if (colorComponents.count == 3) {
            color = RGB([colorComponents[0] integerValue],
                        [colorComponents[1] integerValue],
                        [colorComponents[2] integerValue]);
        }
    }
    
    return color;

}

@end
