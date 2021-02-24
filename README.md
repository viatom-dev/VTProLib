#### 1. VTProLib - Viatom Checkme Pro iOS lib

* ##### 1.1 Changelog

    ##### [Changelog](https://github.com/viatom-dev/VTProLib/blob/master/changeLog.md)

* ##### 1.2 Functions

VTProLib is iOS lib Viatom Checkme Pro. There are two part in this lib: Communicate function and Data analysis function.

   1. Communicate function. Using this function, you can connect and download data from Checkme Pro, or get real-time data from "Remote Monitor" on Checkme Pro.
   2. Data analysis function. Get measurements values form the files downloaded.

#### 2. Environment

iOS 8.0 or later.

#### 3. Quick Start
1. Config the `peripheral` property of `VTProCommunicate`.If the callback method
that `serviceDeployed:` returns YES,  NECESSAYR!

2. Set `delegate` for `VTProCommunicate` any where you want get callback. At this step, you are able to communicate.

- use `beginPing`, get the mode of Checkme Pro (Normal mode or Monitor mode. see: [VTTypesDef.h](https://github.com/viatom-dev/VTProLib/blob/master/LibUseDemo/LibUseDemo/VTProLib.framework/Headers/VTTypesDef.h)

```objective-c
- (void)beginPing;
```

- get Checkme Pro info

```objective-c
- (void)beginGetInfo;
```

- sync time
```objective-c
- (void)beginSyncTime:(NSDate * _Nonnull)date;
```

- get measurements list
```objective-c
- (void)beginReadFileListWithUser:(VTProUser * _Nullable)user fileType:(VTProFileType)type;
```

- get measurements  details (include Daily check/ECG Recorder/Sleep monitor)
```objective-c
- (void)beginReadDetailFileWithObject:(VTProObject * _Nonnull)object fileType:(VTProFileType)type;
```
- monitor peripheral RSSI
```objective-c
- (void)readRSSI;
```

- Read HeartCheck List from PulsebitEX.
```objective-c
- (void)beginReadHistoryList;
```

- Read HeartCheck Detail data from PulsebitEX.
```objective-c
- (void)beginReadHistoryDetail:(NSString *)recordTime;
```

- measurements list object`<VTProLib/VTProObject.h>`
- measurements detail object`<VTProLib/VTProDetailObject.h>`
- data analysis for all`<VTProLib/VTProFileParser.h>`
- Mini-monitor data analysis`<VTProLib/VTProMiniObject.h>`


