# Acknowledgements
This application makes use of the following third party libraries:

## AutoScrollLabel

MIT

Copyright (c) 2013 Christopher Bess

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

## BBBadgeBarButtonItem

The MIT License (MIT)

Copyright (c) 2014 Tanguy Aladenise

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

## Bolts

BSD License

For Bolts software

Copyright (c) 2013-present, Facebook, Inc. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

 * Neither the name Facebook nor the names of its contributors may be used to
   endorse or promote products derived from this software without specific
   prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

## CCHMapClusterController

The MIT License (MIT)

Copyright (c) 2013 Claus Höfele

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


## COSTouchVisualizer

Copyright (c) 2014 Joe Blau <josephblau@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


## ICETutorial

ICETutorial
===========

### Welcome to ICETutorial.
This small project is an implementation of the newly tutorial introduced by the Path 3.X app.
Very simple and efficient tutorial, composed with N full-screen pictures that you can swipe for switching to the next/previous page.

Here are the features :
* Compose your own tutorial with N pictures
* Fixed incrusted title (can be easily replaced by an UIImageView, or just removed)
* Scrolling sub-titles for page, with associated descriptions (change the texts, font, color...)
* Auto-scrolling (enable/disable, loop, setup duration)
* Cross fade between next/previous background
* Easy to use block access to button's events.

