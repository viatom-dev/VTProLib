//
//  UARTPeripheral.h
//  nRF UART
//
//  Created by Ole Morten on 1/12/13.
//  Copyright (c) 2013 Nordic Semiconductor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <VTProLib/VTProCommunicate.h>


@protocol UARTPeripheralDelegate
//- (void) didReceiveData:(NSData *) data;
@optional
- (void) didReadHardwareRevisionString:(NSString *) string;
- (void)didConnectSuccess;
@end


@interface UARTPeripheral : NSObject <CBPeripheralDelegate>
@property (nonatomic,strong) CBPeripheral *peripheral;
@property (nonatomic,strong) CBCharacteristic *txCharacteristic;
@property (nonatomic,assign) id<UARTPeripheralDelegate> delegate;

+ (CBUUID *) uartServiceUUID;
+ (CBUUID *) devServiceUUID;

- (UARTPeripheral *) initWithPeripheral:(CBPeripheral*)peripheral delegate:(id<UARTPeripheralDelegate>) delegate;

- (void) writeString:(NSString *) string;
- (void) writeRawData:(NSData *) data;
- (void) didConnect;
- (void) didDisconnect;
@end
