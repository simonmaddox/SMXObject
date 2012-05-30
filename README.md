# SMXObject

I was bored of continually implementing NSCoding in my classes. Most of the 
time, I was taking each of my properties and encoding them as they are. So 
I was essentially writing lots of boilerplate code.

Enter **SMXObject**.

Rather than subclassing NSObject, subclass SMXObject instead. That's all you
need to do in order to get all of the benefits.

As long as you make sure all of your properties are NSCoding compliant, you're
good to go.

SMXObject is a subclass of NSObject, so all of your existing code will still 
work as-is.

For a usage example, see the [example AppDelegate.m](https://github.com/o2labs/SMXObject/blob/master/SMXObject/AppDelegate.m)