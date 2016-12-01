//
//  OCMapperConfig.m
//  OCMapper
//
//  Created by Aryan Gh on 8/27/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "OCMapperConfig.h"
#import "OCMapper.h"
#import "ProximateiOSSDK-Swift.h"

@implementation OCMapperConfig

// We call this from appDelegate when application loads

+ (void)configure
{
	InCodeMappingProvider *inCodeMappingProvider = [[InCodeMappingProvider alloc] init];
	CommonLoggingProvider *commonLoggingProvider = [[CommonLoggingProvider alloc] initWithLogLevel:LogLevelInfo];
	
	[[ObjectMapper sharedInstance] setMappingProvider:inCodeMappingProvider];
	[[ObjectMapper sharedInstance] setLoggingProvider:commonLoggingProvider];
	
	/******************* Any custom mapping would go here **********************/
	
    // Map from key 'results' to property 'results' of type 'GoogleSearchResult' which is a property of 'GoogleSearchResponseData' class
    // If the class was named 'Result' it would be mapped automatically, and there would be no need to write any code
    
//    [inCodeMappingProvider mapFromDictionaryKey:@"results"
//                                  toPropertyKey:@"results"
//                                 withObjectType:[GoogleSearchResult class]
//                                       forClass:[GoogleSearchResponseData class]];
//
	[inCodeMappingProvider mapFromDictionaryKey:@"campaigns"
								  toPropertyKey:@"campaigns"
								 withObjectType:[ObjectCampaign class]
									   forClass:[ObjectMerchantGroup class]];
    
    [inCodeMappingProvider mapFromDictionaryKey:@"merchant"
                                  toPropertyKey:@"merchant"
                                 withObjectType:[ObjectMerchant class]
                                       forClass:[ObjectCampaign class]];
    
    [inCodeMappingProvider mapFromDictionaryKey:@"beacons"
                                  toPropertyKey:@"beacons"
                                 withObjectType:[ObjectBeacon class]
                                       forClass:[ObjectCampaign class]];

    [inCodeMappingProvider mapFromDictionaryKey:@"campaignActions"
                                  toPropertyKey:@"campaignActions"
                                 withObjectType:[ObjectCampaignAction class]
                                       forClass:[ObjectCampaign class]];
    
    [inCodeMappingProvider mapFromDictionaryKey:@"contents"
                                  toPropertyKey:@"contents"
                                 withObjectType:[ObjectCampaignMedia class]
                                       forClass:[ObjectCampaign class]];
    
    [inCodeMappingProvider mapFromDictionaryKey:@"media"
                                  toPropertyKey:@"media"
                                 withObjectType:[ObjectCampaignMedia class]
                                       forClass:[ObjectCampaignAction class]];
    
    [inCodeMappingProvider mapFromDictionaryKey:@"geoLocation"
                                  toPropertyKey:@"geoLocation"
                                 withObjectType:[ObjectGeoLocation class]
                                       forClass:[ObjectBeacon class]];
    
    [inCodeMappingProvider mapFromDictionaryKey:@"geoLocation"
                                  toPropertyKey:@"geoLocation"
                                 withObjectType:[ObjectGeoLocation class]
                                       forClass:[ObjectStore class]];
    
    [inCodeMappingProvider mapFromDictionaryKey:@"geoLocation"
                                  toPropertyKey:@"geoLocation"
                                 withObjectType:[ObjectGeoLocation class]
                                       forClass:[ObjectStore class]];
    
    [inCodeMappingProvider mapFromDictionaryKey:@"storeDTO"
                                  toPropertyKey:@"storeDTO"
                                 withObjectType:[ObjectStore class]
                                       forClass:[ObjectBeacon class]];
    
    [inCodeMappingProvider mapFromDictionaryKey:@"y"
                                  toPropertyKey:@"latitude"
                                       forClass:[ObjectGeoLocation class]];
    
    [inCodeMappingProvider mapFromDictionaryKey:@"x"
                                  toPropertyKey:@"longitude"
                                       forClass:[ObjectGeoLocation class]];
    
    [inCodeMappingProvider mapFromDictionaryKey:@"merchantBannerPath"
                                  toPropertyKey:@"merchantBanner"
                                       forClass:[ObjectMerchant class]];
    
    [inCodeMappingProvider mapFromDictionaryKey:@"campaignTimings"
                                  toPropertyKey:@"campaignTimings"
                                 withObjectType:[ObjectCampaignTiming class]
                                       forClass:[ObjectCampaign class]];

    [inCodeMappingProvider mapFromDictionaryKey:@"cards"
                                  toPropertyKey:@"cards"
                                 withObjectType:[ObjectBankCard class]
                                       forClass:[ObjectBank class]];

}

@end
