//
//  xml.m
//  SOAP2
//
//  Created by leo on 14/8/20.
//  Copyright (c) 2014年 leo. All rights reserved.
//

#import "parser.h"
#define NEW_LINE_1  @"LoginInfoList"
#define NEW_LINE_2  @"LoginInfo"
#define NEW_LINE_3  @"undefine"
#define NEW_LINE_4  @"undefine"

@implementation parser

- (void)nsxmlparser:(NSString *)xml{
    ars = [[NSMutableArray alloc]init];
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:[xml dataUsingEncoding:NSUTF8StringEncoding]];
    [parser setDelegate:self];//设置NSXMLParser对象的解析方法代理
    [parser setShouldProcessNamespaces:NO];
    [parser parse];//开始解析
    [self.send returnparser:ars];
}



-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ( [elementName isEqualToString:NEW_LINE_1] )
    {
        [ars addObject:[[NSMutableArray alloc]init]];
        
    }
    if ( [elementName isEqualToString:NEW_LINE_2] )
    {
        [ars addObject:[[NSMutableArray alloc]init]];
        
    }
    if ( [elementName isEqualToString:NEW_LINE_3] )
    {
        [ars addObject:[[NSMutableArray alloc]init]];
        
    }
    if ( [elementName isEqualToString:NEW_LINE_4] )
    {
        [ars addObject:[[NSMutableArray alloc]init]];
        
    }
    elementName = nil;
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    
    [[ars objectAtIndex:[ars count]-1]addObject:string];
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
}
@end
