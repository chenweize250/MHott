# Feedback 1.21

## 1.21
Problem 3

There's a lot going on in the plots. I appreciate the extra touches. Though, I think that the extra touches have backfired in the python script. I'm getting a very confusing plots with many lines in there. Take another look at that.

Problem 4

Both scripts look good, very efficient use of MATLAB in the script.
## 1.28
I looked again at problem 3 python script and I'm still getting some odd output :(, Let's look at this tomorrow.

Problem 5 

Looks great, the graphs appear correct. One little nitpick is the labels on the axes - it's probably good to keep them as short as possible.

## 2.4
Problem 6 is another good looking program. A few suggestions in make it even better. Look into using `nargin` to set some default arguments for the later inputs. Also take a look at the function `varargin` this may make variable input length easier to handle. Also, you may want to increase how finely you are dividing your time up when animating the line, 0.01 s is quite small, and for large range projectiles, the graph does take quite a while to complete.
## 2.13
I happy with the matlab version of this projectile motion function. It produces the right results and outputs imperial unit speed in feet, and it is reflected in the graph, so that's a nice touch. It looks like some work should be done on the python front.
## 2.21
I think that problem 6 is pretty much done, I'd like you to define some MException objects in your program, not just message `errors`. And (nitpicky), but I think that you could those 2 try/except statements in your python program to work as one (this just makes the program simplier in the end).
## 3.14
Okay, bad advice on the try catch. What's up next? Your ptable looks like a good set-up, but it doesn't run quite yet - you need to include some if/else or switch statements that assign variables to `varargin` according to the value of `nargin`
## 3.29
Problem 7 is done beautifully, it looks like you understood that. One comment, though, about that last integral, sometimes you're going to hit a singularity in the expression and you're going to have to approach the singularity and maybe take a limit to get an answer to the problem. It will just require some elbow grease if computational methods aren't working - but your insight on what the romberg integrator was doing was good. 
Problem 8 is not running for me, you missed a vital piece of coding in lines 8, 15, 18
Problem 9 is almost complete, you just need to solve the drifting problem in the last random number draw from the exponential. What is the range of numbers you are drawing from this distribution? And there is a way that you could cut down you code by 2/3 of the lines, if you're interested in knowing, flag me down next class period. It involves using anonymous functions.
And you nailed the project 1, I have only one thing that I want you to check on - the binding energy seems off by just a slight bit, recheck that calculation if you have the time.
