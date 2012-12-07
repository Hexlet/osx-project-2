//
//  AppDelegate.m
//  CreditInspector
//
//  Copyright (c) 2012 self. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [_combo selectItemAtIndex:0];
    
}

- (IBAction)show:(id)sender {
    rows = [[NSMutableArray alloc] init];
    NSInteger ttl = [[_total stringValue] integerValue];
    float p = [[_param stringValue] floatValue];
    float proc = [[_percent stringValue] floatValue];
    proc = proc/100;
    NSInteger t=ttl;
    
    if([[_combo stringValue] isEqualToString:@"years"]){
        
        p = roundf(100*(t+t*proc*p)/(p*12))/100;
        
        [_summary setStringValue:[NSString stringWithFormat:@"Payment %g",p]];
        
    }
    
    
    float pocv, allp;
    float m=0;
    
    if(p<=roundf(100*t*proc/12)/100){
     
        [_param setTextColor: [NSColor colorWithDeviceRed:1 green: 0 blue: 0 alpha: 1]];
        return;
    }
    else {
        [_param setTextColor: [NSColor colorWithDeviceRed:0 green: 0 blue: 0 alpha: 1]];
    }
    
    while (t>0)
    {
        pocv = roundf(100*t*proc/12)/100;
        
        p = (t>p?p:t);
        NSLog(@"p=%g, %%=%g",p,pocv);
        [rows addObject:[NSNumber numberWithFloat: t+pocv]];
        [rows addObject:[NSNumber numberWithFloat: p-pocv]];
        [rows addObject:[NSNumber numberWithFloat: pocv]];
        t = t+pocv-p;
        
        allp+=p;
        m++;
    }
   
    
    if([[_combo stringValue] isEqualToString:@"payment"]){
        float rowc = roundf(100*m/12)/100;
       
        
        [_summary setStringValue:[NSString stringWithFormat:@"Years %g",rowc]];
        
    }
    
    [_summary setStringValue:[NSString stringWithFormat:@"%@ Sum:%g, Over:%g (%g %%)",
                              [_summary stringValue],
                              allp,
                              allp-ttl,
                              roundf(1000*(allp-ttl)/ttl)/10
                              ]
     ];
    
    [_tableView reloadData];
    
}

-(NSInteger) numberOfRowsInTableView:(NSTableView *) tv{
    
    return [rows count]/3;
}

-(id) tableView:(NSTableView *) tv objectValueForTableColumn:(NSTableColumn *)col row:(NSInteger)row {
    
  
  // NSNumber *s = //[NSNumber numberWithLong:[tv columnWithIdentifier:[col identifier]]];
 //   NSLog(@"%ld",(row+[[col identifier] integerValue]));
    if([[col identifier] integerValue] == 4) return [NSString stringWithFormat:@"%ld",row];
    NSNumber *s = [rows objectAtIndex:(row*3+[[col identifier] integerValue])] ;
    return s;
}
@end
