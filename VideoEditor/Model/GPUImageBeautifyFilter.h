//
//  GPUImageBeautifyFilter.h
//  VideoEditor
//
//  Created by Ualikhan Sabden on 29.10.2023.
//


#if __has_include(<GPUImage/GPUImage.h>)
#import "GPUImage/GPUImage.h"

@class GPUImageCombinationFilter;

@interface GPUImageBeautifyFilter : GPUImageFilterGroup {
    GPUImageBilateralFilter *bilateralFilter;
    GPUImageCannyEdgeDetectionFilter *cannyEdgeFilter;
    GPUImageCombinationFilter *combinationFilter;
    GPUImageHSBFilter *hsbFilter;
}

//设置美化强度
- (id)initWithDegree:(float)degree;

@end

#endif

