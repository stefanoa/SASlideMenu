# SASlideMenu

Created by **stefanoa**

A simple library to create sliding menus that can be used in storyboards and support static cells. Sliding menus are used in a number of popular applications like Facebook, Path 2.0, GMail, Glassboard and many others.

The repository is an Xcode 4 project that contains two example of the usage of the library and the library itself.
<!-- MacBuildServer Install Button -->
<div class="macbuildserver-block">
    <a class="macbuildserver-button" href="http://macbuildserver.com/project/github/build/?xcode_project=SASlideMenu.xcodeproj&amp;target=SASlideMenuDynamic&amp;repo_url=git%3A%2F%2Fgithub.com%2Fstefanoa%2FSASlideMenu.git&amp;build_conf=Release" target="_blank"><img src="http://com.macbuildserver.github.s3-website-us-east-1.amazonaws.com/button_up.png"/></a><br/><sup><a href="http://macbuildserver.com/github/opensource/" target="_blank">by MacBuildServer</a></sup>
</div>
<!-- MacBuildServer Install Button -->
# Usage
You can use SASlide menu with both static cells and dynamic cell prototypes. In the project you will find two different target that use both type of cells to create a slide menu.
To use it in your project follow these steps:
* Add the SASlideMenu subdir and it's contents to your project
* Add a new class that inherits from **SASlideMenuViewController** and include/implement **SASlideMenuDataSource** and **SASlideMenuDelegate**.
  * **SASlideMenuDataSource** is where you will code your customizationyuo while **SASlideMenuDelegate** is where you will add your code to implement the behavior of your app related to the **SASlideMenu** events.

* Add a new **SASlideMenuRootViewController** in your storyboard
* Add a **UITableViewController** and make it of the **SASlideMenuViewController** subclass you already implemented and customize it in accordance with your needs.
* Connect the **SASlideMenuRootViewController** with your subclass with a custom segue of type **SASlideMenuLeftMenuSegue**, set the segue identifier to **leftMenu**.
* To add Content ViewController you have to to do the following:
 * Create your content view controller and embed it in a **UINavigationController**
 * Connet it to the **SASlideMenuViewController** via a SASlideMenuContentSegue. If you are using static cells and you simply connect from the corresponding cell it is not possible to cache the content view controller and the **segueIdForIndexPath** must not be implemented. If you are using dynamic cell prototype or you are using static cells and you want to cache the content view controller, assign an identifier that will be returned in the **sugueIdForIndexPath:** method linked to the desired indexPath.
* To add a right menu, connect a new **UINavigationController** containing a **UITableViewController** to the menu view controller using a **SASlideMenuRightMenuSegue** and set the segue identifier to **rightMenu**. The new view controller will contain the right menu and will allow navigation.

Test it and you are done!


# Screenshots
![Dynamic](https://raw.github.com/stefanoa/SASlideMenu/master/SASlideMenu/Screenshot-Dynamic-Menu.png)

![Dynamic Right Menu](https://raw.github.com/stefanoa/SASlideMenu/master/SASlideMenu/Screenshot-Dynamic-Right.png)

![Static](https://raw.github.com/stefanoa/SASlideMenu/master/SASlideMenu/Screenshot-Static-Menu.png)

# Requirements

It needs iOS 5.1
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
