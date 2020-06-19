//
//  UARTPeripheral.m
//  nRF UART
//
//  Created by Ole Morten on 1/12/13.
//  Copyright (c) 2013 Nordic Semiconductor. All rights reserved.
//

#import "UARTPeripheral.h"
#import "AppDelegate.h"

@interface UARTPeripheral ()
@property (nonatomic,strong) CBService *uartService;
@property (nonatomic,strong) CBCharacteristic *rxCharacteristic;


@property (nonatomic,strong) CBService *devService;
@property (nonatomic,strong) CBCharacteristic *devRxCharacteristic;
@property (nonatomic,strong) CBCharacteristic *devTxCharacteristic;

@end

@implementation UARTPeripheral
@synthesize peripheral = _peripheral;
@synthesize delegate = _delegate;

@synthesize uartService = _uartService;
@synthesize rxCharacteristic = _rxCharacteristic;
@synthesize txCharacteristic = _txCharacteristic;
@synthesize devService = _devService;
@synthesize devRxCharacteristic = _devRxCharacteristic;
@synthesize devTxCharacteristic = _devTxCharacteristic;

+ (CBUUID *) uartServiceUUID
{
  //return [CBUUID UUIDWithString:@"6e400001-b5a3-f393-e0a9-e50e24dcca9e"];
    return [CBUUID UUIDWithString:@"569a1101-b87f-490c-92cb-11ba5ea5167c"];
//    return [CBUUID UUIDWithString:@"0000fff0-0000-1000-8000-00805f9b34fb"];
}

+ (CBUUID *) devServiceUUID
{
    return [CBUUID UUIDWithString:@"14839ac4-7d7e-415c-9a42-167340cf2339"];
}

+ (CBUUID *) txCharacteristicUUID   //data going to the module
{
    //return [CBUUID UUIDWithString:@"6e400002-b5a3-f393-e0a9-e50e24dcca9e"];
    return [CBUUID UUIDWithString:@"569a2000-b87f-490c-92cb-11ba5ea5167c"];
//    return [CBUUID UUIDWithString:@"0000fff2-0000-1000-8000-00805f9b34fb"];
}

+ (CBUUID *) devTxCharacteristicUUID   //data going to the module
{
//    return [CBUUID UUIDWithString:@"BA04C4B2-892B-43BE-B69C-5D13F2195392"];
    return [CBUUID UUIDWithString:@"8B00ACE7-EB0B-49B0-BBE9-9AEE0A26E1A3"];
    
//    return [CBUUID UUIDWithString:@"0734594A-A8E7-4B1A-A6B1-CD5243059A57"];
}

+ (CBUUID *) rxCharacteristicUUID  //data coming from the module
{
    //return [CBUUID UUIDWithString:@"6e400003-b5a3-f393-e0a9-e50e24dcca9e"];
    return [CBUUID UUIDWithString:@"569a2001-b87f-490c-92cb-11ba5ea5167c"];
    
//    return [CBUUID UUIDWithString:@"0000fff1-0000-1000-8000-00805f9b34fb"];
}

+ (CBUUID *) devRxCharacteristicUUID  //data coming from the module
{
    return [CBUUID UUIDWithString:@"0734594A-A8E7-4B1A-A6B1-CD5243059A57"];
//    return [CBUUID UUIDWithString:@"8B00ACE7-EB0B-49B0-BBE9-9AEE0A26E1A3"];
}

+ (CBUUID *) deviceInformationServiceUUID
{
    return [CBUUID UUIDWithString:@"180A"];
}

+ (CBUUID *) hardwareRevisionStringUUID
{
    return [CBUUID UUIDWithString:@"2A27"];
}


- (UARTPeripheral *) initWithPeripheral:(CBPeripheral*)peripheral delegate:(id<UARTPeripheralDelegate>) delegate
{
    if (self = [super init])
    {
        self.peripheral = peripheral;
        _peripheral.delegate = self;
        self.delegate = delegate;
    }
    return self;
}

