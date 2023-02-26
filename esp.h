#import <vector>
#import <UIKit/UIKit.h>
struct player_t {
    CGRect rect;
    float health;
    float distance;
    bool enemy;
};
@interface esp : UIView
@property std::vector<player_t *> *players;
@property bool onoroff;
- (void)callupdate;
- (void)drawRect:(CGRect)rect;
- (void)update;
- (id)initWithFrame:(UIWindow*)main;
@end

