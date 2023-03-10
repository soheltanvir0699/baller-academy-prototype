//
//  Copyright (c) 2017-2020 PSPDFKit GmbH. All rights reserved.
//
//  The PSPDFKit Sample applications are licensed with a modified BSD license.
//  Please see License for details. This notice may not be removed from
//  this file.
//

#if FRAMEWORK_BUILD
#import <PDFXKit/PDFXPlatform.h>
#import <PDFXKit/PDFXAction.h>
#else
#import "PDFXPlatform.h"
#import "PDFXAction.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface PDFXActionRemoteGoTo : PDFXAction <NSCopying>

- (instancetype)initWithPageIndex:(NSUInteger)pageIndex atPoint:(PDFXPoint)point fileURL:(NSURL *)url PDFX_NOT_IMPLEMENTED_PRIORITY_UNKNOWN;

@property (nonatomic) NSUInteger pageIndex PDFX_NOT_IMPLEMENTED_PRIORITY_UNKNOWN;
@property (nonatomic) PDFXPoint point PDFX_NOT_IMPLEMENTED_PRIORITY_UNKNOWN;
@property (nonatomic, copy) NSURL *URL PDFX_NOT_IMPLEMENTED_PRIORITY_UNKNOWN;

@end

NS_ASSUME_NONNULL_END
