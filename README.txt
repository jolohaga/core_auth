= CoreAuth

== Description:

Simple user authentication and role-based authorization.

A frequently recurring task in writing a new web application is creating a role-based auth system to form the basis for access control in the application.  The tasks of creating such a system are extracted in this generator.

== Features/Problems:

* The protected area comprises of a system section (where CoreAuth is controlled and should only
  be managed by a root account-style user) and an admin section where application administrators
  can control the application.
  
  Example: Managing users, roles, and rights (CoreAuth actions) are under system.  Managing
  application specific actions, like new/edit/delete comments, etc. are under admin.
  
  System and Admin are presented under separate paths in the views and separate controllers so
  they are easier to administrate.
  
* Two layouts are defined: site.html.erb and admin.html.erb (with respective .css files).
  site.html.erb is the public layout and invoked in the application controller.
  admin.html.erb is the admin layout and invoked in the CoreAuth controllers.

== Synopsis:

== Requirements:

== Install:

== Developers:

== License:

  Copyright (c) 2010 Jose Hales-Garcia

  Permission is hereby granted, free of charge, to any person obtaining
  a copy of this software and associated documentation files (the
  'Software'), to deal in the Software without restriction, including
  without limitation the rights to use, copy, modify, merge, publish,
  distribute, sublicense, and/or sell copies of the Software, and to
  permit persons to whom the Software is furnished to do so, subject to
  the following conditions:
  
  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.