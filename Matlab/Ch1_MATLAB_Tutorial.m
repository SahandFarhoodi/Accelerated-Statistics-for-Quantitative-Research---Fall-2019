%%  MA665 - Lab 1:  MATLAB Tutorial.
%   This tutorial follows closely Chapter 2 of the textbook 'MATLAB for
%   Neuroscientists', and Handout #1 (on Blackboard).  If you already know
%   MATLAB, I suggest you quickly work through this tutorial, and confirm you're
%   up to speed.  If you've never used MATALB (or any other programming
%   language) then I encourage you to work through this tutorial, and all
%   of Chapter 2 in the textbook, carefully.  We will use MATLAB throughout
%   this course.  And, you'll probably find MATLAB useful in other courses
%   here at BU, as well as throughout your graduate career as a neuroscientist.
%

%%  Preliminaries.
%   Text preceded by a '%' indicates a 'comment'.  This text should appear
%   green on the screen.  I will use comments to explain what we're doing 
%   and to ask you questions.  Also, comments are useful in your own code
%   to note what you've done (so it makes sense when you return to the code
%   in the future).  It's a good habit to *always* comment your code.  I'll
%   try to set a good example, but won't always . . . 

%%  Example 1.  MATLAB is a calculator.
%   Enter the following command at the MATLAB prompt >>

4 + 3

%Q:  What do you get?  Does it make sense?

%%  Example 2.  MATLAB can compute complicated quantities.
%   Enter the following command at the MATLAB prompt >>

4/10^2

%Q:  Can you use parentheses to alter the result?

%%  Example 3.  MATLAB has useful built in functions.
%   A function is a program that operates on arguments.  Consider the 
%   following function >>

sin(2*pi)

%   Above, 'sin' is a function.  It operates on the argument '2*pi'.  Below
%   are three more examples of function that operate on arguments >>

cos(2*pi + 1/10)

exp(-2)

atan(2*pi)

%Q:  What is 'atan'?  To answer this, try using MATLAB Help.  To start the
%MATLAB Help, click on 'Help' at the top of your editor and select 'Product
%Help'.  This should open a new window.  In the Help Navigator type 'atan'
%and see what you find.

%NOTE:  The MATLAB Help is *extremely* useful.  Always look there when you
%have questions about a function.

%%  Example 4.  We can use MATLAB to define vectors.
%   A vector is a list of numbers.  Let's define one >>

[1 2 3 4]

%Q:  What happens when you type this in MATLAB?

%%  Example 5.  We can manipulate vectors by scalars.
%   A scalar is a single number.  Consider >>

[1 2 3 4] * 3

%Q:  What do you find?

%%  Example 6.  We can manupulate vectors with vectors >>

[1 2 3 4] .* [1 2 3 4]

%Q:  What does this return?

%NOTE:  Above we use the notation >> .* << to multiply.  This causes the
%vectors to be multiplied element-by-element.  To do so, the vectors must
%have the same number of elements.  Consider >>

[1 2 3 4] .* [1 2 3 4 5]

%Q:  What happens when you enter the above expression?

%NOTE:  The operator >> .* << differs from the operator >> * <<.  The
%latter operator performs "matrix multiplication", which is very different
%from the element-by-element multiplication we performed above.  If you've
%taken a class in linear algebra, then you've seen matrix multiplication.
%I don't think we will use matrix multiplication in this course (but it is
%an essential tool in more advanced data analysis).  The important point is
%the following:
%
%CAUTION:  >> .* << and >> * << are VERY DIFFERENT OPERATORS!!

%%  Example 7.  We can define variables in MATLAB.
%   In the previous examples, we typed [1 2 3 4] over and over again.  It's
%   easier to assign a variable to this vector, and then simply reference
%   this variable to access the vector.  Consider >>

a = 2
b = [1 2 3 4]

%  Here we have defined two variables.  The variable 'a' is a scalar and
%  assigned the number '2'.  The variable 'b' is a vector and assigned the
%  vector [1 2 3 4].  To work with these scalars and vectors, we can now
%  refer to the variables.  Consider >>

c = a*b
d = b.*b

%Q:  What are the new variables 'c' and 'd'?

%%  Example 8.  We can probe the variables we've defined in MATLAB.
%   A good place to start is the WORKSPACE WINDOW of MATLAB.  Look around
%   for this window on your desktop.  What variables do you see?  What
%   information do you learn about the variables by examining the
%   Workspace?

%  To see a list of the variables you've defined, type >>

