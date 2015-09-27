#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface NSString (CUUtils)

/**
 *  Первая буква строки
 *
 *  @return пустую строку для пустой строки или первую букву в других случаях
 */
- (NSString *)firstLetter;

/**
 *  Проверка на наличие подстроки в строке
 *
 *  @param string подстрока, которую ищем
 *
 *  @return YES, если такая подстрока в строке есть
 */
- (BOOL)containsString:(NSString *)string;

/**
 *  Проверка на наличие подстроки в начале текущей строки
 *
 *  @param string подстрока, которую ищем
 *
 *  @return YES, если текущая строка начинается с указанной подстроке
 */
- (BOOL)startsWith:(NSString *)string;

/**
 *  Проверка на наличие подстроки в конце текущей строки
 *
 *  @param string подстрока, которую ищем
 *
 *  @return YES, если текущая строка заканчивается на указанную подстроку
 */
- (BOOL)endsWith:(NSString *)string;

/**
 *  Обрезка пробельных символов в начале и конце строки
 *
 *  @return копию строки без пробельных символов в начале и конце
 */
- (NSString *)stringByTrimming;

/**
 *  Удаление подстрок из строки
 *  Более короткая запись stringByReplacingOccurrencesOfString:string withString:@""
 *
 *  @param string что удаляем
 */
- (NSString *)stringByDeletingOccurrencesOfString:(NSString *)string;

/**
 *  Полный NSRange для текущей строки. Более краткая запись для:
 *  @code
 *  NSMakeRange(0, self.length)
 *  @endcode
 *
 *  @return NSRange с началом в 0 и длиной в длину строки
 */
- (NSRange)fullRange;

/**
 *  Получает высоту данной строки с нужным шрифтом и для указанной ширины при многострочном написании.
 *
 *  @param font  шрифт
 *  @param width ширина строки
 *
 *  @return высота
 */
- (CGFloat)heightWithFont:(UIFont *)font
       constrainedToWidth:(CGFloat)width;

/**
 *  Декодирование текста вида "\U041e\U0435"
 *
 *  @return строка с правильными unicode-символами
 */
- (NSString *)stringByDecodingUnicode;

/**
 *  Опеределяет явлется ли строка представлением селектора-мутатора
 */
- (BOOL)isSetterString;

/**
 *  Возвращает массив компонентов, разделенных точкой с запятой или запятой
 *  Если в строке содержатся одновременно и запятые и точки с запятой, то отдает предпочтение точке с запятой
 *  Потому что иногда в строках передают RGB цвета, например rgb(255,255,0);rbg(255,0,255)
 *  @param trimSpaces нужно ли удалять пробелы перед разделением строки
 */
- (NSArray *)componentsSeparatedBySemicolonOrComma:(BOOL)trimSpaces;


/**
 *  MD5-хеш строки
 *
 *  @return MD5-хеш
 */
- (NSString *)md5Hash;

/**
 *  Строка UUID
 */
+ (NSString *)uuidString;

@end
