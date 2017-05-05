// LXTouchGestureRecognizer.h
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

#import <UIKit/UIKit.h>

/**
 * Continuous UIGestureRecognizer allowing UIControl-like event listening.
 *
 * http://lxcid.com/2015/01/01/highlight-with-gesture-recognizer
 */
@interface LXTouchGestureRecognizer : UILongPressGestureRecognizer

/**
 * Initializes this instance with no target/action.
 */
- (instancetype)init;

/**
 * Initializes this instance with an additional target/action to be triggered
 * on gesture recognizer default events.
 *
 * @param target The target object—that is, the object whose action method is
 *               called. If you specify `nil`, UIKit searches the responder
 *               chain for an object that responds to the specified action
 *               message and delivers the message to that object.
 *
 * @param action A selector identifying the action method to be called. This
 *               parameter must not be `nil`.
 */
- (instancetype)initWithTarget:(id)target
                        action:(SEL)action NS_DESIGNATED_INITIALIZER;

/**
 * Associates a target object and action method with the control.
 *
 * # Discussion
 *
 * You may call this method multiple times to configure multiple targets and
 * actions for the control. It is also safe to call this method multiple times
 * with the same values for the target and action parameters. The control
 * maintains a list of its attached targets and actions along and the events
 * each supports.
 *
 * The control does not retain the object in the target parameter. It is your
 * responsibility to maintain a strong reference to the target object while it
 * is attached to a control.
 *
 * Specifying a value of `0` for the `controlEvents` parameter does not prevent
 * events from being sent to a previously registered target and action method.
 * To stop the delivery of events, always call the `removeTarget(_:action:for:)`
 * method.
 *
 * @param target The target object—that is, the object whose action method is
 *               called. If you specify `nil`, UIKit searches the responder
 *               chain for an object that responds to the specified action
 *               message and delivers the message to that object.
 *
 * @param action A selector identifying the action method to be called. This
 *               parameter must not be `nil`.
 *
 * @param controlEvents A bitmask specifying the control-specific events for
 *                      which the action method is called. Always specify at
 *                      least one constant. For a list of possible constants,
 *                      see `UIControlEvents`.
 */
- (void)addTarget:(id)target
           action:(SEL)action
 forControlEvents:(UIControlEvents)controlEvents;

/**
 * Stops the delivery of events to the specified target object.
 *
 * @param target A target object registered with the control.
 *
 * @param action A selector identifying a registered action method.
 *
 * @param controlEvents A bitmask specifying the control events that you want to
 *                      remove for the specified target object. For a list of
 *                      possible constants, see `UIControlEvents`.
 */
- (void)removeTarget:(id)target
              action:(SEL)action
    forControlEvents:(UIControlEvents)controlEvents;

@end
