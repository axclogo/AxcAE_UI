


#define AxcAE_Angle(angle)  (angle)/180.f * M_PI // 弧度转角度
#define AxcAE_Radians(radians) ((radians) * (180.0 / M_PI)) // 角度转弧度

#define AxcAE_ViewRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define AxcAE_ViewRGB(r,g,b) AxcAE_ViewRGBA(r,g,b,1.0f)

#define AxcAE_AcienceTechnologyBlue AxcAE_ViewRGB(59,185,222)
#define AxcAE_ViewItemBadgeRed  AxcAE_ViewRGB(255,38,0)





