//
//  SNNoteView.m
//  SimpleNote
//
//  Created by Jason on 14/12/5.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNNoteView.h"
#import "SNBodyLabel.h"
#import "SNNoteModel.h"

@interface SNNoteView()

@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet SNBodyLabel *textLabel;

@end

@implementation SNNoteView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)setNote:(SNNoteModel *)note {
    _note = note;
    self.date.text = note.date;
    self.textLabel.text = note.body;
}


@end
