//
//  UIImage+P34Utils.h
//  iGuides
//
//  Created by Глеб Тарасов on 22.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CUUtils)

/**
 *  Однопиксельная картинка определенного цвета.
 *
 *  @param color цвет пикселя
 *
 *  @return UIImage из одного пикселя
 */
+ (UIImage *)onePixelImageWithColor:(UIColor *)color;


/**
 *  Картинка указанного цвета с указанным размером
 *
 *  @param color цвет заливки
 *  @param size  размер
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;


/**
 *  Картинка резиновая по ширине (растягивается средний пиксель).
 */
- (UIImage *)stretchableImageByWidth;


/**
 *  Картинка резиновая по ширине и высоте (растягивается средние пиксели).
 */
- (UIImage *)stretchableImageByWidthAndHeight;


/**
 *  Картинка, в которой все непрозрачные пиксели заполнены указанным цветом.
 *
 *  @param source картинка для заполнения
 *  @param color  цвет заполнения
 */
+ (UIImage *)filledImageFrom:(UIImage *)source withColor:(UIColor *)color;


/**
 *  Картинка указанного размера
 *
 *  @param source исходное изображение
 *  @param size   размер
 */
+ (UIImage *)imageFrom:(UIImage *)source drawnInSize: (CGSize)size;

/**
 *  Делает из цветной картинки черно-белую картинку
 *
 *  @param i Изображение которое надо конвертировать в черно бело
 *
 *  @return Черно-белая картинка
 */
+ (UIImage *)convertToGreyscale:(UIImage *)i;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end

#pragma mark -

@interface UIImage (ImageWithColor)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize;

@end