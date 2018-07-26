//
//  JUST_SOME_NOTES.swift
//  Tandm
//
//  Created by Shepard Tamler on 4/18/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

/*  RE INSTANCE METHOD V CLASS METHOD

You can only call an instance method on an instance of a class. For example, you would have to create an instance of myScript, then call it:

 let script = myScript()
 script.thisIsmyFunction()
 
You can also choose to make thisIsmyFunction a class method (which is formally known as a "type method" in Swift), and call it like the way you are doing right now:

 class func thisIsmyFunction() {...}
 
Note the class modifier in front of func. Of course, this means you can't access self inside the function, because there is no longer an instance of the class.

 */


/*
    PROJECT NAVIGATOR CODES
 
 ? - means the file has not been added to source control
 M - Modified
 A - Added file, not yet under source control
 A+ - Moved / renamed
 U - Newer version of a file on source control
 I - Item is being ignored
 ! - Item is missing (e.g. you moved or deleted it). This also indicates that a directory is incomplete (a checkout or update was interrupted).
 
 */
