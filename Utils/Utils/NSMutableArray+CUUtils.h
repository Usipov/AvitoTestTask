#import <Foundation/Foundation.h>

@interface NSMutableArray (CUUtils)

/**
 *  Удалить первый элемент из текущего массива
 *
 *  @return удаленный первый элемент
 */
- (id)popFirstObject;

/**
 *  Удалить последний элемент из текущего массива
 *
 *  @return удаленный последний элемент
 */
- (id)popLastObject;

/**
 *  Удалить случайный элемент из текущего массива
 *
 *  @return удаленный случайный элемент
 */
- (id)popRandomObject;

@end
