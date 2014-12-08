//
//  SNListViewCell.m
//  SimpleNote
//
//  Created by Jason on 14/12/5.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNListViewCell.h"
#import "SNNoteModel.h"

@interface SNListViewCell()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end

@implementation SNListViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNote:(SNNoteModel *)note {
    _note = note;
    self.dateLabel.text = note.date;
}

@end
