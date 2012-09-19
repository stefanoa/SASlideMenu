# SASlideMenu

Created by **stefanoa**

A simple library to create sliding menus that can be used in storyboards and support static cells. Sliding menus are used in a number of popular applications like Facebook, Path 2.0, Glassboard and many others.

The repository is an Xcode 4 project that contains an example of the usage of the library and the library itself.

# Usage

To use it in your projects follow these steps:

* Add the SASlideMenu subdir and his content to your project
* Add a new class that inherit from **SASlideMenuViewController** and implement **SASlideMenuDatSource** to define the initial segue and the custom appearence of the Slide Menu button
* Add a new **UITableViewController** to your storyboard and make it of the newly created class
* Configure the UITableVIew as needed and connect the cell of the table to the desired UINavigationViewController via a custom segue with class SASlideMenuStoryboardSegue. Assign to the desired initial segue the correct identifier.

Test it and you are done!

# Requirements

It needs iOS 5.1 and works only on iPhone

# License

**SASlideMenu** is available under the MIT license:

*Copyright (c) 2012 stefanoa*

*Permission is hereby granted, free of charge, to any person obtaining a copy*
*of this software and associated documentation files (the "Software"), to deal*
*in the Software without restriction, including without limitation the rights*
*to use, copy, modify, merge, publish, distribute, sublicense, and/or sell*
*copies of the Software, and to permit persons to whom the Software is*
*furnished to do so, subject to the following conditions:*

*The above copyright notice and this permission notice shall be included in*
*all copies or substantial portions of the Software.*

*THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR*
*IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,*
*FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE*
*AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER*
*LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,*
*OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN*
*THE SOFTWARE.*