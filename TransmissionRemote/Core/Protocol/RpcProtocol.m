//
//  RpcProtocol.m
//  TransmissionRemote
//
//  Created by Александр Турченко on 18.11.12.
//  Copyright (c) 2012 TurchenkoAlex. All rights reserved.
//

#import "RpcProtocol.h"
#import "ServerStatus.h"
#import "Torrent.h"

@implementation RpcProtocol

-(id)init {
    self = [super init];
    if (self) {
        NSString *fullTorrentFields = @"\"id\", \"name\", \"status\", \"comment\", \"percentDone\", \"recheckProgress\", \"uploadRatio\", \"totalSize\"";
        NSString *torrentFields = @"\"id\", \"status\", \"percentDone\", \"recheckProgress\", \"uploadRatio\"";
        
        sessionGet = @"{ \"method\": \"session-get\" }";
        torrentsInitialize = [NSString stringWithFormat: @"{ \"method\": \"torrent-get\", \"arguments\": { \"fields\" : [%@] } }", fullTorrentFields] ;
        torrentsUpdate = [NSString stringWithFormat:@"{ \"method\": \"torrent-get\", \"arguments\": { \"fields\" : [%@] } }", torrentFields];
        torrentsFullUpdate = [NSString stringWithFormat:@"{ \"method\": \"torrent-get\", \"arguments\": { \"fields\" : [%@], \"ids\": [%@] } }", fullTorrentFields, @"%@"];
        
        torrentStop = @"{ \"method\": \"torrent-stop\", \"arguments\": { \"ids\": [%@] } }";
        torrentStart = @"{ \"method\": \"torrent-start\", \"arguments\": { \"ids\": [%@] } }";
        torrentVerify = @"{ \"method\": \"torrent-verify\", \"arguments\": { \"ids\": [%@] } }";
        torrentRemove = @"{ \"method\": \"torrent-remove\", \"arguments\": { \"ids\": [%@], \"delete-local-data\": %@ } }";
        torrentAddFile = @"{ \"method\": \"torrent-add\", \"arguments\": { \"paused\": true, \"metainfo\": \"%@\" } }";
        torrentAddUrl = @"{ \"method\": \"torrent-add\", \"arguments\": { \"paused\": true, \"filename\": \"%@\" } }";
    }
    return self;
}

-(id)initWithDelegate:(id <RpcProtocolHandlerDelegate>)aDelegate {
    self = [self init];
    if (self) {
        self.delegate = aDelegate;
    }
    return self;
}

#pragma mark - Requests

#pragma mark - Requests session-get
-(NSUInteger)sessionGetTag {
    return 1;
}

-(NSString *)sessionGetQuery {
    return sessionGet;
}

#pragma mark - Requests torrent-get

-(NSUInteger)torrentGetInitializeTag {
    return 2;
}
-(NSString *)torrentGetInitializeQuery {
    return torrentsInitialize;
}

-(NSUInteger)torrentGetUpdateTag {
    return 3;
}

-(NSString *)torrentGetUpdateQuery {
    return torrentsUpdate;
}

-(NSUInteger)torrentGetFullUpdateTag {
    return 4;
}

-(NSString *)torrentGetFullUpdateQueryWithIds:(NSString *)aIds {
    return [NSString stringWithFormat:torrentsFullUpdate, aIds];
}

-(NSUInteger)torrentStopTag {
    return 5;
}

-(NSString *)torrentStopQueryWithIds:(NSString *)aIds {
    return [NSString stringWithFormat:torrentStop, aIds];
}

-(NSUInteger)torrentStartTag {
    return 6;
}

-(NSString *)torrentStartQueryWithIds:(NSString *)aIds {
    return [NSString stringWithFormat:torrentStart, aIds];
}

-(NSUInteger)torrentVerifyTag {
    return 7;
}

-(NSString *)torrentVerifyQueryWithIds:(NSString *)aIds {
    return [NSString stringWithFormat:torrentVerify, aIds];
}

-(NSUInteger)torrentRemoveTag {
    return 8;
}

-(NSString *)torrentRemoveQueryWithIds:(NSString *)aIds andDeleteLocalData:(BOOL)useDeleteLocalData {
    return [NSString stringWithFormat:torrentRemove, aIds, useDeleteLocalData ? @"true" : @"false"];
}

-(NSUInteger)torrentAddFileTag {
    return 9;
}

-(NSString *)torrentAddFileQueryWithData:(NSString *)fileData {
    return [NSString stringWithFormat:torrentAddFile, fileData];
}


