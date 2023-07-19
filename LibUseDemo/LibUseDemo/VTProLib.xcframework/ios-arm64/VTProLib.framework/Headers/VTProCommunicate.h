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
#import "VTProUser.h"
#import "VTProMiniObject.h"
#import "VTProObject.h"

@class VTProFileToRead;

NS_ASSUME_NONNULL_BEGIN

@protocol VTProCurrentModeDelegate <NSObject>

@optional
/// @brief state of peripheral
/// @param state view enum "VTProState"
- (void)currentStateOfPeripheral:(VTProState)state;

@end


@protocol VTProCommunicateDelegate <NSObject>

@optional

/// @brief Common command send to peripheral,   callback
/// @param cmdType command for /VTProCmdTypeSyncTime/  VTProCmdTypePing/VTProCmdTypeStartWrite/VTProCmdTypeWriting/VTProCmdTypeEndWrite/
/// @param result view the enum VTProCommonResult
- (void)commonResponse:(VTProCmd)cmdType andResult:(VTProCommonResult)result;

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


/// @brief Pod real
/// @param realData parsed by func -  'parsePodRealDataWithResponse'
- (void)pod_realDataWithData:(NSData *)realData;


/// @brief read current peripheral's rssi
/// @param RSSI rssi
- (void)updatePeripheralRSSI:(NSNumber *)RSSI;

/// @brief CBService & CBCharacteristic Deploy result . If  completed == YES, you can use request command.
/// @param completed result
- (void)serviceDeployed:(BOOL)completed;


@end



@interface VTProCommunicate : NSObject

/// @brief This peripheral is currently connected. Need to be set after connection
@property (nonatomic, strong) CBPeripheral *peripheral;

@property (nonatomic, assign) VTProState state;

/// @brief current file been read or written
@property (nonatomic, strong) VTProFileToRead *curReadFile;

@property (nonatomic, assign) id<VTProCommunicateDelegate> _Nullable delegate;

@property (nonatomic, assign) id<VTProCurrentModeDelegate> _Nullable modeDelegate;

@property (nonatomic, assign, readonly) int deviceType;

/// Before obtaining the file, it is necessary to obtain the device information first, otherwise errors may occur.
@property (nonatomic, copy, readonly) NSString *fileVer;

+ (VTProCommunicate *)sharedInstance;


#pragma mark -- monitor peripheral RSSI
- (void)readRSSI;

#pragma mark -- be used confirm current mode of peripheral
/// @brief Start ping with peripheral.  callback  "currentStateOfPeripheral:"
- (void)beginPing;

#pragma mark -- request data from peripheral

/// @brief Get information of peripheral. callback "getInfoWithResultData:"
- (void)beginGetInfo;

/// @brief Synchronize the specified time to the peripheral.  callback "commonResponse: andResult:"
/// @param date specified time,  Usually choose [NSDate date].
- (void)beginSyncTime:(NSDate * _Nonnull)date;
 
/// @brief Read each type of list data (without data details).  callback "readCompleteWithData:" & "postCurrentReadProgress:"
/// @param user nullable. Only part of the list supports users.  If no users, pass in nil .
/// @param type view list type of  "VTProFileType"
- (void)beginReadFileListWithUser:(VTProUser * _Nullable)user fileType:(VTProFileType)type;

/// @brief Read detail type. callback "readCompleteWithData:" & "postCurrentReadProgress:"
/// @param object with list model VTProObject.
/// @param type view detail type of  "VTProFileType"
- (void)beginReadDetailFileWithObject:(VTProObject * _Nonnull)object fileType:(VTProFileType)type;

/// @brief Write file to peripheral. Normal is used update.
/// @param fileName fileName
/// @param type file type
/// @param fileData file Data
- (void)beginWriteFileWithFileName:(NSString * _Nonnull)fileName fileType:(VTProFileType)type andFileData:(NSData * _Nonnull)fileData;


@end


/// @brief this is a class to describe the completeed current loading or writing file
@interface VTProFileToRead : NSObject

@property (nonatomic, copy) NSString *fileName;

@property (nonatomic, assign) VTProFileType fileType;

@property (nonatomic, assign) u_int fileSize;

@property (nonatomic, assign) u_int totalPkgNum;

@property (nonatomic, assign) u_int curPkgNum;

@property (nonatomic, assign) u_int lastPkgSize;

/// @brief download completed response data .
@property (nonatomic, strong) NSMutableData *fileData;

/// @brief read file result
@property (nonatomic, assign) VTProFileLoadResult enLoadResult;

- (instancetype)initWithFileType:(VTProFileType)fileType;


@end


@interface VTProCommunicate (PulsebitEX)

/// @brief Read HeartCheck List from PulsebitEX.  callback "readCompleteWithData:" & "postCurrentReadProgress:"
- (void)beginReadHistoryList;

/// @brief Read HeartCheck Detail data from PulsebitEX. callback "readCompleteWithData:" & "postCurrentReadProgress:"
/// @param recordTime recordTime of HeartCheck List
- (void)beginReadHistoryDetail:(NSString *)recordTime;

@end


@interface VTProCommunicate (CheckmePod)

- (void)beginReadHistory;

- (void)beginReadRealData;

@end


NS_ASSUME_NONNULL_END
