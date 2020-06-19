//
//  BTUtils.h
//  Checkme Mobile
//
//  Created by Joe on 14/9/20.
//  Copyright (c) 2014年 VIATOM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "UARTPeripheral.h"

#define BLE_OFF @"BLEOFF"
#define BLE_ON  @"BLEON"
#define FINDPERIPHRAL @"findp"
#define KEYPERIPHRAL @"key_p"
#define CONNECTED @"connected"


@interface BTUtils : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate, UARTPeripheralDelegate>

@property (nonatomic,strong) UARTPeripheral *currentPeripheral;
@property (nonatomic,strong) CBCentralManager *centralManager;
//驱动相关
+(BTUtils *)GetInstance;
-(void)openBT;
-(void)beginScan;
-(void)connectToPeripheral:(CBPeripheral *)peripheral;
-(void)stopScan;

@end




























