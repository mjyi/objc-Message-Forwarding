//
//  Animal.m
//  DynamicMethod
//
//

#import "Animal.h"
#import <objc/runtime.h>

@implementation Cat

void runMethod(id self, SEL _cmd)
{
    NSLog(@"Cat run！");
}

- (void)eat {
    NSLog(@"Cat eat！");
}

// 是否动态添加方法
+ (BOOL)resolveInstanceMethod:(SEL)aSEL
{
    if([NSStringFromSelector(aSEL) isEqualToString:@"run"]){
        class_addMethod([self class], aSEL, (IMP)runMethod, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:aSEL];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"sing"]) {
        return [[Dog alloc] init];
    }
    return nil;
}


// 返回方法选择器
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"sleep"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

// 修改调用对象
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    [anInvocation setSelector:@selector(eat)];
    [anInvocation invokeWithTarget:self];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"Dog消息无法处理： %@",NSStringFromSelector(aSelector));
}


@end


@implementation Dog

- (void)sing {
    NSLog(@"汪 汪!");
}

@end
