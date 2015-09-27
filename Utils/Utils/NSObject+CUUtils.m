#import "NSObject+CUUtils.h"
#import <objc/runtime.h>

@implementation NSObject (CUUtils)

+ (NSArray *)findAllChildClasses {
    
    int numberOfClasses = objc_getClassList(NULL, 0);
    __unsafe_unretained Class *classList = (Class *)malloc(numberOfClasses * sizeof(Class));
    numberOfClasses = objc_getClassList(classList, numberOfClasses);
    
    NSMutableArray *list = [NSMutableArray array];
    for (int i = 0; i < numberOfClasses; ++i)
    {
        Class cls = classList[i];
        
        // если не NSObject - пропускаем
        if (!class_respondsToSelector(cls, @selector(respondsToSelector:)))
            continue;
        
        // берем только дочерние
        if ([cls isSubclassOfClass:self] && cls != self) {
            [list addObject:cls];
        }
    }
    
    free(classList);
    
    return list;
}


@end
