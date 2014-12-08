
// 当前窗口
#define SCKeyWindow ([UIApplication sharedApplication].keyWindow)

// 屏幕尺寸
#define SCScreenBounds [UIScreen mainScreen].bounds

// 屏幕高度
#define SCScreenHeight [UIScreen mainScreen].bounds.size.height

// 屏幕宽度
#define SCScreenWidth [UIScreen mainScreen].bounds.size.width

// 是否为4英寸
#define inch4 ([UIScreen mainScreen].bounds.size.height == 568)

// 是否为IOS8以上的系统
#define IOS8 ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)

// 创建随机数
#define SCNumber(n) arc4random_uniform(n)

// 创建rgb颜色
#define SCColor(r,g,b) ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1])

// 创建随机颜色
#define SCRandomColor [UIColor colorWithRed: arc4random_uniform(255) / 255.0f green:arc4random_uniform(255) / 255.0f blue:arc4random_uniform(255) / 255.0f alpha:1.0]

// 转角度为弧度
#define angle2Radian(angle) ((angle) / 180.0 * M_PI)

// 快速创建image
//#define SCImage(name) ([UIImage imageNamed:name])
