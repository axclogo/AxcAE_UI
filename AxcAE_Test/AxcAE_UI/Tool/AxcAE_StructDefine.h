
#import "AxcAE_HeaderDefine.h"

/** 陀螺仪方向 */
struct AxcAE_Gyroscope {
    CGFloat x;
    CGFloat y;
    CGFloat z;
};
typedef struct CG_BOXABLE AxcAE_Gyroscope AxcAE_Gyroscope;

CG_INLINE AxcAE_Gyroscope
AxcAE_GyroscopeMake(CGFloat x, CGFloat y, CGFloat z){
    AxcAE_Gyroscope gyroscope;
    gyroscope.x = x; gyroscope.y = y; gyroscope.z = z;
    return gyroscope;
}

CG_INLINE AxcAE_Gyroscope
AxcAE_GyroscopeMotionMake(CMDeviceMotion *motion){
    AxcAE_Gyroscope gyroscope;
    gyroscope.z = motion.gravity.z;
    gyroscope.x = motion.gravity.x;
    gyroscope.y = motion.gravity.y;
    return gyroscope;
}
