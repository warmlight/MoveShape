
#一个简单的视觉差效果
　　这两天看到一篇写的很不错的文章[视错觉的概述](http://www.cnblogs.com/ludashi/p/4994520.html)，他讲述了如何用一个简单的视觉差来做出一个看似酷炫的效果。对思维的启发还是很大的。我也模仿着做了一遍。如果有不足的地方，请大家指出一下~  
　　下载地址：[git](https://github.com/warmlight/MoveShape) 　　 
　　
　　
　　  
　　效果图：（感觉有点像mm豆。。。)  
　　　   
　　![效果图](http://ac-3xs828an.clouddn.com/1b306cbd37689b8a.gif)  
　　
这个效果是由多层view组合而成的，分解下来层次关系如下图：
　　![层次关系](http://ac-3xs828an.clouddn.com/2b213ee2dfecbeba.png)  
　　在[视错觉的概述](http://www.cnblogs.com/ludashi/p/4994520.html)这篇文章中，其实是要多一层的，即把第二层第三层按顺序`addSubView`到同一个view上。因为他有一个抖动的效果，如果不需要抖动的效果，我觉得可以简化掉一层view。  

* 最下面一层,是几个圆形依次添加到`self.view`上
* 第二层view要与最下面一层的某一个圆形保持大小和位置的一致性，然后将它也添加到`self.view`上。并且将自身的`clipsToBounds`设置为YES,他的意思是如果它的`subView`超过它的大小的部分不允许显示。这也是关键的地方--只显示第二层这个圆形的frame部分的subView。
* 第三层上添加与最下面一层大小和位置相同的几个圆形，我在每个圆形上加上一个`label`来显示文字，然后将它添加到第二层上面，作为第二层的`subView`，它只会显示与二层**重叠**的地方。
* 通过动态的改变第三层与第二层的相对位置就能实现这个效果啦~  

**ps**:最后有一层button我并没有在图中画出来，无非就是点击按钮来改变二、三层的相对位置。

####关于相对位置
　　在一开始，相对位置是这样的。第三层的frame是`(0, 0, self.frame.size.width, self.frame.size.height)];`
![层次关系](http://ac-3xs828an.clouddn.com/2b213ee2dfecbeba.png)  
　　点击第二个按钮后，我们要改变两者的位置关系如下，第三层这时的frame就是`(- self.viewWidth, 0, self.viewHeight, self.viewHeight);
`，可见`orgin.x`改变了，是一个负值，通过这种改变，可以造成一种第二层view在第三层保持不动的情况下左右移动的错觉。

![位置关系](http://ac-3xs828an.clouddn.com/dd84f44291cb386d.png)
  
		
		//第二层 第三层
		- (void)hierarchyView {
    CGRect firstFrame                  = [self createCircleFrame:0];
    self.secondView                    = [[UIView alloc] initWithFrame:firstFrame];
    self.secondView.layer.cornerRadius = self.viewHeight / 2;
    self.secondView.backgroundColor    = [UIColor lightGrayColor];
    self.secondView.clipsToBounds      = YES;        //subView超过它的范围的部分不显示
    [self addSubview:self.secondView];
    
    //这是初始化后，二、三层的相对位置，后面要进行改变
    self.thirdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    for (int i= 0; i < count; i ++) {
        CGRect frame               = CGRectMake(i * self.viewHeight + i * (self.viewWidth - self.viewHeight), 0, self.viewHeight, self.viewHeight);
        UIColor *color             = self.colorArray[i];
        UIView *view               = [[UIView alloc] initWithFrame:frame];
        view.layer.cornerRadius    = self.viewHeight / 2;
        view.layer.backgroundColor = color.CGColor;
        
        UILabel *textLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.viewHeight, self.viewHeight)];
        textLabel.backgroundColor  = [UIColor clearColor];
        textLabel.text             = @"mm";
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor whiteColor];
        [view addSubview:textLabel];
        
        [self.thirdView addSubview:view];
    }
    [self.secondView addSubview:self.thirdView];
    }	
    
    
    - (void)tapButton:(UIButton *) sender {

    CGRect frame       = [self createCircleFrame:sender.tag];
    CGRect changeFrame = CGRectMake(-sender.tag * self.viewHeight + -sender.tag * (self.viewWidth - self.viewHeight), 0, self.viewHeight, self.viewHeight);
    
    [UIView animateWithDuration:2 animations:^{
    	//改变二、三层的相对位置
        self.secondView.frame = frame;
        self.thirdView.frame  = changeFrame;
    } completion:^(BOOL finished) {

    }];
	}