//
//  LeyendaDetailExtrasVC.m
//  Leyenda
//
//  Created by Daniel Rodriguez on 8/6/13.
//  Copyright (c) 2013 Daniel Rodriguez. All rights reserved.
//

#import "LeyendaDetailExtrasVC.h"

@interface LeyendaDetailExtrasVC ()

@end

@implementation LeyendaDetailExtrasVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //self.leyendaText.text = self.leyendaModel.description;
    self.leyendaTitle.title = self.leyendaModel.title;
    
    NSArray* paragraphs = [self.leyendaModel.description componentsSeparatedByString: @"\n\n"];
    
    NSMutableAttributedString *formatedText = [[NSMutableAttributedString alloc] init];
    
    for (NSString *paragrahp in paragraphs) {
        UIColor *_black=[UIColor blackColor];
        UIFont *font=[UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
        
        NSMutableAttributedString *formatedParagraph=[[NSMutableAttributedString alloc] initWithString:paragrahp];
        
        [formatedParagraph addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, 1)];
        [formatedParagraph addAttribute:NSForegroundColorAttributeName value:_black range:NSMakeRange(0, 1)];
        [formatedParagraph appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n\n"]];
        
        [formatedText appendAttributedString:formatedParagraph];
    }
    
    self.leyendaText.attributedText = formatedText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

@end