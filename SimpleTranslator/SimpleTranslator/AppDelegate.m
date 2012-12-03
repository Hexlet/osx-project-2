//
//  AppDelegate.m
//  SimpleTranslator
//
//  Created by Администратор on 11/28/12.
//  Copyright (c) 2012 Kirill.Muratov. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

NSMutableData *responseData;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
}

- (IBAction)translateText:(id)sender {
    NSString* textForTranslate = [_textField stringValue];
    NSString* srcLang = [_srcLang titleOfSelectedItem];
    NSString* destLang = [_destLang titleOfSelectedItem];
    
    /*
    //добавить возможность перевода текста из буффера
    NSPasteboard* pb = [NSPasteboard generalPasteboard];
    str = [pb stringForType: NSStringPboardType];
    [_labelResult setStringValue:str];
    */
    
    
    //для перевода используем api яндекса //to do инкапсулировать
    responseData = [[NSMutableData alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"http://translate.yandex.net/api/v1/tr.json/translate?lang=%@-%@&text=%@", srcLang, destLang, textForTranslate];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString: urlString];
    
    NSMutableURLRequest* req = [[NSMutableURLRequest alloc] initWithURL: url];
    [req setHTTPMethod:@"GET"];
    
    NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    
}


-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //nothing to do
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
   //nothing to do
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions
                          error: &error];

    //Что-то пошло не так
    if(json == nil){
        [_labelResult setStringValue: @""];
        //to do добавить проверку code == 200 в ответе
        return;
    };
        
    //результат перевода - массив строк
    NSArray *res = [json objectForKey:@"text"];
    NSMutableString *translatedText = [[NSMutableString alloc] init] ;
    for (int i = 0; i < [res count]; i++) {
        [translatedText appendString:[res objectAtIndex: i]];
    }
    
    [_labelResult setStringValue: translatedText];

}

@end
