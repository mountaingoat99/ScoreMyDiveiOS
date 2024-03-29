//
//  HTAutocompleteManager.m
//  HotelTonight
//
//  Created by Jonathan Sibley on 12/6/12.
//  Copyright (c) 2012 Hotel Tonight. All rights reserved.
//

#import "HTAutocompleteManager.h"
#import "AllSpringboardDives.h"
#import "AllPlatformDives.h"

static HTAutocompleteManager *sharedManager;

@implementation HTAutocompleteManager

+ (HTAutocompleteManager *)sharedManager
{
	static dispatch_once_t done;
	dispatch_once(&done, ^{ sharedManager = [[HTAutocompleteManager alloc] init]; });
	return sharedManager;
}

#pragma mark - HTAutocompleteTextFieldDelegate

- (NSString *)textField:(HTAutocompleteTextField *)textField
    completionForPrefix:(NSString *)prefix
             ignoreCase:(BOOL)ignoreCase
{
    if (textField.autocompleteType == HTAutocompleteTypeEmail)
    {
        static dispatch_once_t onceToken;
        static NSArray *autocompleteArray;
        dispatch_once(&onceToken, ^
                      {
                          autocompleteArray = @[  @"gmail.com",
                                                  @"yahoo.com",
                                                  @"hotmail.com",
                                                  @"aol.com",
                                                  @"comcast.net",
                                                  @"me.com",
                                                  @"msn.com",
                                                  @"live.com",
                                                  @"sbcglobal.net",
                                                  @"ymail.com",
                                                  @"att.net",
                                                  @"mac.com",
                                                  @"cox.net",
                                                  @"verizon.net",
                                                  @"hotmail.co.uk",
                                                  @"bellsouth.net",
                                                  @"rocketmail.com",
                                                  @"aim.com",
                                                  @"yahoo.co.uk",
                                                  @"earthlink.net",
                                                  @"charter.net",
                                                  @"optonline.net",
                                                  @"shaw.ca",
                                                  @"yahoo.ca",
                                                  @"googlemail.com",
                                                  @"mail.com",
                                                  @"qq.com",
                                                  @"btinternet.com",
                                                  @"mail.ru",
                                                  @"live.co.uk",
                                                  @"naver.com",
                                                  @"rogers.com",
                                                  @"juno.com",
                                                  @"yahoo.com.tw",
                                                  @"live.ca",
                                                  @"walla.com",
                                                  @"163.com",
                                                  @"roadrunner.com",
                                                  @"telus.net",
                                                  @"embarqmail.com",
                                                  @"hotmail.fr",
                                                  @"pacbell.net",
                                                  @"sky.com",
                                                  @"sympatico.ca",
                                                  @"cfl.rr.com",
                                                  @"tampabay.rr.com",
                                                  @"q.com",
                                                  @"yahoo.co.in",
                                                  @"yahoo.fr",
                                                  @"hotmail.ca",
                                                  @"windstream.net",
                                                  @"hotmail.it",
                                                  @"web.de",
                                                  @"asu.edu",
                                                  @"gmx.de",
                                                  @"gmx.com",
                                                  @"insightbb.com",
                                                  @"netscape.net",
                                                  @"icloud.com",
                                                  @"frontier.com",
                                                  @"126.com",
                                                  @"hanmail.net",
                                                  @"suddenlink.net",
                                                  @"netzero.net",
                                                  @"mindspring.com",
                                                  @"ail.com",
                                                  @"windowslive.com",
                                                  @"netzero.com",
                                                  @"yahoo.com.hk",
                                                  @"yandex.ru",
                                                  @"mchsi.com",
                                                  @"cableone.net",
                                                  @"yahoo.com.cn",
                                                  @"yahoo.es",
                                                  @"yahoo.com.br",
                                                  @"cornell.edu",
                                                  @"ucla.edu",
                                                  @"us.army.mil",
                                                  @"excite.com",
                                                  @"ntlworld.com",
                                                  @"usc.edu",
                                                  @"nate.com",
                                                  @"outlook.com",
                                                  @"nc.rr.com",
                                                  @"prodigy.net",
                                                  @"wi.rr.com",
                                                  @"videotron.ca",
                                                  @"yahoo.it",
                                                  @"yahoo.com.au",
                                                  @"umich.edu",
                                                  @"ameritech.net",
                                                  @"libero.it",
                                                  @"yahoo.de",
                                                  @"rochester.rr.com",
                                                  @"cs.com",
                                                  @"frontiernet.net",
                                                  @"swbell.net",
                                                  @"msu.edu",
                                                  @"ptd.net",
                                                  @"proxymail.facebook.com",
                                                  @"hotmail.es",
                                                  @"austin.rr.com",
                                                  @"nyu.edu",
                                                  @"sina.com",
                                                  @"centurytel.net",
                                                  @"usa.net",
                                                  @"nycap.rr.com",
                                                  @"uci.edu",
                                                  @"hotmail.de",
                                                  @"yahoo.com.sg",
                                                  @"email.arizona.edu",
                                                  @"yahoo.com.mx",
                                                  @"ufl.edu",
                                                  @"bigpond.com",
                                                  @"unlv.nevada.edu",
                                                  @"yahoo.cn",
                                                  @"ca.rr.com",
                                                  @"google.com",
                                                  @"yahoo.co.id",
                                                  @"inbox.com",
                                                  @"fuse.net",
                                                  @"hawaii.rr.com",
                                                  @"talktalk.net",
                                                  @"gmx.net",
                                                  @"walla.co.il",
                                                  @"ucdavis.edu",
                                                  @"carolina.rr.com",
                                                  @"comcast.com",
                                                  @"live.fr",
                                                  @"blueyonder.co.uk",
                                                  @"live.cn",
                                                  @"cogeco.ca",
                                                  @"abv.bg",
                                                  @"tds.net",
                                                  @"centurylink.net",
                                                  @"yahoo.com.vn",
                                                  @"uol.com.br",
                                                  @"osu.edu",
                                                  @"san.rr.com",
                                                  @"rcn.com",
                                                  @"umn.edu",
                                                  @"live.nl",
                                                  @"live.com.au",
                                                  @"tx.rr.com",
                                                  @"eircom.net",
                                                  @"sasktel.net",
                                                  @"post.harvard.edu",
                                                  @"snet.net",
                                                  @"wowway.com",
                                                  @"live.it",
                                                  @"hoteltonight.com",
                                                  @"att.com",
                                                  @"vt.edu",
                                                  @"rambler.ru",
                                                  @"temple.edu",
                                                  @"cinci.rr.com"];
                      });
        
        // Check that text field contains an @
        NSRange atSignRange = [prefix rangeOfString:@"@"];
        if (atSignRange.location == NSNotFound)
        {
            return @"";
        }
        
        // Stop autocomplete if user types dot after domain
        NSString *domainAndTLD = [prefix substringFromIndex:atSignRange.location];
        NSRange rangeOfDot = [domainAndTLD rangeOfString:@"."];
        if (rangeOfDot.location != NSNotFound)
        {
            return @"";
        }
        
        // Check that there aren't two @-signs
        NSArray *textComponents = [prefix componentsSeparatedByString:@"@"];
        if ([textComponents count] > 2)
        {
            return @"";
        }
        
        if ([textComponents count] > 1)
        {
            // If no domain is entered, use the first domain in the list
            if ([(NSString *)textComponents[1] length] == 0)
            {
                return [autocompleteArray objectAtIndex:0];
            }
            
            NSString *textAfterAtSign = textComponents[1];
            
            NSString *stringToLookFor;
            if (ignoreCase)
            {
                stringToLookFor = [textAfterAtSign lowercaseString];
            }
            else
            {
                stringToLookFor = textAfterAtSign;
            }
            
            for (NSString *stringFromReference in autocompleteArray)
            {
                NSString *stringToCompare;
                if (ignoreCase)
                {
                    stringToCompare = [stringFromReference lowercaseString];
                }
                else
                {
                    stringToCompare = stringFromReference;
                }
                
                if ([stringToCompare hasPrefix:stringToLookFor])
                {
                    return [stringFromReference stringByReplacingCharactersInRange:[stringToCompare rangeOfString:stringToLookFor] withString:@""];
                }
                
            }
        }
    }
    else if (textField.autocompleteType == HTAutocompleteTypeColor)
    {
        static dispatch_once_t colorOnceToken;
        static NSArray *colorAutocompleteArray;
        dispatch_once(&colorOnceToken, ^
        {
            colorAutocompleteArray = @[ @"Alfred",
                                        @"Beth",
                                        @"Carlos",
                                        @"Daniel",
                                        @"Ethan",
                                        @"Fred",
                                        @"George",
                                        @"Helen",
                                        @"Inis",
                                        @"Jennifer",
                                        @"Kylie",
                                        @"Liam",
                                        @"Melissa",
                                        @"Noah",
                                        @"Omar",
                                        @"Penelope",
                                        @"Quan",
                                        @"Rachel",
                                        @"Seth",
                                        @"Timothy",
                                        @"Ulga",
                                        @"Vanessa",
                                        @"William",
                                        @"Xao",
                                        @"Yilton",
                                        @"Zander"];
        });

        NSString *stringToLookFor;
		NSArray *componentsString = [prefix componentsSeparatedByString:@","];
        NSString *prefixLastComponent = [componentsString.lastObject stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (ignoreCase)
        {
            stringToLookFor = [prefixLastComponent lowercaseString];
        }
        else
        {
            stringToLookFor = prefixLastComponent;
        }
        
        for (NSString *stringFromReference in colorAutocompleteArray)
        {
            NSString *stringToCompare;
            if (ignoreCase)
            {
                stringToCompare = [stringFromReference lowercaseString];
            }
            else
            {
                stringToCompare = stringFromReference;
            }
            
            if ([stringToCompare hasPrefix:stringToLookFor])
            {
                return [stringFromReference stringByReplacingCharactersInRange:[stringToCompare rangeOfString:stringToLookFor] withString:@""];
            }
            
        }
    } else if (textField.autocompleteType == HTAutoCompleteTypeNumbers) {
        
        static dispatch_once_t numberOnceToken;
        static NSArray *validNumbers;
        dispatch_once(&numberOnceToken, ^
        {
            validNumbers = @[ @"0.0",
                             @"0.5",
                             @"1.0",
                             @"1.5",
                             @"2.0",
                             @"2.5",
                             @"3.0",
                             @"3.5",
                             @"4.0",
                             @"4.5",
                             @"5.0",
                             @"5.5",
                             @"6.0",
                             @"6.5",
                             @"7.0",
                             @"7.5",
                             @"8.0",
                             @"8.5",
                             @"9.0",
                             @"9.5",
                             @"10.0"];
        });
        
        NSString *stringToLookFor;
        NSArray *componentsString = [prefix componentsSeparatedByString:@","];
        NSString *prefixLastComponent = [componentsString.lastObject stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (ignoreCase)
        {
            stringToLookFor = [prefixLastComponent lowercaseString];
        }
        else
        {
            stringToLookFor = prefixLastComponent;
        }
        
        for (NSString *stringFromReference in validNumbers)
        {
            NSString *stringToCompare;
            if (ignoreCase)
            {
                stringToCompare = [stringFromReference lowercaseString];
            }
            else
            {
                stringToCompare = stringFromReference;
            }
            
            if ([stringToCompare hasPrefix:stringToLookFor])
            {
                return [stringFromReference stringByReplacingCharactersInRange:[stringToCompare rangeOfString:stringToLookFor] withString:@""];
            }
        }
        
    } else if (textField.autocompleteType == HTAutocompleteSpringboard) {
        
        static dispatch_once_t numberOnceToken;
        static NSArray *springBoardNumber;
        
        AllSpringboardDives *dives = [[AllSpringboardDives alloc] init];
        
        dispatch_once(&numberOnceToken, ^
                      {
                          springBoardNumber = [dives GetSpringboardName];
                      });
        
        NSString *stringToLookFor;
        NSArray *componentsString = [prefix componentsSeparatedByString:@","];
        NSString *prefixLastComponent = [componentsString.lastObject stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (ignoreCase)
        {
            stringToLookFor = [prefixLastComponent lowercaseString];
        }
        else
        {
            stringToLookFor = prefixLastComponent;
        }
        
        for (int i = 0; i < springBoardNumber.count; i++) {
            NSString *stringFromReference = [[springBoardNumber objectAtIndex:i] objectAtIndex:0];
        
            NSString *stringToCompare;
            if (ignoreCase)
            {
                stringToCompare = [stringFromReference lowercaseString];
            }
            else
            {
                stringToCompare = stringFromReference;
            }
            
            if ([stringToCompare hasPrefix:stringToLookFor])
            {
                return [stringFromReference stringByReplacingCharactersInRange:[stringToCompare rangeOfString:stringToLookFor] withString:@""];
            }
        }
        
    } else if (textField.autocompleteType == HTAutocompletePlatform) {
        
        static dispatch_once_t numberOnceToken;
        static NSArray *platFormNumber;
        
        // call the class to get all the springboard dives
        AllPlatformDives *dives = [[AllPlatformDives alloc] init];
        
        dispatch_once(&numberOnceToken, ^
                      {
                          platFormNumber = [dives GetPlatformNames];
                      });
        
        NSString *stringToLookFor;
        NSArray *componentsString = [prefix componentsSeparatedByString:@","];
        NSString *prefixLastComponent = [componentsString.lastObject stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (ignoreCase)
        {
            stringToLookFor = [prefixLastComponent lowercaseString];
        }
        else
        {
            stringToLookFor = prefixLastComponent;
        }
        
        for (int i = 0; i < platFormNumber.count; i++) {
            NSString *stringFromReference = [[platFormNumber objectAtIndex:i] objectAtIndex:0];
            
            NSString *stringToCompare;
            if (ignoreCase)
            {
                stringToCompare = [stringFromReference lowercaseString];
            }
            else
            {
                stringToCompare = stringFromReference;
            }
            
            if ([stringToCompare hasPrefix:stringToLookFor])
            {
                return [stringFromReference stringByReplacingCharactersInRange:[stringToCompare rangeOfString:stringToLookFor] withString:@""];
            }
        }
        
    } else if (textField.autocompleteType == HTAutocompletePositions) {
        
        static dispatch_once_t numberOnceToken;
        static NSArray *positions;
        dispatch_once(&numberOnceToken, ^
                      {
                          positions = @[ @"A",
                                            @"B",
                                            @"C",
                                            @"D"];
                      });
        
        NSString *stringToLookFor;
        NSArray *componentsString = [prefix componentsSeparatedByString:@","];
        NSString *prefixLastComponent = [componentsString.lastObject stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (ignoreCase)
        {
            stringToLookFor = [prefixLastComponent lowercaseString];
        }
        else
        {
            stringToLookFor = prefixLastComponent;
        }
        
        for (NSString *stringFromReference in positions)
        {
            NSString *stringToCompare;
            if (ignoreCase)
            {
                stringToCompare = [stringFromReference lowercaseString];
            }
            else
            {
                stringToCompare = stringFromReference;
            }
            
            if ([stringToCompare hasPrefix:stringToLookFor])
            {
                return [stringFromReference stringByReplacingCharactersInRange:[stringToCompare rangeOfString:stringToLookFor] withString:@""];
            }
        }
        
    }
    
    return @"";
}

@end