who

%  To determine the size of a variable, type >>

size(c)

%%  Example 9.  Sometimes we need to clear all variables.
%   To clear all variables from the Workspace, type >>

clear

%Q:  Are all the variables gone?  How can you check?

%%  Example 10.  We can define matrices in MATLAB.
%   A matrix is a group of vectors.  Consider the following >>

p = [1 2 3; 4 5 6]

%   This creates a matrix with two rows and three columns.  We can
%   manipulate matrices like we manipulate vectors.  Consider >>

p + 2

%Q:  What happens?

%%  Example 11.  Indexing matrices and vectors.
%   Matrices and vectors are lists of numbers, and sometimes we want to
%   access individual elements or small subsets of these lists.  That's
%   easy to do in MATLAB.  Consider >>

a = [1 2 3 4 5]
b = [6 7 8 9 10]

%   To access the 2nd element of 'a' or 'b', type >>

a(2)
b(2)

%Q:  Do the results make sense?  How would you access the 4th element of
%each vector?

%   We can combine 'a' and 'b' to form a matrix.

c = [a; b]

%   To learn about 'c', type >>

size(c)

%   The size of 'c' is [2 5].  It has two rows and five columns.  To access
%   the individual element in the 1st row and 4th column of 'c', type >>

c(1,4)

%NOTE:  We access matrices using 'row,column' notation.  So c(1,4) means
%print the element in row 1, column 4 of c.


%   To access all columns in the entire first row of 'c', type >>
c(1,:)
%   The notation ':' means 'all indices'.


%   To access the 2nd thru 4th columns of row 1 of 'c', type >>
c(1,2:4)
%   The notation '2:4' means 'all intergers from 2 to 4' which in this case
%   is 2,3,4.


%Q:  How do you access all rows in the 2nd column of 'c'?

%%  Example 12:  We can find subsets of elements in matrices and vectors.
%   Sometimes we're interested in locating particular values within a
%   matrix or vector.  For example, let's first define a vector >>

a = (1:10)*2

%Q:  What is the size of 'a'?  What is the maximum value of 'a'?

%   Now let's find the indicies for all values in 'a' that exceed 10.
%   Doing this is simple in MATLAB >>

indices = find(a > 10)

%Q:  What is now stored in the variable "indices"?
%Q:  'find' is a function built into MATLAB.  What does find do?
%HINT:  (Look in MATLAB Help!)

%We can examine the values of 'a' at the 'indices' >>

a(indices)

%We can mainpute the values of 'a' at the 'indices' >>

a(indices) = 0

%Q:  Now what is the largest value stored in vector 'a'?

%%  Example 13:  Plotting data in MATLAB.
%   It's not easy to look at lists of numbers and gain any intuitive
%   feeling for their behavior, especially when the lists are long.  In
%   these cases, it's much better to visualize the lists of numbers by
%   plotting then.  Consider >>

x = (0:1:10)

%   The above line constructs a vector that starts at 0, ends at 10, and
%   takes steps of size 1 from 0 to 10.  Then define >>

y = sin(x)

%   Looking at the values in 'y' can you tell what's happending?
%   To visualize 'y' versus 'x', execute >>

plot(x,y)

%  This command will produce a plot of x versus y.  It should look a bit
%  jagged, and not smooth like a sinusoid.  To make the curve more smooth,
%  let's redefine 'x' as >>

x = (0:0.1:10);

%Q:  Compare this definition of 'x' to the definition above?  How do these
%two definitions differ?
%Q:  What is the size of 'x'?  Does this make sense?

%NOTE:  You might notice that I've include a semicolon ';' at the end of
%the definition of the vector 'x' above.  This semicolon tells MATLAB *not*
%to write out the results of this command in the command window.  We don't
%want to write out 'x' because it contains lots of elements, and it's not
%useful for us to look at them anyway.

%  Now recompute 'y' as >>

y = sin(x);

%  (NOTE the semicolon ending the line).  And plot it >>

plot(x,y)

%Q:  Eh?  How does the plot look?

%%  Example 14:  We can make multiple plots, one atop the other.
%   Let's define a second vector >>

z = cos(x);

%   And plot it >>

plot(x,z)

%   We'd now like to compare 'y' and 'z'.  To do this,
%   let's plot both vectors on the same figure.  First, open a new figure
%   >>

figure(1)

%   And plot x versus z >>

plot(x,z)

%   Now, tell MATLAB to 'hold on' to this figure >>

