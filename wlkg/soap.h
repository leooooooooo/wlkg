//
//  NSObject+soap.h
//  SOAP2
//
//  Created by leo on 14/8/18.
//  Copyright (c) 2014年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol stringDelegate <NSObject>

-(void)returnxml:(NSString *)xml;

@end

@interface soap : NSObject
{
    NSMutableString *soapResults;
    NSXMLParser *xmlParser;
    BOOL elementFound;
    NSString *matchingElement;
    NSURLConnection *conn;
    NSURL *url;
    NSString *soapMsg;
    NSMutableArray *ars;
}
@property (retain,nonatomic)id<stringDelegate>sendDelegate;
@property(retain,nonatomic)NSMutableData *webData;
@property (strong, nonatomic) NSURLConnection *conn;


-(NSString *)matchingElement:(NSString *)matching;
-(NSString *)soapMsg:(NSString *)soapMessage;
-(NSURL *)url:(NSString *)serviceUrl;
-(void)send;


@end
