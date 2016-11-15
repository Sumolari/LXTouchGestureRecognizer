[![CocoaPods](https://img.shields.io/cocoapods/v/LXTouchGestureRecognizer.svg)]()

# LXTouchGestureRecognizer

Continuous `UIGestureRecognizer` allowing `UIControl`-like event listening. 
See [http://lxcid.com/2015/01/01/highlight-with-gesture-recognizer](http://lxcid.com/2015/01/01/highlight-with-gesture-recognizer) for more details.

# Installation

```ruby
pod 'LXTouchGestureRecognizer', '~> 0.0.1'
```

# Usage

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

