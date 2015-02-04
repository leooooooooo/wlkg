//
//  xml.h
//  SOAP2
//
//  Created by leo on 14/8/20.
//  Copyright (c) 2014年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol parser <NSObject>

- (void)returnparser:(NSMutableArray *)parser;

@end

@interface parser:NSObject<NSXMLParserDelegate>{
    NSMutableArray *ars;
}
@property (nonatomic,retain)id<parser>send;
- (void)nsxmlparser:(NSString *)xml;


@end

