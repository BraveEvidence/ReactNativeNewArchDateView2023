//
//  RTNMyDateView.m
//  rnappdate
//
//  Created by  on 22/02/23.
//

#import "RTNMyDateView.h"

#import <react/renderer/components/RTNMyDateViewSpecs/ComponentDescriptors.h>
#import <react/renderer/components/RTNMyDateViewSpecs/EventEmitters.h>
#import <react/renderer/components/RTNMyDateViewSpecs/Props.h>
#import <react/renderer/components/RTNMyDateViewSpecs/RCTComponentViewHelpers.h>

#import "RCTFabricComponentsPlugins.h"

using namespace facebook::react;

@interface RTNMyDateView () <RCTRTNMyDateViewViewProtocol>
@end

@implementation RTNMyDateView {
  UIView *_view;
  UIDatePicker *_picker;
  
  NSString *_selectedDate;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<RTNMyDateViewComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const RTNMyDateViewProps>();
    _props = defaultProps;
    
    _view = [[UIView alloc] init];
    _picker = [[UIDatePicker alloc] init];
    _picker.translatesAutoresizingMaskIntoConstraints = false;
    [_picker setDatePickerMode:UIDatePickerModeDate];
    _picker.backgroundColor = [UIColor whiteColor];
    [_picker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    if (@available(iOS 13.4, *)) {
      [_picker setPreferredDatePickerStyle:UIDatePickerStyleWheels];
    } else {
      // Fallback on earlier versions
    }
    [_view addSubview:_picker];
    
    [NSLayoutConstraint activateConstraints:@[
      [_picker.leadingAnchor constraintEqualToAnchor:_view.leadingAnchor],
      [_picker.topAnchor constraintEqualToAnchor:_view.topAnchor],
      [_picker.trailingAnchor constraintEqualToAnchor:_view.trailingAnchor],
      [_picker.bottomAnchor constraintEqualToAnchor:_view.bottomAnchor],
    ]];
    
    self.contentView = _view;
  }
  
  return self;
}

-(void)onDatePickerValueChanged:(UIDatePicker *)datePicker
{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"YYYY/MM/dd"];
  NSString *originalDateString = [dateFormatter stringFromDate:datePicker.date];
  _selectedDate = originalDateString;
  
  if (_eventEmitter != nullptr) {
      std::dynamic_pointer_cast<const facebook::react::RTNMyDateViewEventEmitter>(_eventEmitter)->onDatePicked(facebook::react::RTNMyDateViewEventEmitter::OnDatePicked{
        .value = [_selectedDate UTF8String]
      });
    }
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  
  
  [super updateProps:props oldProps:oldProps];
}

@end

Class<RCTComponentViewProtocol> RTNMyDateViewCls(void)
{
  return RTNMyDateView.class;
}
