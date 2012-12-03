# SASlideMenu

Created by **stefanoa**

A simple library to create sliding menus that can be used in storyboards and support static cells. Sliding menus are used in a number of popular applications like Facebook, Path 2.0,GMail, Glassboard and many others.

The repository is an Xcode 4 project that contains two example of the usage of the library and the library itself.

# Usage
You can create two type of SASlide menu, Static and Dynamic. The Static type support static cells, you can add static items and directly connect them via segues to your desired view controller, however the static type must inherit from UITableViewController and if too many items are added the menu will scroll with also the content, which is not desiderable. The Dynamic type support unlimeted tables of menu items, content controller caching and right side menu, however it requires a little more code.

To use them in your in your projects follow these steps:

#Dynamic (see ExampleDynamicMenuViewController)
* Add the SASlideMenu subdir and his content to your project
* Add a new class that inherit from **SASlideMenuDynamicViewController** and implement **SASlideMenuDatSource**.
* Add a new **UIViewController** to your storyboard and make it of the newly created class, it will be the SASlideMenu view controller
* Add a UITableView to the controller and connect it to the tableView outlet, connect  the dataSource and delegate outlet to the view controller
* Connect the SASlideMenu view controller to the desired view controllers using the **SASlideMenuDynamicStoryboardSegue**, remember to define also the segue identifier for each segue, correctly map the **indexPath** of the menu item to the desired segue identifier in the **-(NSString*) sugueIdForIndexPath:(NSIndexPath*) indexPath;** method of the **SASlideMenuDataSource**

#Static (see ExampleStaticMenuViewController)

* Add the SASlideMenu subdir and his content to your project
* Add a new class that inherit from **SASlideMenuStaticViewController** and implement the required methods of  **SASlideMenuDatSource** to define the initial segue and the custom appearence of the Slide Menu button
* Add a new **UITableViewController** to your storyboard and make it of the newly created class
* Configure the UITableVIew as needed and connect the cell of the table to the desired UINavigationViewController via a custom segue with class SASlideMenuStoryboardSegue. Assign to the desired initial segue the correct identifier.

Test it and you are done!

# Screenshots
![Dynamic](https://raw.github.com/stefanoa/SASlideMenu/master/SASlideMenu/Screenshot-Dynamic-Menu.png)

![Dynamic Right Menu](https://raw.github.com/stefanoa/SASlideMenu/master/SASlideMenu/Screenshot-Dynamic-Right.png)

![Static](https://raw.github.com/stefanoa/SASlideMenu/master/SASlideMenu/Screenshot-Static-Menu.png)

# Requirements

It needs iOS 5.1 and works also on iPad
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