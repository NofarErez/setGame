// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN
@interface SetCardView()

@property (nonatomic) Color color;
@property (nonatomic) Fill fill;
@property (nonatomic) Shape shape;
@property (nonatomic) NSUInteger rank;

@end

@implementation SetCardView

#pragma mark - Properties

@synthesize rank = _rank;

- (void)setChosen:(BOOL)chosen {
    _chosen = self.card.chosen;
    [self setNeedsDisplay];
}

- (void)setCard: (SetCard *)card {
    _card = card;
    _shape = card.shape;
    _fill = card.fill;
    _color = card.color;
    _rank = card.rank;
    [self setNeedsDisplay];
}

- (void)setShape:(Shape)shape {
    _shape = shape;
    [self setNeedsDisplay];
}

- (void)setColor:(Color)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void)setFill:(Fill)fill {
    _fill = fill;
    [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank {
    _rank = rank;
    [self setNeedsDisplay];
}

- (NSUInteger)rank {
    return _rank + 1;
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

#define SQUIGGLE_WIDTH 0.12
#define SQUIGGLE_HEIGHT 0.3
#define SHAPE_FACTOR 0.8

static const float kWidthPipFrameRatio = 0.7;
static const float kHeightPipFrameRatio = 0.24;
static const float kHeightPipDistanceRatio = 0.04;
static const float k2PipsHeightStartsRatio = 0.22;
static const float k3PipsHeightStartsRatio = 0.08;

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    UIColor *strokeColor = self.chosen ? [UIColor blueColor] : [UIColor blackColor];
    
    roundedRect.lineWidth = self.chosen ? 5 : 1;
    [strokeColor setStroke];
    [roundedRect stroke];
    
    [self drawOnCard];
}

- (void)drawOnCard {
    for (int i = 0; i < [self rank]; i++) {
        CGRect rect = [self rectForShape:i];
        [self drawShapeInRect:rect];
    }
}

- (UIColor *)getColor {
    switch ([self color]) {
        case Red:
            return UIColor.redColor;
        case Purple:
            return UIColor.purpleColor;
        case Green:
            return UIColor.greenColor;
        default:
            return UIColor.blackColor;
    }
}

- (void)drawOval:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.height/2];
    
    [[self getColor] setStroke];
    [path stroke];
    
    [self fillPath:path inRect:rect];
}

- (void)drawDiamond:(CGRect)rect {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(rect.origin.x,
                                  rect.origin.y + rect.size.height/2)];
    [path addLineToPoint:CGPointMake(rect.origin.x + rect.size.width/2,
                                     rect.origin.y + rect.size.height)];
    [path addLineToPoint:CGPointMake(rect.origin.x + rect.size.width,
                                     rect.origin.y + rect.size.height/2)];
    [path addLineToPoint:CGPointMake(rect.origin.x + rect.size.width/2,
                                     rect.origin.y)];
    [path closePath];
    
    [[self getColor] setStroke];
    [path stroke];
    
    [self fillPath:path inRect:rect];
}

- (void) drawSquiggle:(CGRect)rect {
    CGPoint point = CGPointMake(rect.origin.x + rect.size.width/2, rect.origin.y + rect.size.height/2);
    CGFloat dx = self.bounds.size.width * SQUIGGLE_WIDTH / 2.0;
    CGFloat dy = self.bounds.size.height * SQUIGGLE_HEIGHT / 2.0;
    CGFloat dsqx = dx * SHAPE_FACTOR;
    CGFloat dsqy = dy * SHAPE_FACTOR;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(point.x - dx, point.y - dy)];
    [path addQuadCurveToPoint:CGPointMake(point.x + dx, point.y - dy)
                 controlPoint:CGPointMake(point.x - dsqx, point.y - dy - dsqy)];
    [path addCurveToPoint:CGPointMake(point.x + dx, point.y + dy)
            controlPoint1:CGPointMake(point.x + dx + dsqx, point.y - dy + dsqy)
            controlPoint2:CGPointMake(point.x + dx - dsqx, point.y + dy - dsqy)];
    [path addQuadCurveToPoint:CGPointMake(point.x - dx, point.y + dy)
                 controlPoint:CGPointMake(point.x + dsqx, point.y + dy + dsqy)];
    [path addCurveToPoint:CGPointMake(point.x - dx, point.y - dy)
            controlPoint1:CGPointMake(point.x - dx - dsqx, point.y + dy - dsqy)
            controlPoint2:CGPointMake(point.x - dx + dsqx, point.y - dy + dsqy)];
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, point.x, point.y);
    transform = CGAffineTransformRotate(transform, M_PI/2);
    transform = CGAffineTransformTranslate(transform, -point.x, -point.y);
    
    [path applyTransform:transform];
    
    
    [[self getColor] setStroke];
    [path stroke];
    
    [self fillPath:path inRect:rect];
}

- (CGRect)rectForShape:(NSUInteger)pos {
    CGFloat x,y;
    
    x = self.bounds.size.width * ((1 - kWidthPipFrameRatio) / 2);
    
    switch ([self rank]) {
        case 1:
            y = self.bounds.size.height * ((1 - kHeightPipFrameRatio) / 2);
            break;
        case 2:
            y = self.bounds.size.height * ((k2PipsHeightStartsRatio + (kHeightPipDistanceRatio + kHeightPipFrameRatio) * (pos / ([self rank] - 1))));
            break;
        case 3:
            y = self.bounds.size.height * ((k3PipsHeightStartsRatio + (kHeightPipDistanceRatio + kHeightPipFrameRatio) * pos));
            break;
        default:
            return self.bounds;
    }
    
    return CGRectMake(x, y, self.bounds.size.width * kWidthPipFrameRatio, self.bounds.size.height * kHeightPipFrameRatio);
}


- (void)drawShapeInRect:(CGRect)rect {
    switch ([self shape]) {
        case Diamond:
            [self drawDiamond:rect];
            break;
        case Oval:
            [self drawOval:rect];
            break;
        case Squiggle:
            [self drawSquiggle:rect];
            break;
        default:
            break;
    }
}

- (void)fillPath:(UIBezierPath *)path inRect:(CGRect)rect {
    switch ([self fill]) {
        case Solid:
            [[self getColor] setFill];
            [path fill];
            break;
        case Striped:
            [self fillPathWithStripes:path inRect:rect];
            break;
        case Unfilled:
            [[UIColor clearColor] setFill];
            [path fill];
            break;
        default:
            break;
    }
    
}

- (void)fillPathWithStripes:(UIBezierPath *)path inRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [path addClip];
    
    UIBezierPath *pathStripes = [[UIBezierPath alloc] init];
    for (int i = 0; i < 5 ;i++) {
        [pathStripes moveToPoint:CGPointMake(rect.origin.x + i*rect.size.width/5,
                                             rect.origin.y)];
        [pathStripes addLineToPoint:CGPointMake(rect.origin.x + (i+1)*rect.size.width/5,
                                                rect.origin.y + rect.size.height)];
        
    }
    
    pathStripes.lineWidth = self.bounds.size.width * kWidthPipFrameRatio / 10;
    [[self getColor] setStroke];
    [pathStripes stroke];
    
    CGContextRestoreGState(context);
}

- (void)pushContextAndRotateUpsideDown
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}

- (void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

#pragma mark - Initialization

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}


@end

NS_ASSUME_NONNULL_END
