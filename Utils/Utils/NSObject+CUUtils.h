#import <Foundation/Foundation.h>

@interface NSObject (CUUtils)

/**
 *  Получить все дочерние классы текущего класса.
 *
 *  @return список дочерних классов, сам класс не включается в список
 */
+ (NSArray *)findAllChildClasses;

@end
