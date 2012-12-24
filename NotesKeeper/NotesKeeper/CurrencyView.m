//
//  CurrencyView.m
//  NotesKeeper
//
//  Created by Stan Buran on 19/12/12.
//  Copyright (c) 2012 apoidea. All rights reserved.
//

#import "CurrencyView.h"

@implementation CurrencyView

- (id)initWithCurrency: (NSString *) codeVal Description : (NSString *) descrVal Frame: (CGRect)frameVal {
    self = [super initWithFrame:frameVal];
    if (self)
	{
		float leftMargin = 10.0f;

		//Image:
		UIImage *image = [UIImage imageNamed: [NSString stringWithFormat:@"%@.gif",codeVal]];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		//imageView.frame = CGRectMake(35,5,24,18);
		imageView.frame = CGRectMake(leftMargin,5,image.size.width, image.size.height);
		[self addSubview:imageView];


		//Title:
		//CGRect rectTitle = CGRectMake(image.size.width + 40,1,50,18);
		CGRect rectTitle = CGRectMake(leftMargin + image.size.width + 5,1,50,18);
		UILabel *lblCode = [[UILabel alloc] initWithFrame: rectTitle];
		lblCode.font = [UIFont systemFontOfSize:14.0f];
		lblCode.text = codeVal;
		lblCode.backgroundColor = [UIColor clearColor];
		[self addSubview:lblCode];

		//Description:
		//CGRect rectDescr = CGRectMake(40,22,150,18);
		CGRect rectDescr = CGRectMake(leftMargin,22,150,18);
		UILabel *lblDesc = [[UILabel alloc] initWithFrame: rectDescr];
		lblDesc.font = [UIFont systemFontOfSize:12.0f];
		lblDesc.text =  descrVal;
		lblDesc.backgroundColor = [UIColor clearColor];
		[self addSubview:lblDesc];
    }
    return self;
}

/* 
// Only override drawRect: if you perform custom drawing. An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
@end
