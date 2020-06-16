//
//  VTProCommunicate.h
//  LibUseDemo
//
//  Created by viatom on 2020/6/15.
//  Copyright © 2020 Viatom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "VTTypesDef.h"
#import "VTProMiniObject.h"

@class VTProFileToRead;

NS_ASSUME_NONNULL_BEGIN


@protocol VTProCommunicateDelegate <NSObject>

@optional

/// @brief Common command send to peripheral,   callback
/// @param cmdType command for //  VTProCmdTypePing/VTProCmdTypeEndRead/VTProCmdTypeStartWrite/VTProCmdTypeWriting/VTProCmdTypeEndWrite/VTProCmdTypeSyncTime/
/// @param result view the enum VTProCommonResult
- (void)commonResponse:(VTProCmdType)cmdType andResult:(VTProCommonResult)result;

/// @brief Send the current progress of reading
/// @param progress progress value
- (void)postCurrentReadProgress:(double)progress;

/// @brief Read file complete
/// @param fileData view model --- VTProFileToRead
- (void)readCompleteWithData:(VTProFileToRead *)fileData;

/// @brief Send the current progress of writing
/// @param progress the data been written currently
- (void)postCurrentWriteProgress:(double)progress;

/// @brief Write file successfully
/// @param fileData the data been written complete
- (void)writeSuccessWithData:(VTProFileToRead *)fileData;

/// @brief Write file failed
/// @param fileData An error occurred during data writing
- (void)writeFailedWithData:(VTProFileToRead *)fileData;

/// @brief get information complete . if infoData == nil , an error occurred
/// @param infoData information data nullable
- (void)getInfoWithResultData:(NSData * _Nullable)infoData;


/// @brief Minimonitor real time call back.
/// @param object view VTProMiniObject
- (void)realTimeCallBackWithObject:(VTProMiniObject *)object;


@end



@interface VTProCommunicate : NSObject

/// @brief This peripheral is currently connected. Need to be set after connection
@property (nonatomic, strong) CBPeripheral *peripheral;

/// @brief This characteristic is a writable characteristic of the currently connected peripheral. Need to be set after connection
@property (nonatomic, strong) CBCharacteristic *txCharacteristic;

/// @brief current file been read or written
@property (nonatomic, strong) VTProFileToRead *curReadFile;

@property (nonatomic, assign) id<VTProCommunicateDelegate>delegate;

+ (VTProCommunicate *)sharedInstance;

#pragma mark -- receive
/// @brief receive data from periphral
/// @param data data from CBPeripheralDelegate -- didUpdateValueForCharacteristic 
- (void)didReceiveData:(NSData *)data;

#pragma mark -- request
- (void)beginPing;

- (void)beginGetInfo;

- (void)beginSyncTime:(NSDate * _Nonnull)date;

- (void)beginReadFileWithFileName:(NSString * _Nonnull)fileName fileType:(VTProFileType)type;

- (void)beginWriteFileWithFileName:(NSString * _Nonnull)fileName fileType:(VTProFileType)type andFileData:(NSData * _Nonnull)fileData;


@end


/// @brief this is a class to describe the completeed current loading or writing file
@interface VTProFileToRead : NSObject

@property (nonatomic, assign) NSString *fileName;

@property (nonatomic, assign) VTProFileType fileType;

@property (nonatomic, assign) u_int fileSize;

@property (nonatomic, assign) u_int totalPkgNum;

@property (nonatomic, assign) u_int curPkgNum;

@property (nonatomic, assign) u_int lastPkgSize;

@property (nonatomic, strong) NSMutableData *fileData;

@property (nonatomic, assign) VTProFileLoadResult enLoadResult;

- (instancetype)initWithFileType:(VTProFileType)fileType;


@end

NS_ASSUME_NONNULL_END
