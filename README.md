![platforms](https://img.shields.io/cocoapods/p/LXTouchGestureRecognizer.svg) [![pod version](https://img.shields.io/cocoapods/v/LXTouchGestureRecognizer.svg)](https://cocoapods.org/pods/LXTouchGestureRecognizer) ![license](https://img.shields.io/cocoapods/l/LXTouchGestureRecognizer.svg)

# LXTouchGestureRecognizer

Continuous `UIGestureRecognizer` allowing `UIControl`-like event listening.
See [http://lxcid.com/2015/01/01/highlight-with-gesture-recognizer](http://lxcid.com/2015/01/01/highlight-with-gesture-recognizer) for more details.

Complete [documentation](https://sumolari.github.io/LXTouchGestureRecognizer).

# Installation

```ruby
pod 'LXTouchGestureRecognizer', '~> 1.0.0'
```

# Usage

## Objective-C

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];

    LXTouchGestureRecognizer *touchGestureRecognizer = [[LXTouchGestureRecognizer alloc] init];
    [touchGestureRecognizer addTarget:self action:@selector(handleTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.customButtonView addGestureRecognizer:touchGestureRecognizer];
}

- (void)handleTouchUpInside:(LXTouchGestureRecognizer *)touchGestureRecognizer {
    NSLog(@"Touch Up Inside!");
}
```
