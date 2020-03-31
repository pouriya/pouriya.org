+++
title = "Erlang behaviors in Python"
date  = "2019-11-20"
twitter = ""
+++



Since python is an OOP ([**Object Oriented Programming**](https://en.wikipedia.org/wiki/Object-oriented_programming)) language; As a Python programmer you often work with classes, objecst, inheritance, etc and they make sense to you. But what happens when you start coding in a pure functional programming language like Erlang? One important problem is that you don't see `class` keyword or something like that to implement your own abstraction layers. So how do Erlangers separate generic parts of code from specefic parts? The answer is Erlang/OTP behaviors.  

<br/>  

# Digging into behaviors
According to [**Erlang/OTP documentation**](http://erlang.org/doc/design_principles/des_princ.html#behaviours):  
<italic>Behaviours are formalizations of common patterns. The idea is to divide the code for a process in a generic part (a behaviour module) and a specific part (a callback module).</italic>  
A typical example is well-known [**gen_server**](http://erlang.org/doc/man/gen_server.html).  
<br/>

## Python implementation
One simple generic Python request handler would be  

{{< highlight python >}}

class generic:

    def __init__(self, initialize_value):
        # initialize_value can be anything.
        # It depends on specific parts of code.
        try:
            # Result of do_init callback-function will be our state.
            # It can be anything and depends on specific parts of code.
            self.state = self.do_init(initialize_value)
        except Exception as error:
            self.terminate(error)

    def handle_request(self, request):
        try:
            result = self.do_handle_request(request, self.state)
        except Exception as error:
            self.terminate(error)
        # do_handle_request callback-function should yield response and new state. 
        (response, self.state) = result
        return response

    def handle_other(self, other):
        try:
            # To handle any request that does not need response
            self.state = self.do_handle_other(other, self.state)
        except Exception as error:
            self.terminate(error)

    def terminate(self, reason):
        # Let specific parts of code clean things.
        # For example close their files, etc.
        self.do_terminate(reason, self.state)
        if reason is None:
            return
        raise reason

{{</ highlight >}}

And for example I write a `counter` class on top of that.  

{{< highlight python >}}

class counter(generic):

    def do_init(self, value):
        print("started counter with value {}".format(value))
        # This will be our `self.state` in above example
        return value

    def do_handle_request(self, request, value):
        if request == "+":
            value += 1
        elif request == "-":
            value -= 1
        else:
            raise NotImplementedError("unknown request {}".format(request))
        return (value, value) # return (response, new_state)

    def do_handle_other(self, other, value):
        if other == 'print':
            print(value)
        else:
            raise NotImplementedError("unknown {}".format(other))
        return value # return new_state

    def do_terminate(self, reason, value):
        print("terminating with reason {}, count is {}".format(str(reason), value))

{{</ highlight >}}

We're done! I saved above classes in a file named `request_handler.py`. Let's test it in Python interpreter.  

{{< highlight text >}}
>>> from request_handler import counter

>>> c = counter(10)
started counter with value 10

>>> c.handle_request("+")
11

>>> c.handle_request("+")
12

>>> c.handle_request("-")
11

>>> result = c.handle_request("-") # It has a return value
>>> result
10

>>> result = c.handle_other("print") # No return value
10
>>> result

>>> c.handle_other("print")
10

>>> c.handle_request("Oops")
terminating with reason unknown request Oops, count is 10
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "/projects/codefather.org/generic.py", line 18, in handle_request
    self.terminate(error)
  File "/projects/codefather.org/generic.py", line 36, in terminate
    raise reason
  File "/projects/codefather.org/generic.py", line 16, in handle_request
    result = self.do_handle_request(request, self.state)
  File "/projects/codefather.org/generic.py", line 52, in do_handle_request
    raise NotImplementedError("unknown request {}".format(request))
NotImplementedError: unknown request Oops
{{</ highlight >}}  

Now let's separate them in two files and try to implement them more like how Erlang/OTP implements them. For generic parts of code we have  

{{< highlight python >}}
# generic.py

class generic:

    def __init__(self, module, initialize_value):
        self.module = module
        try:
            self.state = module.init(initialize_value)
        except Exception as error:
            self.terminate(error)

    def handle_request(self, request):
        try:
            result = self.module.handle_request(request, self.state)
        except Exception as error:
            self.terminate(error)
        (response, self.state) = result
        return response

    def handle_other(self, other):
        try:
            self.state = self.module.handle_other(other, self.state)
        except Exception as error:
            self.terminate(error)

    def terminate(self, reason):
        self.module.terminate(reason, self.state)
        if reason is None:
            return
        raise reason
{{</ highlight >}}

And for specific parts of code we have  

{{< highlight python >}}
# counter.py

def init(value):
    print("started counter with value {}".format(value))
    return value

def handle_request(request, value):
    if request == "+":
        value += 1
    elif request == "-":
        value -= 1
    else:
        raise NotImplementedError("unknown request {}".format(request))
    return (value, value)

def handle_other(other, value):
    if other == 'print':
        print(value)
    else:
        raise NotImplementedError("unknown {}".format(other))
    return value

def terminate(reason, value):
    print("terminating with reason {}, count is {}".format(str(reason), value))
{{</ highlight >}}

Let's test them together.  

{{< highlight text >}}
>>> from generic import generic
>>> import counter

>>> c = generic(counter, 10)
started counter with value 10

>>> c.handle_request("+")
11

>>> c.handle_request("+")
12
...
{{</ highlight >}}

That's how Erlangers manage [**Cohesion**](https://en.wikipedia.org/wiki/Cohesion_(computer_science)) and [**Coupling**](https://en.wikipedia.org/wiki/Coupling_(computer_programming)) in their code.  
We don't see message passing and multi-threading in above examples; But in Erlang every request is an Erlang message that one process (called `client process`) sends to other process (called `server process`) and every response is a message that `servers process` sends to `client process`.  
Erlang/OTP behaviors handle many things that we did not handle in above. For example:  
_ How much time you want to wait for a `server process` to initilize its state?  
_ Specific part of code has the ability to being started or raising error or ignore starting.  
_ Specific parts of code have the ability to tell generic parts of code wait for incomming messages for a fixed time.  
_ Advanced tracing for incomming/outgoing messages and changing state.  
_ Code hot-reloading while internal state has changed in new code.  
And many more.  
  
Since Erlang/OTP behaviors ([**gen_server**](http://erlang.org/doc/man/gen_server.html), [**gen_event**](http://erlang.org/doc/man/gen_event.html), etc) are maintained for years they are stable and efficient enough to rely on; Always try to use them and if and only if you need to implement your own behavior, I highly recommend to read their code and understand them correctly.  
 
