//
//  ISTableViewCell.m
//  Cider
//
//  Created by Katsuyoshi Ito on 09/07/28.
//

/* 

  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.

  Redistribution and use in source and binary forms, with or without modification,
  are permitted provided that the following conditions are met:
  
      * Redistributions of source code must retain the above copyright notice,
        this list of conditions and the following disclaimer.
 
      * Redistributions in binary form must reproduce the above copyright notice,
        this list of conditions and the following disclaimer in the documentation
        and/or other materials provided with the distribution.
 
      * Neither the name of ITO SOFT DESIGN Inc. nor the names of its
        contributors may be used to endorse or promote products derived from this
        software without specific prior written permission.
 
  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

#import "ISTableViewCell.h"


@implementation ISTableViewCell

@synthesize textField = _textField, detailTextField = _detailTextField;
@synthesize textColor = _textColor, highlightedTextColor = _highlightedTextColor;


- (void)setDefaultAttributes:(UITextField *)textField from:(UILabel *)label
{
    textField.autoresizingMask = label.autoresizingMask;
    textField.font = [UIFont boldSystemFontOfSize:0];
    textField.borderStyle = UITextBorderStyleNone;
    self.textColor = label.textColor;
    self.highlightedTextColor = label.highlightedTextColor;
}

- (id)initWithStyle:(ISTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (style < ISTableViewCellEditingStyleDefault) {
        return [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:reuseIdentifier];
    } else {
        if (self = [super initWithStyle:(style - ISTableViewCellEditingStyleDefault) reuseIdentifier:reuseIdentifier]) {
            _style = style;
            if (_style == ISTableViewCellEditingStyleDefault) {
                _textField = [[UITextField alloc] initWithFrame:CGRectZero];
                [self setDefaultAttributes:_textField from:self.textLabel];
                [self.contentView addSubview:_textField];
                self.textLabel.hidden = YES;
            } else {
                _detailTextField = [[UITextField alloc] initWithFrame:CGRectZero];
                [self setDefaultAttributes:_detailTextField from:self.detailTextLabel];
                [self.contentView addSubview:_detailTextField];
                self.detailTextLabel.hidden = YES;
            }
        }
        return self;
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];

    if (_textField) {
        _textField.textColor = highlighted ? self.highlightedTextColor : self.textColor;
    }
    if (_detailTextField) {
        _detailTextField.textColor = highlighted ? self.highlightedTextColor : self.textColor;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

}


- (void)setFontSizeIfNeeds
{
    float height = self.contentView.frame.size.height;
    if (_textField && _textField.font.pointSize == 0) {
        UITableView *tableView = (UITableView *)[self superview];
        float size = 20;
        switch (_style) {
        case ISTableViewCellEditingStyleDefault:
            size = height - (43 - (tableView.style == UITableViewStylePlain ? 20 : 17));
            break;
        }
        _textField.font = [UIFont boldSystemFontOfSize:size];
    }
    if (_detailTextField && _detailTextField.font.pointSize == 0) {
        UITableView *tableView = (UITableView *)[self superview];
        BOOL bold = NO;
        float size = 20;
        switch (_style) {
        case ISTableViewCellEditingStyleValu1:
            size = height - (43 - (tableView.style == UITableViewStylePlain ? 20 : 17));
            break;
        case ISTableViewCellEditingStyleValu2:
            bold = YES;
            size = tableView.style == UITableViewStylePlain ? 15 : 15;
            break;
        case ISTableViewCellEditingStyleSubtitle:
            size = tableView.style == UITableViewStylePlain ? 14 : 14;
            break;
        }
        if (bold) {
            _detailTextField.font = [UIFont boldSystemFontOfSize:size];
        } else {
            _detailTextField.font = [UIFont systemFontOfSize:size];
        }
        _detailTextField.font = [UIFont fontWithName:_detailTextField.font.fontName size:size];
    }
    
}


- (void)layoutSubviewsWhenStyleDefault
{
    CGRect contentRect = self.contentView.bounds;
    CGRect rect = CGRectInset(contentRect, 10, 0);
    float height = contentRect.size.height;
    float textHeight = _textField.font.pointSize + 4;
    float y = (int)((height - textHeight) / 2);
    _textField.frame = CGRectMake(rect.origin.x, y, rect.size.width, textHeight);
}

- (void)layoutSubviewsWhenStyleValue1
{
    CGRect contentRect = self.contentView.bounds;
    float height = contentRect.size.height;
    
    float leftWidth = contentRect.size.width - 20 - 85;
    float textWidth = [_detailTextField.text sizeWithFont:_detailTextField.font constrainedToSize:CGSizeMake(leftWidth, contentRect.size.height)].width;
    float textHeight = _detailTextField.font.pointSize + 4;
    float y = (int)((height - textHeight) / 2);
    _detailTextField.frame = CGRectMake(contentRect.size.width - 10 - textWidth, y, textWidth, textHeight);
}

- (void)layoutSubviewsWhenStyleValue2
{
    CGRect contentRect = self.contentView.bounds;
    float width = contentRect.size.width;
    
    float textHeight = _detailTextField.font.pointSize + 4;
    float x = CGRectGetMaxX(self.textLabel.frame) + 5;
    _detailTextField.frame = CGRectMake(x, 12, width - 20 - 68 - 5, textHeight);
}

- (void)layoutSubviewsWhenStyleSubtitle
{
    CGRect contentRect = self.contentView.bounds;
    float width = contentRect.size.width;

    float textHeight = _detailTextField.font.pointSize + 4;
    float y = self.textLabel.font.pointSize + 4 + 2;
    _detailTextField.frame = CGRectMake(11, y, width - 21, textHeight);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setFontSizeIfNeeds];
    
    switch (_style) {
    case ISTableViewCellEditingStyleDefault:
        [self layoutSubviewsWhenStyleDefault];
        break;
    case ISTableViewCellEditingStyleValu1:
        [self layoutSubviewsWhenStyleValue1];
        break;
    case ISTableViewCellEditingStyleValu2:
        [self layoutSubviewsWhenStyleValue2];
        break;
    case ISTableViewCellEditingStyleSubtitle:
        [self layoutSubviewsWhenStyleSubtitle];
        break;
    }
}

- (void)dealloc {
    [_textColor release];
    [_highlightedTextColor release];
    [_textField release];
    [_detailTextField release];
    [super dealloc];
}

@end
