#import <Foundation/Foundation.h>
#import "esp.h"
#import <UIKit/UIKit.h>

@implementation esp : UIView
@synthesize players;
@synthesize onoroff;
- (id)initWithFrame:(UIWindow*)main
{
    self = [super initWithFrame:main.frame];
    self.userInteractionEnabled = false;
    self.hidden = false;
    self.backgroundColor = [UIColor clearColor];
    if(!players){
        players = new std::vector<player_t *>();
    }
    [main addSubview:self];
    [self callupdate];
    return self;
}
- (void)callupdate {
        [NSTimer scheduledTimerWithTimeInterval:0.01
                                                          target:self
                                                        selector:@selector(update)
                                                        userInfo:nil
                                                         repeats:YES];
}
- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextClearRect(contextRef,self.bounds);
    CGContextSetLineWidth(contextRef, 2.0);
    CGColor *colour;
    UIColor *Ucolour;
    for(int i = 0; i < players->size(); i++) {
        if((*players)[i]->enemy){
            colour = [UIColor redColor].CGColor;
            Ucolour = [UIColor redColor];
        }else{
            colour = [UIColor blueColor].CGColor;
            Ucolour = [UIColor blueColor];
        }
        CGContextSetStrokeColorWithColor(contextRef, colour);
        CGFloat floatx = (*players)[i]->rect.origin.x + (*players)[i]->rect.size.width/2;
        CGFloat floaty = (*players)[i]->rect.origin.y;
        CGContextMoveToPoint(contextRef,self.frame.size.width/2, 0.0f);
        CGContextAddLineToPoint(contextRef,floatx, floaty);
        CGContextStrokePath(contextRef);
        CGContextStrokeRect(contextRef, (*players)[i]->rect);
        CGFloat floattx = (*players)[i]->rect.origin.x-(*players)[i]->rect.size.width/4;
        CGFloat floatty = (*players)[i]->rect.origin.y;
        [[UIColor redColor] setFill];
        CGRect healthbar = CGRectMake(floattx, floatty, (*players)[i]->rect.size.width/6, (*players)[i]->rect.size.height);
        CGContextFillRect(contextRef, healthbar);
        [[UIColor greenColor] setFill];
        float cc = (*players)[i]->health/100;
        healthbar = CGRectMake(floattx, floatty, (*players)[i]->rect.size.width/6, (*players)[i]->rect.size.height*cc);
        CGContextFillRect(contextRef, healthbar);
        NSString *text = [NSString stringWithFormat:@"%.0f", (*players)[i]->distance];
        float xd = 30 / ((*players)[i]->distance/10);
        if(xd>25){
            xd = 25.0f;
        }
        xd = (*players)[i]->rect.size.width/2;
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:xd], NSForegroundColorAttributeName:Ucolour};
        [text drawAtPoint:CGPointMake(((*players)[i]->rect.origin.x), (floaty + (*players)[i]->rect.size.height)) withAttributes:attributes];
    }
     
    
}
- (void)update {
    if(onoroff){
        [self setNeedsDisplay];
    }
}


@end