hold on

%   And plot also on this figure x versus y >>

plot(x,y, 'Color', 'r')

%NOTE:  We've included more arguments to the function 'plot'.  We've here
%told plot to draw the curve in a particular color --- red.  There are many
%options we can use to plot;  to see more, check out 'plot' in MATLAB Help.

%   When we're done 'holding' the figure, we turn hold off >>

hold off

%   We can also label the axis and give the figure a title >>

xlabel('X axis is Time')
ylabel('Y axis is Voltage')
title('My plot of y and z')

%%  Example 15:  We can make random numbers in MATLAB.
%   To generate a single random number in MATLAB, type >>

randn(1)

%Q:  Execute this command a few times.  What do you get?

%   To generate a list of random numbers, type >>

randn(10,1)

%   We sometimes will need to generate long lists of random numbers >>

r = randn(1000,1);

%Q:  How many elements are in the vector 'r'?

%   To see how these random numbers are distributed, we can compute a
%   histogram >>

hist(r)

%   See MATLAB Help to learn about the function 'hist'.  We'll talk more
%   about histograms this semester.

%%  Example 16:  Repeating commands over and over and over . . . 
%   Sometimes we'll want to repeat the same command over and over again.
%   What if we want to plot sin(x + k*pi/4) where k varies from 1 to 5 in
%   steps of 1;  how do we do it?  Consider the following >>

x = (0:0.1:10);  %Define a vector x that ranges from 0 to 10 with step 0.1.
k=1;
y = sin(x + k*pi/4);

figure(1)
plot(x,y)

k=2;
y = sin(x + k*pi/4);
hold on
plot(x,y)
hold off

k=3;
y = sin(x + k*pi/4);
hold on
plot(x,y)
hold off

k=4;
y = sin(x + k*pi/4);
hold on
plot(x,y)
hold off

k=5;
y = sin(x + k*pi/4);
hold on
plot(x,y)
hold off

%   That's horrible code!  All I did was cut and paste the same thing
%   four times.  As a general rule, if you're cutting and pasting in code,
%   you're doing something wrong.  There's a much more elegant way to do
%   this, and it involves making a 'for' loop.  Consider >>

x = (0:0.1:10);             %First, define the vector x.
figure(1)                   %Open the figure.
%hold on
for k=1:1:5                 %For each value of k from 1 to 5 in steps of 1.
    y = sin(x + k*pi/4);    %Define y (note the variable 'k' in sin).
    plot(x,y)               %Plot x versus y.
end
hold off

%   The small section of code above replaces all the cutting-and-pasting.
%   Instead of cutting and pasting, we update the definition of 'y' and
%   plot it within this for-loop.

%Q:  Spend some time studying this for-loop.  Does it make sense?

%%  Example 17:  Defining a new function an M-file.
%   We've spent some time in this lab writing and executing code.  Notice
%   that all of this code is saved as an M-file;  the file extension for
%   code written in MATLAB is '.m'.  Sometimes we'll need to write our own
%   MATLAB functions.  Let's do that now.
%
%   Our function will do something very simple:  it will take as input a
%   vector and return as output the vector elements squared plus an additive
%   constant.  Ideally,  we'll call this function in MATLAB as,

v = (0:1:10);
b = 2.5;
v2 = my_square_function(v, b);

%   This won't work!  We first need to define 'my_square_function'.  To do
%   so, we'll create a new M-file.  Click,
%
%           File ---> New ---> Blank M-file
%
%   as a first step.  You'll now have an empty file with no text.  In
%   lab, we'll work to define this function.

a = 3;
b = 5;
c = compute_power2(a, b);
c


%%  Example 18:  Loading data in MATLAB.
%   Sometimes we'll consider examples in this course that involve loading
%   data.  Fortunately, that's easy to do in MATLAB.  Consider the
%   following:
%
%   Vist the webpage,
%
%       http://makramer.info/sfn
%
%   and download the file "data.mat".  We'd now like to open this data set.  The
%   first step is to direct MATLAB to the same directory that contains the
%   downloaded file.  To do this, click on the '...' icon in the upper
%   right of the MATLAB Command Window.
%
%   Once you're in the correct directory, type >>

clear                  %First clear the workspace,
load data.mat          %Then load the data.

%   This command reads in the data stored in the file "data.mat".

%Q:  What variables now exist in your workspace?  What is the size of
%variable 't1' and 'v1'?  Plot v1 versus t1 to get a sense for how
%they behave.



