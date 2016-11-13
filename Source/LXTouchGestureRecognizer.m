// LXTouchGestureRecognizer.m
//
// Copyright (c) 2015 Stan Chang Khin Boon (http://lxcid.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "LXTouchGestureRecognizer.h"

@interface LXControlTargetAction : NSObject

@property(nonatomic, weak) id target;
@property(nonatomic, assign) SEL action;
@property(nonatomic, assign) UIControlEvents eventMask;

@end

@implementation LXControlTargetAction
@end

@interface LXTouchGestureRecognizer ()

@property(nonatomic, strong) NSMutableArray *targetActions;
@property(nonatomic, assign, getter=isTouchInside) BOOL touchInside;

@end

@implementation LXTouchGestureRecognizer

- (instancetype)initWithTarget:(id)target action:(SEL)action {
  self = [super initWithTarget:self action:@selector(handleTouchGesture:)];
  if (self) {
    self.minimumPressDuration = 0.001;
    self.allowableMovement = 5.0;
    if (target && action) {
      [self addTarget:target action:action];
    }
  }
  return self;
}

- (instancetype)init {
  self = [self initWithTarget:nil action:NULL];
  if (self) {
  }
  return self;
}

#pragma mark - UIControl

- (void)addTarget:(id)target
           action:(SEL)action
 forControlEvents:(UIControlEvents)controlEvents {
  LXControlTargetAction *targetAction = [[LXControlTargetAction alloc] init];
  targetAction.target = target;
  targetAction.action = action;
  targetAction.eventMask = controlEvents;

  if (!self.targetActions) {
    self.targetActions = [[NSMutableArray alloc] init];
  }
  [self.targetActions addObject:targetAction];
}

- (void)removeTarget:(id)target
              action:(SEL)action
    forControlEvents:(UIControlEvents)controlEvents {
  NSMutableArray *targetActionsToBeRemoved = nil;
  for (LXControlTargetAction *targetAction in self.targetActions) {
    if (target && targetAction.target != target) {
      continue;
    }
    if (action && targetAction.action != action) {
      continue;
    }
    UIControlEvents eventMask =
        targetAction.eventMask & ~(targetAction.eventMask & controlEvents);
    if (eventMask) {
      targetAction.eventMask = eventMask;
      continue;
    }
    if (!targetActionsToBeRemoved) {
      targetActionsToBeRemoved =
          [[NSMutableArray alloc] initWithObjects:targetAction, nil];
    } else {
      [targetActionsToBeRemoved addObject:targetAction];
    }
  }
  if (targetActionsToBeRemoved) {
    [self.targetActions removeObjectsInArray:targetActionsToBeRemoved];
  }
}

- (void)sendAction:(SEL)action
                to:(id)target
  forControlEvents:(UIControlEvents)controlEvents {
  NSMethodSignature *methodSignature =
      [target methodSignatureForSelector:action];
  if (!methodSignature) {
    return;
  }
  NSInvocation *invocation =
      [NSInvocation invocationWithMethodSignature:methodSignature];
  if (!invocation) {
    return;
  }
  invocation.target = target;
  invocation.selector = action;
  if (methodSignature.numberOfArguments >= 3) {
    LXTouchGestureRecognizer *thirdArgument = self;
    [invocation setArgument:&thirdArgument atIndex:2];
  }
  if (methodSignature.numberOfArguments >= 4) {
    [invocation setArgument:&controlEvents atIndex:3];
  }
  [invocation invoke];
}

- (void)sendActionsForControlEvents:(UIControlEvents)controlEvents {
  for (LXControlTargetAction *targetAction in self.targetActions) {
    if (targetAction.eventMask & controlEvents) {
      [self sendAction:targetAction.action
                        to:targetAction.target
          forControlEvents:controlEvents];
    }
  }
}

#pragma mark - Gesture Handlers

- (void)handleTouchGesture:(LXTouchGestureRecognizer *)touchGestureRecognizer {
  UIGestureRecognizerState state = touchGestureRecognizer.state;
  UIView *view = touchGestureRecognizer.view;
  CGPoint location = [touchGestureRecognizer locationInView:view];
  BOOL touchInside = CGRectContainsPoint(view.bounds, location);
  switch (state) {
  case UIGestureRecognizerStateBegan: {
    self.touchInside = touchInside;
    [self sendActionsForControlEvents:UIControlEventTouchDown];
  } break;
  case UIGestureRecognizerStateChanged: {
    if (touchInside != self.touchInside) {
      self.touchInside = touchInside;
      if (self.isTouchInside) {
        [self sendActionsForControlEvents:UIControlEventTouchDragEnter];
        [self sendActionsForControlEvents:UIControlEventTouchDragInside];
      } else {
        [self sendActionsForControlEvents:UIControlEventTouchDragExit];
        [self sendActionsForControlEvents:UIControlEventTouchDragOutside];
      }
    }
  } break;
  case UIGestureRecognizerStateEnded: {
    self.touchInside = touchInside;
    if (self.isTouchInside) {
      [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    } else {
      [self sendActionsForControlEvents:UIControlEventTouchUpOutside];
    }
    self.touchInside = NO;
  } break;
  case UIGestureRecognizerStateCancelled: {
    self.touchInside = touchInside;
    [self sendActionsForControlEvents:UIControlEventTouchCancel];
    self.touchInside = NO;
  } break;
  default: { } break; }
}

@end
