#import <UIKit/UIKit.h>

@interface UIColor (CUUtils)

/**
 *  Создать UIColor по цвету вида 0xFF00FF
 */
+ (UIColor *)colorWithRGBHex:(UInt32)hex;

/**
 *  Получить цвет вида 0xFF00FF из UIColor
 */
- (NSUInteger)RGBHex;

/**
 *  Получить цвет по строки вида lightgreen
 *
 *  @param colorName имя цвета
 *  @param dark      более темный цвет используется для границы. светлый - для заливки
 *
 *  @return UIColor или nil, если имя цвета не найдено
 */
+ (UIColor *)colorForName:(NSString *)colorName dark:(BOOL)dark;

/**
 *  Создает цвета на основе строки вида rgb(255,0,255)
 *  @return UIColor, если строока нужного формата. или nil
 */
+ (UIColor *)colorFromRGBString:(NSString *)rgbString;

@end