#pragma mark - Proceeding response

-(BOOL)proceedResponse:(NSData *)aResponseData andTag:(NSUInteger)aTag {
    NSError *error;
    id jsonData = [NSJSONSerialization JSONObjectWithData:aResponseData options:NSJSONReadingMutableContainers error:&error];
    BOOL success = [[jsonData valueForKey:@"result"] isEqualToString:@"success"];
    if (success) {
        // success request
        NSDictionary *arguments = [jsonData valueForKey:@"arguments"];
        if (arguments) {
            [self procceedResult:arguments withTag:aTag];
        }
    } else {
        // error request
        NSLog(@"Serialization error: %@", [[NSString alloc] initWithData:aResponseData encoding:NSUTF8StringEncoding]);
    }
    return success;
}

-(void)procceedResult:(NSDictionary *)aResult withTag:(NSUInteger)aTag {
    switch (aTag) {
        case 3:
            // torrent-get update
            [self proceedTorrentUpdateGetResult:aResult];
            break;

        case 4:
            // torrent-get fullUpdate
            [self proceedTorrentFullUpdateGetResult:aResult];
            break;
            
        case 1:
            // session-get
            [self proceedSessionGetResult:aResult];
            break;
            
        case 2:
            // torrent-get initialize
            [self proceedTorrentInitializeGetResult:aResult];
            break;
            
        case 5:
            // torrent-stop
        case 6:
            // torrent-start
        case 7:
            // torrent-verify
        case 8:
            // torrent-remove
            break;
        case 9:
            // torrent-add
            [self proceedAddTorrentGetResult:aResult];
            break;
            
        default:
            // unknown request
            break;
    }
}

-(void)proceedSessionGetResult:(NSDictionary *)aResult {
    if (aResult) {
        ServerStatus *serverStatus = [[ServerStatus alloc] init];
        serverStatus.connected = YES;
        serverStatus.version = [NSString stringWithFormat:@"Transmission %@", [aResult objectForKey:@"version"]];
        if (_delegate) {
            [_delegate didSessionGetRequestReceived:serverStatus];
        }
    }
}

-(Torrent *)torrentFromObject:(id)aObject {
    Torrent *torrent = [[Torrent alloc] init];
    torrent.torrentId = [[aObject valueForKey:@"id"] integerValue];
    torrent.torrentName = [[aObject valueForKey:@"name"] copy];
    torrent.torrentComment = [aObject valueForKey:@"comment"];
    torrent.torrentState = [[aObject valueForKey:@"status"] shortValue];
    torrent.torrentDownloadPercent = [[aObject valueForKey:@"percentDone"] doubleValue] * 100;
    torrent.torrentVerifyPercent = [[aObject valueForKey:@"recheckProgress"] doubleValue] * 100;
    torrent.uploadRatio = [[aObject valueForKey:@"uploadRatio"] doubleValue];
    torrent.totalSize = [[aObject valueForKey:@"totalSize"] unsignedIntegerValue];
    return torrent;
}

-(NSMutableArray *)torrentsFromDictionary:(NSDictionary *)aDictionary {
    if (aDictionary) {
        NSMutableArray *torrents = [NSMutableArray arrayWithCapacity:[aDictionary count]];
        for (id item in aDictionary) {
            [torrents addObject:[self torrentFromObject:item]];
        }
        return torrents;
    } else {
        return nil;
    }
}

-(void)proceedTorrentInitializeGetResult:(NSDictionary *)aResult {
    if (_delegate) {
        [_delegate didInitializeTorrentsRequestReceived:[self torrentsFromDictionary:[aResult valueForKey:@"torrents"]]];
    }
}

-(void)proceedTorrentUpdateGetResult:(NSDictionary *)aResult {
    if (_delegate) {
        [_delegate didUpdateTorrentsRequestReceived:[self torrentsFromDictionary:[aResult valueForKey:@"torrents"]]];
    }
}

-(void)proceedTorrentFullUpdateGetResult:(NSDictionary *)aResult {
    if (_delegate) {
        [_delegate didFullUpdateTorrentsRequestReceived:[self torrentsFromDictionary:[aResult valueForKey:@"torrents"]]];
    }
}

-(void)proceedAddTorrentGetResult:(NSDictionary *)aResult {
    if (_delegate) {
        [_delegate didAddTorrentsRequestReceived:[[[aResult valueForKey:@"torrent-added"] valueForKey:@"id"] unsignedIntegerValue]];
    }
}

@end
