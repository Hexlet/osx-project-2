//
//  DiskActivityIO.m
//  osx-project-2
//
//  Created by macuser1 on 11/23/12.
//  Copyright (c) 2012 Pavel Popchikovsky. All rights reserved.
//
//
// IO stats code was copied from XRG project
// https://github.com/mikepj/XRG

#import "DiskActivityIO.h"

@implementation DiskActivityIO
{
    io_iterator_t   drivelist;
    mach_port_t     masterPort;
    
    UInt64 prevValue;
}

- (id) init
{
    self = [super init];
    if(self)
    {
        /* get ports and services for drive stats */
        /* Obtain the I/O Kit communication handle */
        IOMasterPort(bootstrap_port, &masterPort);
        
        /* Obtain the list of all drive objects */
        IOServiceGetMatchingServices(masterPort,
                                     IOServiceMatching("IOBlockStorageDriver"),
                                     &drivelist);
        
        prevValue = getDISKcounters(drivelist);
    }
    return self;
}

- (void)dealloc
{
    /* need to release allocated IO object */
    IOObjectRelease(drivelist);
}

- (NSNumber *)getValue
{
    UInt64 value = getDISKcounters(drivelist);
    UInt64 difference = value - prevValue;
    
    prevValue = value;
    
    return [NSNumber numberWithFloat:difference];
}

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// code from XRG (https://github.com/mikepj/XRG)

/*!
 * @defined kIOBlockStorageDriverStatisticsKey
 * @abstract
 * Holds a table of numeric values describing the driver's
 * operating statistics.
 * @discussion
 * This property holds a table of numeric values describing the driver's
 * operating statistics.  The table is an OSDictionary, where each entry
 * describes one given statistic.
 */

#define kIOBlockStorageDriverStatisticsKey "Statistics"

/*!
 * @defined kIOBlockStorageDriverStatisticsBytesReadKey
 * @abstract
 * Describes the number of bytes read since the block storage
 * driver was instantiated.
 * @discussion
 * This property describes the number of bytes read since the block storage
 * driver was instantiated.  It is one of the statistic entries listed under
 * the top-level kIOBlockStorageDriverStatisticsKey property table.  It has
 * an OSNumber value.
 */

#define kIOBlockStorageDriverStatisticsBytesReadKey "Bytes (Read)"

/*!
 * @defined kIOBlockStorageDriverStatisticsBytesWrittenKey
 * @abstract
 * Describes the number of bytes written since the block storage
 * driver was instantiated.
 * @discussion
 * This property describes the number of bytes written since the block storage
 * driver was instantiated.  It is one of the statistic entries listed under the
 * top-level kIOBlockStorageDriverStatisticsKey property table.  It has an
 * OSNumber value.
 */

#define kIOBlockStorageDriverStatisticsBytesWrittenKey "Bytes (Write)"

UInt64 getDISKcounters(io_iterator_t drivelist)
{
    io_registry_entry_t	drive      	= 0;  /* needs release */
    UInt64         	totalReadBytes  = 0;
    UInt64         	totalWriteBytes = 0;
    
    while ((drive = IOIteratorNext(drivelist))) {
        CFNumberRef 	number      = 0;  /* don't release */
        CFDictionaryRef properties  = 0;  /* needs release */
        CFDictionaryRef statistics  = 0;  /* don't release */
        UInt64 		value       = 0;
        
        /* Obtain the properties for this drive object */
        
        IORegistryEntryCreateCFProperties(drive, (CFMutableDictionaryRef *) &properties, kCFAllocatorDefault, kNilOptions);
        
        /* Obtain the statistics from the drive properties */
        statistics = (CFDictionaryRef) CFDictionaryGetValue(properties, CFSTR(kIOBlockStorageDriverStatisticsKey));
        
        if (statistics) {
            /* Obtain the number of bytes read from the drive statistics */
            number = (CFNumberRef) CFDictionaryGetValue(statistics, CFSTR(kIOBlockStorageDriverStatisticsBytesReadKey));
            if (number) {
                CFNumberGetValue(number, kCFNumberSInt64Type, &value);
                totalReadBytes += value;
            }
            
            /* Obtain the number of bytes written from the drive statistics */
            number = (CFNumberRef) CFDictionaryGetValue (statistics, CFSTR(kIOBlockStorageDriverStatisticsBytesWrittenKey));
            if (number) {
                CFNumberGetValue(number, kCFNumberSInt64Type, &value);
                totalWriteBytes += value;
            }
        }
        
        /* Release resources */
        CFRelease(properties); properties = 0;
        IOObjectRelease(drive); drive = 0;
        
    }
    IOIteratorReset(drivelist);
    
    return (totalReadBytes + totalWriteBytes);
}


@end

