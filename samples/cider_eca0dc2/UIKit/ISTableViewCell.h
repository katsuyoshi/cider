//
//  ISTableViewCell.h
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


#import <UIKit/UIKit.h>

typedef enum {

    // These are same as UITableViewCellStyle...
    ISTableViewCellStyleDefault,	// Simple cell with text label and optional image view (behavior of UITableViewCell in iPhoneOS 2.x)
    ISTableViewCellStyleValue1,		// Left aligned label on left and right aligned label on right with blue text (Used in Settings)
    ISTableViewCellStyleValue2,		// Right aligned label on left with blue text and left aligned label on right (Used in Phone/Contacts)
    ISTableViewCellStyleSubtitle	// Left aligned label on top and left aligned label on bottom with gray text (Used in iPod).

    // These are including UITextField.
    , ISTableViewCellEditingStyleDefault = 10000    // editable style of UITableViewCellStyleDefault
    , ISTableViewCellEditingStyleValue1              // editable style of UITableViewCellStyleValue1
    , ISTableViewCellEditingStyleValue2              // editable style of UITableViewCellStyleValue2
    , ISTableViewCellEditingStyleSubtitle           // editable style of UITableViewCellStyleSubtitle

} ISTableViewCellStyle;                 // available in iPhone 3.0



@interface ISTableViewCell : UITableViewCell {

    ISTableViewCellStyle _style;
    UITextField *_textField;
    UITextField *_detailTextField;
    
    UIColor *_textColor;
    UIColor *_highlightedTextColor;
    
    BOOL doneSetFontSize;
}

- (id)initWithStyle:(ISTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, readonly, retain) UITextField *textField;
@property (nonatomic, readonly, retain) UITextField *detailTextField;

/**
 * An Editable text field's textColor.
 * If you want to change textField or detailTextField's textColor,
 * set this property.
 */
@property (nonatomic, retain) UIColor *textColor;

/**
 * An Editable text field's highlightedTextColor.
 * If you want to change textField or detailTextField's highlightedTextColor,
 * set this property.
 */
@property (nonatomic, retain) UIColor *highlightedTextColor;


@end
