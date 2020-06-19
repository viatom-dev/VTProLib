//
//  BTUtils.m
//  Checkme Mobile
//
//  Created by Joe on 14/9/20.
//  Copyright (c) 2014年 VIATOM. All rights reserved.
//

#import "BTUtils.h"

@interface BTUtils()

@end

@implementation BTUtils

+(BTUtils *)GetInstance
{
    static BTUtils *inst = nil;
    if(!inst){
        inst = [[BTUtils alloc] init];
    }
    return inst;
}

-(id)init
{
    self = [super init];
    if(self){

    }
    return self;
}


#pragma mark - scan 
// check BLE on/off
-(void)openBT
{
    _centralManager  = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

//scan periphral
-(void)beginScan
{
    // scan all
    [self.centralManager scanForPeripheralsWithServices:nil /*@[UARTPeripheral.devServiceUUID]*/ options:@{CBCentralManagerScanOptionAllowDuplicatesKey: [NSNumber numberWithBool:NO]}];
}
// stop scan
-(void)stopScan
{
    [self.centralManager stopScan];
}

// connect peripheral that selected
-(void)connectToPeripheral:(CBPeripheral *)peripheral
{
    [self stopScan];
    _currentPeripheral = [[UARTPeripheral alloc] initWithPeripheral:peripheral delegate:self];
    [VTProCommunicate sharedInstance].peripheral = peripheral;
    [self.centralManager connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnDisconnectionKey: [NSNumber numberWithBool:YES]}];
}
// ************************************************************





#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state != CBCentralManagerStatePoweredOn) {
        // In a real app, you'd deal with all the states correctly
        
        [[NSNotificationCenter defaultCenter] postNotificationName:BLE_OFF object:self userInfo:nil];
        return;
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:BLE_ON object:self userInfo:nil];
    // ... so start scanning
}


- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"FindPeripheral:%@<===========>RSSI:%@",peripheral.name,RSSI);
    if(!_currentPeripheral && peripheral.name/* && [peripheral.name hasPrefix:DeviceMode_Prefix]*/)
    {
        NSMutableDictionary *mutDic = [NSMutableDictionary new];
        [mutDic setValue:peripheral forKey:KEYPERIPHRAL];
        [mutDic setValue:advertisementData[@"kCBAdvDataLocalName"] forKey:@"BLEName"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:FINDPERIPHRAL object:self userInfo:mutDic];
        
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    if ([self.currentPeripheral.peripheral isEqual:peripheral])
    {
        [self.currentPeripheral didConnect];
    }
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"Failed to connect to %@. (%@)", peripheral, [error localizedDescription]);
}


- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    if ([self.currentPeripheral.peripheral isEqual:peripheral])
    {
        [self.currentPeripheral didDisconnect];
        [[NSNotificationCenter defaultCenter] postNotificationName:CONNECTED object:@0 userInfo:nil];
        if (error) {
            
            NSLog(@"didDisconnect error is = %@", error);
            NSLog(@"DidDisconnect!  Trying to reconnect");
            [self connectToPeripheral:peripheral];
        }
    }
}

#pragma mark - UARTPeripheral delegate
// call back connected
-(void)didConnectSuccess
{

    [[NSNotificationCenter defaultCenter] postNotificationName:CONNECTED object:@1 userInfo:nil];
}



@end