![ICETutorial](https://github.com/icepat/ICETutorial/blob/master/screen_shot.jpg?raw=true)

### Setting-up the ICETutorial
The code is commented, and I guess, easy to read/understand/modify.
All the available settings for the scrolling are located in the header : ICETutorial.h :

**Texts and pictures :**
```objective-c
    // Init the pages texts, and pictures.
    ICETutorialPage *layer1 = [[ICETutorialPage alloc] initWithSubTitle:@"Picture 1"
                                                            description:@"Champs-Elysées by night"
                                                            pictureName:@"tutorial_background_00@2x.jpg"];
    ICETutorialPage *layer2 = [[ICETutorialPage alloc] initWithSubTitle:@"Picture 2"
                                                            description:@"The Eiffel Tower with\n cloudy weather"
                                                            pictureName:@"tutorial_background_01@2x.jpg"];
    [...] 
```

**Common styles for SubTitles and Descriptions :**
```objective-c
    // Set the common style for SubTitles and Description (can be overrided on each page).
    ICETutorialLabelStyle *subStyle = [[ICETutorialLabelStyle alloc] init];
    [subStyle setFont:TUTORIAL_SUB_TITLE_FONT];
    [subStyle setTextColor:TUTORIAL_LABEL_TEXT_COLOR];
    [subStyle setLinesNumber:TUTORIAL_SUB_TITLE_LINES_NUMBER];
    [subStyle setOffset:TUTORIAL_SUB_TITLE_OFFSET];
    
    ICETutorialLabelStyle *descStyle = [[ICETutorialLabelStyle alloc] init];
    [descStyle setFont:TUTORIAL_DESC_FONT];
    [descStyle setTextColor:TUTORIAL_LABEL_TEXT_COLOR];
    [descStyle setLinesNumber:TUTORIAL_DESC_LINES_NUMBER];
    [descStyle setOffset:TUTORIAL_DESC_OFFSET];

    // Load into an array.
    NSArray *tutorialLayers = @[layer1,layer2,layer3,layer4,layer5];
  
```

**Init and load :**
```objective-c
    self.viewController = [[ICETutorialController alloc] initWithNibName:@"ICETutorialController_iPhone"
                                                                  bundle:nil
                                                                andPages:tutorialLayers];

    // Set the common styles, and start scrolling (auto scroll, and looping enabled by default)
    [self.viewController setCommonPageSubTitleStyle:subStyle];
    [self.viewController setCommonPageDescriptionStyle:descStyle];

    // Set button 1 action.
    [self.viewController setButton1Block:^(UIButton *button){
        NSLog(@"Button 1 pressed.");
    }];
    
    // Set button 2 action, stop the scrolling.    
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.viewController setButton2Block:^(UIButton *button){
        NSLog(@"Button 2 pressed.");
        NSLog(@"Auto-scrolling stopped.");
        
        [weakSelf.viewController stopScrolling];
    }];

    // Run it.
    [self.viewController startScrolling];
```

**The title is located in the ICETutorial.m :**
```objective-c
// Setup the Title Label.
- (void)setOverlayTitle{
    // ...or change by an UIImageView if you need it.
    [_overlayTitle setText:@"Welcome"];
}
```

Checkout the others projects available on my account [@Icepat](https://github.com/icepat/).

Questions or ideas : patrick.trillsam@gmail.com.


###License :

The MIT License

Copyright (c) 2013 Patrick Trillsam - ICETutorial

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


## LayerKit

# LAYER SDK LICENSE

This is an agreement between You ("You") and Layer Inc., located at 470 Alabama Street, San Francisco, CA 94110, ("Layer") regarding Your use of the Layer SDK and any associated documentation or other materials made available by Layer (collectively the "SDK"). This agreement applies to any updates or supplements for the SDK, unless other terms accompany those items. If so, those other terms apply.

By installing, accessing or otherwise using the SDK, You accept the terms of this agreement. If You do not agree to the terms of this agreement, do not install, access or use the SDK.

If You comply with this agreement, You have the rights below.

(1) USE OF THE SDK. Subject to Your compliance with this agreement, Layer hereby authorizes You to use the SDK solely for the purpose of creating mobile applications designed to operate with the Services (referred to as "Authorized Applications"). You may not rent, lease or lend any of Your rights in the SDK or access to the Services. You may make a reasonable number of copies of the SDK for the purposes set forth herein, provided that You reproduce only complete copies, including without limitation all "read me" files, copyright notices, and other legal notices and terms that Layer has included in the SDK. 

(2) SCOPE OF LICENSE. The SDK is licensed, not sold. This agreement only gives You some rights to use the SDK. Layer specifically does not grant any express or implied rights under its patents with respect to your Authorized Applications. In doing so, You must comply with any technical limitations in the SDK that only allow You to use it in certain ways. You may not: (a) reverse engineer, decompile, distribute or disassemble the SDK, except and only to the extent that applicable law expressly permits; or (b) make more copies of the SDK than specified in this agreement, except and only to the extent applicable law expressly permits; or (c) publish the SDK for others to copy; or (d) rent, lease or lend the SDK.

(3) USE OF THE SERVICES. Your use of the Services, and the use of the Services by anyone hosting or using your Authorized Application, is governed by the then-current Terms of Services (“TOS”) which can be found at: https://layer.com/terms.

(4) EXPORT RESTRICTIONS. THE SDK IS SUBJECT TO UNITED STATES EXPORT LAWS AND REGULATIONS. YOU MUST COMPLY WITH ALL DOMESTIC AND INTERNATIONAL EXPORT LAWS AND REGULATIONS THAT APPLY TO THE SDK.
	
(5) FEEDBACK. By submitting feedback to Layer, either via email at support@layer.com or by any other means: You automatically grant to Layer a perpetual, irrevocable, transferable, royalty-free license to use Your feedback for any and all purposes without any compensation to You.

(6) TERMINATION. Layer reserves the right to discontinue offering the SDK or Services or to modify the SDK or Services at any time in its sole discretion. This Section and Sections 3, 4, 5, 8, 9, 10, 11, and 12 will survive termination of this agreement or any discontinuation of the offering of the SDK or Services along with any other provisions that would reasonably be deemed to survive such events.

(7) RESERVATION OF RIGHTS.  You are not authorized to alter, modify, copy, edit, format, create derivative works of or otherwise use any materials, content or technology provided under this agreement except as explicitly provided in this agreement or approved in advance in writing by Layer.

(8) MODIFICATIONS; NOTICES. If we change this contract, then we will give you notice before the change is in force. If you do not agree to these changes, then you must cancel and stop using the SDK and Services before the changes are in force. If you do not stop using the SDK or Services, then your use of the SDK or Services will continue under the changed contract. Layer may give notices to You, at Layer's option, by posting on any portion of Layer.com or by electronic mail to any e-mail address provided by You to Layer.

(9) ENTIRE AGREEMENT. This agreement, and any applicable TOS or contract for Services, are the entire agreement with respect to the SDK or Services.

(10) APPLICABLE LAW AND VENUE. California state law governs the interpretation of this agreement and applies to claims for breach of it, regardless of conflict of laws principles.  The laws of the state where You live govern all other claims, including claims under state consumer protection laws, unfair competition laws, and in tort. You agree that any action brought under this agreement will be subject to exclusive jurisdiction and venue in the state and federal courts located in San Francisco, California.

(11) DISCLAIMER OF WARRANTY. The SDK is licensed "as-is." You bear the risk of using it. Layer gives no express or implied warranties, guarantees or conditions. You may have additional consumer rights under Your local laws which this agreement cannot change. To the extent permitted under Your local laws, Layer excludes the implied warranties of merchantability, fitness for a particular purpose and non-infringement. Layer does not represent or warrant that the SDK or the Services will always be available, uninterrupted, secure, or error free. 

(12) LIMITATION ON AND EXCLUSION OF REMEDIES AND DAMAGES. You can recover from Layer and its suppliers only direct damages up to U.S. $5.00. You cannot recover any other damages, including consequential, lost profits, special, indirect or incidental damages. This limitation applies to:

  a. anything related to the SDK, services, or content (including code) on third party Internet sites, or third party programs; and
  
  b. claims for breach of contract, breach of warranty, guarantee or condition, strict liability, negligence, or other tort to the extent permitted by applicable law.


## Parse

See https://www.parse.com/about/terms

## SlackTextViewController


   Copyright 2014 Slack Technologies, Inc.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.


## TPKeyboardAvoiding

Copyright (c) 2013 Michael Tyson

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgment in the product documentation would be
   appreciated but is not required.

2. Altered source versions must be plainly marked as such, and must not be
   misrepresented as being the original software.

3. This notice may not be removed or altered from any source
   distribution.

## UICountingLabel

The MIT License (MIT)

Copyright (c) 2013 Tim Gostony

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

## XLForm

The MIT License (MIT)

Copyright (c) 2014 Xmartlabs ( http://xmartlabs.com )

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Generated by CocoaPods - http://cocoapods.org
