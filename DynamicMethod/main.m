//
//  main.m
//  DynamicMethod
//
//

#import <Foundation/Foundation.h>
#import <objc/objc-runtime.h>
#import "Animal.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Cat *cat = [[Cat alloc] init];
        
        // 强制转换objc_msgSend函数类型为带两个参数且返回值为void函数
        ((void (*)(id, SEL))objc_msgSend)(cat, NSSelectorFromString(@"run"));
        ((void (*)(id, SEL))objc_msgSend)(cat, NSSelectorFromString(@"sing"));
        ((void (*)(id, SEL))objc_msgSend)(cat, NSSelectorFromString(@"sleep"));
    }
    return 0;
}