- (void) didConnect
{
    NSLog(@"peripheral transfer discoverServices method！！！");
    [_peripheral discoverServices:@[self.class.uartServiceUUID, self.class.deviceInformationServiceUUID, self.class.devServiceUUID]];
    NSLog(@" start discover service!!!");
}
- (void) didDisconnect
{
    
}
- (void) writeString:(NSString *) string
{
    NSString *string1 = [NSString stringWithString:string];
    
    string1 = [string1 stringByAppendingString:@"\r"];
    
    NSData *data = [NSData dataWithBytes:string1.UTF8String length:string1.length];
    
    [self.peripheral writeValue:data forCharacteristic:self.txCharacteristic type:CBCharacteristicWriteWithoutResponse];
}
- (void) writeRawData:(NSData *) data
{
    if (self.peripheral.state==CBPeripheralStateConnected) {
        
        NSLog(@"write Characteristic：%@", self.txCharacteristic);
        [self.peripheral writeValue:data forCharacteristic:self.txCharacteristic type:CBCharacteristicWriteWithoutResponse];
    }
}
//======================================================*****





#pragma CBPeripheral delegate


- (void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSLog(@"Found correct service，peripheral transfer discoverCharacteristics method！");
    if (error)
    {
        NSLog(@"Error discovering services: %@", error);
        return;
    }
    
    for (CBService *s in [peripheral services])
    {
        if ([s.UUID isEqual:self.class.uartServiceUUID])
        {
            self.uartService = s;
            
            [self.peripheral discoverCharacteristics:@[self.class.txCharacteristicUUID, self.class.rxCharacteristicUUID] forService:self.uartService];
        }
        else if ([s.UUID isEqual:self.class.deviceInformationServiceUUID])
        {
            [self.peripheral discoverCharacteristics:@[self.class.hardwareRevisionStringUUID] forService:s];
        }
        else if ([s.UUID isEqual:self.class.devServiceUUID])
        {
            self.devService = s;
            [self.peripheral discoverCharacteristics:@[self.class.devTxCharacteristicUUID, self.class.devRxCharacteristicUUID] forService:self.devService];
        }
    }
}
- (void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (error)
    {
        NSLog(@"Error discovering characteristics: %@", error);
        return;
    }
    
    if(!_rxCharacteristic || !_txCharacteristic)
    {
        for (CBCharacteristic *c in [service characteristics])
        {
            if ([c.UUID isEqual:self.class.rxCharacteristicUUID] || [c.UUID isEqual:self.class.devRxCharacteristicUUID])
            {
                NSLog(@"Found RX characteristic  :%@", c);
                self.rxCharacteristic = c;
                [VTProCommunicate sharedInstance].txCharacteristic = _txCharacteristic;

                [self.peripheral setNotifyValue:YES forCharacteristic:self.rxCharacteristic];
                
            }
            else if ([c.UUID isEqual:self.class.txCharacteristicUUID] || [c.UUID isEqual:self.class.devTxCharacteristicUUID])
            {
                NSLog(@"Found TX characteristic  :%@", c);
                self.txCharacteristic = c;
                [VTProCommunicate sharedInstance].txCharacteristic = _txCharacteristic;
//                [self.peripheral setNotifyValue:YES forCharacteristic:self.rxCharacteristic];
            }
        }
        if(_txCharacteristic && _rxCharacteristic)
            [_delegate didConnectSuccess];
    }
}
//************************************************************************************


- (void) peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    DLog(@"接收到数据：%@", characteristic.value);
    if (error)
    {
        NSLog(@"Error receiving notification for characteristic %@: %@", characteristic, error);
        return;
    }
    
    
    if (characteristic == self.rxCharacteristic)
    {

        [[VTProCommunicate sharedInstance] didReceiveData:characteristic.value];
        
    }
    else if ([characteristic.UUID isEqual:self.class.hardwareRevisionStringUUID])
    {
    }
}
@end
