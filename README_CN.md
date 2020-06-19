[TOC]

#### 1. VTProLib
* ##### 1.1 版本变更日志
    [变更日志](https://www.jianshu.com/p/4898c2e9a36d)
* ##### 1.2 功能描述
   VTProLib是为源动健康Checkme开发的iOS版本的SDK。主要功能大致分为通信和解析两部分。
   &nbsp;&nbsp; 1. 通信功能。 用于使用Bluetooth的iOS设备与作为外设的checkme pro进行通信，可以从中获取各类存储数据以及minimonitor模式下的实时数据
   &nbsp;&nbsp; 2. 解析功能。 用于解析通信获取后的各类数据，并返回相应的模型供其他开发者使用。

#### 2. 环境
   &nbsp;&nbsp;&nbsp; iOS 8.0及以上

#### 3. 快速使用
首先，配置VTProCommunicate的属性peripheral&txCharacteristic，即可以正常通信。
然后，在需要接收返回的地方设置VTProCommunicate的delegate，即可以正常接收各类请求回调。
之后，可与checkme pro（以下简称pro）交互。

- 使用beginPing，通过回调判断pro当前使用的模式。
```
- (void)beginPing;
```

- 读取pro相关的信息
```
- (void)beginGetInfo;
```

- 同步指定时间到pro，调整pro上的时间显示
```
- (void)beginSyncTime:(NSDate * _Nonnull)date;
```

- 读取pro上各种数据的列表
```
- (void)beginReadFileListWithUser:(VTProUser * _Nullable)user fileType:(VTProFileType)type;
```

- 读取pro上部分数据的详情文件（包括Daily check/ECG Recorder/Sleep monitor）
```
- (void)beginReadDetailFileWithObject:(VTProObject * _Nonnull)object fileType:(VTProFileType)type;
```

- 写入数据到pro，一般用于升级语言包和软件包
```
- (void)beginWriteFileWithFileName:(NSString * _Nonnull)fileName fileType:(VTProFileType)type andFileData:(NSData * _Nonnull)fileData;
```

- 所有返回列表数据参考类`<VTProLib/VTProObject.h>`

- 所有返回详情数据参考类`<VTProLib/VTProDetailObject.h>`

- 所有数据的解析方式参考类`<VTProLib/VTProFileParser.h>`

- Monimonitor模式数据参考类`<VTProLib/VTProMiniObject.h>`
