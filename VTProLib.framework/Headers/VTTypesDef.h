//
//  VTTypesDef.h
//  BTHealth
//
//  Created by demo on 13-10-25.
//  Copyright (c) 2013年 LongVision's Mac02. All rights reserved.
//

#ifndef BTHealth_VTTypesDef_h
#define BTHealth_VTTypesDef_h

/// @brief Define output sentence, there is output in degug mode, no output in release mode
#ifdef  DEBUG
#define DLog( s, ... )   NSLog( @"<%@,(line=%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif


/// @brief Leading method during measurement
typedef enum : u_char {
    LeadKindHand = 0x01,
    LeadKindChest = 0x02,
    LeadKindWire = 0x03,
    LeadKindWire12 = 0x04,
} LeadKind_t;

typedef enum{
    kPassKind_Pass = 0 ,
    kPassKind_Fail,
    kPassKind_Others
}PassKind_t;

typedef enum{
    kFilterKind_Normal = 0 ,
    kFilterKind_Wide
}FilterKind_t;

typedef enum : u_char {
    VTProCmdStartWrite = 0x0,
    VTProCmdWriteContent = 0x01,
    VTProCmdEndWrite = 0x02,
    VTProCmdStartRead = 0x03,
    VTProCmdReadContent = 0x04,
    VTProCmdEndRead = 0x05,
    VTProCmdLangStartUpdate = 0x0A,
    VTProCmdLangUpdateData = 0x0B,
    VTProCmdLangEndUpdate = 0x0C,
    VTProCmdAppStartUpdate = 0x0D,
    VTProCmdAppUpdateData = 0x0E,
    VTProCmdAppEndUpdate = 0x0F,
    VTProCmdGetInfo = 0x14,
    VTProCmdPing = 0x15,
    VTProCmdSyncTime = 0x16,
} VTProCmd;


typedef enum : NSUInteger {
    VTProCmdTypeNone,
    VTProCmdTypeStartWrite,
    VTProCmdTypeWriting,
    VTProCmdTypeEndWrite,
    VTProCmdTypeStartRead,
    VTProCmdTypeReading,
    VTProCmdTypeEndRead,
    VTProCmdTypePing,
    VTProCmdTypeGetInfo,
    VTProCmdTypeSyncTime,
} VTProCmdType;

typedef enum : u_char {
    VTProAckStatusOK = 0x00,
    VTProAckStatusErr = 0x01,
} VTProAckStatus;

typedef enum : NSUInteger {
    VTProPkgLengthSend = 8,
    VTProPkgLengthReceive = 12,
    VTProPkgLengthContent = 512,
    VTProPkgLengthInfo = 8 + 256,
} VTProPkgLength;


typedef enum : u_char {
    VTProFileTypeNone = 0x00,
    /// @brief list
    VTProFileTypeUserList = 0x01,
    VTProFileTypeDlcList = 0x02,
    VTProFileTypeEcgList = 0x03,
    VTProFileTypeSpO2List = 0x05,
    VTProFileTypeBpList = 0x17,
    VTProFileTypeBgList = 0x18,
    VTProFileTypeTmList = 0x06,
    VTProFileTypeSlmList = 0x04,
    VTProFileTypePedList = 0x0B,
    /// @brief detail
    VTProFileTypeEcgDetail = 0x07,
    VTProFileTypeEcgVoice = 0x08,
    VTProFileTypeSlmDetail = 0x09,
    /// @brief update pkg
    VTProFileTypeLangPkg = 0x0C,
    VTProFileTypeAppPkg = 0x0D,
} VTProFileType;

typedef enum : NSUInteger {
    VTProFileLoadResultSuccess,
    VTProFileLoadResultTimeOut,
    VTProFileLoadResultFailed,
    VTProFileLoadResultNotExist,
} VTProFileLoadResult;

typedef enum : NSUInteger {
    VTProCommonResultSuccess,
    VTProCommonResultTimeOut,
    VTProCommonResultFailed,
} VTProCommonResult;

typedef enum : NSUInteger {
    VTProTimeOutMSPing = 500,
    VTProTimeOutMSGeneral = 5000,
    VTProTimeOutMSUpdate = 80000,
} VTProTimeOutMS;



#define Home_USER_LIST_FILE_NAME                @"usr.dat"
#define ECG_LIST_FILE_NAME                      @"ecg.dat"
#define SLM_LIST_FILE_NAME                      @"slm.dat"
#define DLC_LIST_FILE_NAME                      @"%ddlc.dat"  //
#define SPO2_FILE_NAME                          @"oxi.dat"
#define TEMP_FILE_NAME                          @"tmp.dat"
#define PED_FILE_NAME                           @"%dped.dat"   //
#define NIBP_FILE_NAME                          @"%dnibp.dat"
#define SUGER_FILE_NAME                         @"%dglu.dat"


#endif
