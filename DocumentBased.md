# What does document-based mean? #

I've taken the name "document-based" from the Cocoa environment. When you start a new project in Apple's Xcode you have the choice between creating an "application" or a "document-based application". One difference between these two is that document-based applications have one semi-autonomous controller per open document in addition to the main application controller, whereas a regular application only has the one.

In a document-based application each document can be though of as a mini-application within a larger application. The controller of the whole application orchestrates creation and destruction of documents, as well as other non-document-related actions, but all actions performed on a document is handled by the document controller.

When explaning the benefits of MVC one feature often mentioned is that it's easy to have several different views showing the same data, a bunch of numbers can be shown as a graph or as a table, say. A document-based application could be seen as the reverse of that: several identical views showing different data.

## So, what's the problem? ##

In my experience most application frameworks for RIA development don't support document-based applications very well. They usually favour a single and/or global application controller, making it hard to create applications-within-applications. The same problem applies to situations where you want to divide your application into multiple semi-autonomous modules, or support a plug-in architecture where the plug-ins are fairly complex.

It's certainly possible to create document-based applications using for example Cairngorm or Swiz, but their focus on a single and global controller doesn't help you, and is mostly in your way. Because each action on a document needs to be handled by the application controller, you have to pass a lot of context information along, just to show which document you want to perform the action on.

The multicore version of PureMVC makes it possible to have multiple application controllers (façades) within the same application, but in a document-based application you want to create sub-applications, not completely separate applications. The PureMVC multicore probably works better for document-based applications than Cairngorm or Swiz do, but it instead of no separation, you get complete separation.

The reason Mate works better than the aforementioned application frameworks is that it has support for sub-controllers in the form of local event maps.

In Mate, regular event maps hears events dispatched anywhere in the application (if the bubble), this is similar to how the application controller works in Cairngorm, Swiz and PureMVC (except that these use a central event dispatching mechanism and Mate uses the display list). This means that even if you had multiple application controllers they would all hear the same events. Local event maps, in contrast, only hear events comming from the part of the application where they live. This makes it possible to have several instances of a component and let each be controlled independently (from the others and from the application) by a local event map.