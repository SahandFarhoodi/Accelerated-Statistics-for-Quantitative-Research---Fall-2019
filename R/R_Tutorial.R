##  R Tutorial.
# 
##  Preliminaries.
#   Text preceded by a '#' indicates a 'comment'.  This text should appear
#   green on the screen.  I will use comments to explain what we're doing 
#   and to ask you questions.  Also, comments are useful in your own code
#   to note what you've done (so it makes sense when you return to the code
#   in the future).  It's a good habit to *always* comment your code.  I'll
#   try to set a good example, but won't always . . . 

##  Example 1.  R is a calculator.
#   Enter the following command at the R prompt >>

4 + 3

#Q:  What do you get?  Does it make sense?

##  Example 2.  R can compute complicated quantities.
#   Enter the following command at the R prompt >>

4/10^2

#Q:  Can you use parentheses to alter the result?

##  Example 3.  R has useful built in functions.
#   A function is a program that operates on arguments.  Consider the 
#   following function >>

sin(2*pi)

#   Above, 'sin' is a function.  It operates on the argument '2*pi'.  Below
#   are three more examples of function that operate on arguments >>

cos(2*pi + 1/10)

exp(-2)

atan(2*pi)

#Q:  What is 'atan'?  To answer this, try using R Help.  To start the
#R Help, click on 'Help' at the top of your editor and select 'Product
#Help'.  This should open a new window.  In the Help Navigator type 'atan'
#and see what you find.

#NOTE:  The R Help is *extremely* useful.  Always look there when you
#have questions about a function.

##  Example 4.  We can use R to define vectors.
#   A vector is a list of numbers.  Let's define one >>

c(1,2,3,4)

#Q:  What happens when you type this in R?

##  Example 5.  We can manipulate vectors by scalars.
#   A scalar is a single number.  Consider >>

c(1,2,3,4) * 3

#Q:  What do you find?

##  Example 6.  We can manupulate vectors with vectors >>

c(1,2,3,4) * c(1,2,3,4)

#Q:  What does this return?

#NOTE:  Above we use the notation >> * << to multiply.  This causes the
#vectors to be multiplied element-by-element.  To do so, the vectors must
#have the same number of elements.  Consider >>

c(1,2,3,4) * c(1,2,3,4,5)

#Q:  What happens when you enter the above expression?

#NOTE:  The operator >> * << differs from the operator >> %*% <<.  The
#latter operator performs "matrix multiplication", which is very different
#from the element-by-element multiplication we performed above.  If you've
#taken a class in linear algebra, then you've seen matrix multiplication.

##  Example 7.  We can define variables in R.
#   In the previous examples, we typed [1 2 3 4] over and over again.  It's
#   easier to assign a variable to this vector, and then simply reference
#   this variable to access the vector.  Consider >>

a <- 2
b <- c(1,2,3,4)

#  Here we have defined two variables.  The variable 'a' is a scalar and
#  assigned the number '2'.  The variable 'b' is a vector and assigned the
#  vector [1 2 3 4].  To work with these scalars and vectors, we can now
#  refer to the variables.  Consider >>

c <- a*b
d <- b*b

#Q:  What are the new variables 'c' and 'd'?

##  Example 8.  We can probe the variables we've defined in R.
#   A good place to start is the WORKSPACE WINDOW of R.  Look around
#   for this window on your desktop.  What variables do you see?  What
#   information do you learn about the variables by examining the
#   Workspace?

#  To see a list of the variables you've defined, type >>

ls()

#  To determine the length of a variable, type >>

length(c)

##  Example 9.  Sometimes we need to clear all variables.
#   To clear all variables from the Workspace, type >>

rm(list=ls())

#Q:  Are all the variables gone?  How can you check?

##  Example 10.  We can define matrices in R.
#   A matrix is a group of vectors.  Consider the following >>

p <- matrix(c(1,2,3,4,5,6),2,3,byrow=TRUE)

#   This creates a matrix with two rows and three columns.  We can
#   manipulate matrices like we manipulate vectors.  Consider >>

p + 2

#Q:  What happens?

##  Example 11.  Indexing matrices and vectors.
#   Matrices and vectors are lists of numbers, and sometimes we want to
#   access individual elements or small subsets of these lists.  That's
#   easy to do in R.  Consider >>

a <- c(1,2,3,4,5)
b <- c(6,7,8,9,10)

#   To access the 2nd element of 'a' or 'b', type >>

a[2]
b[2]

#Q:  Do the results make sense?  How would you access the 4th element of
#each vector?

#   We can combine 'a' and 'b' to form a matrix.

c <- matrix(c(a,b),2,5,byrow=TRUE)

#   To learn about the dimensions of 'c', type >>

dim(c)

#   The size of 'c' is [2 5].  It has two rows and five columns.  To access
#   the individual element in the 1st row and 4th column of 'c', type >>

c[1,4]

#NOTE:  We access matrices using 'row,column' notation.  So c[1,4] means
#print the element in row 1, column 4 of c.


#   To access all columns in the entire first row of 'c', type >>
c[1,]
#   The notation ':' means 'all indices'.


#   To access the 2nd thru 4th columns of row 1 of 'c', type >>
c[1,2:4]
#   The notation '2:4' means 'all intergers from 2 to 4' which in this case
#   is 2,3,4.


#Q:  How do you access all rows in the 2nd column of 'c'?

##  Example 12:  We can find subsets of elements in matrices and vectors.
#   Sometimes we're interested in locating particular values within a
#   matrix or vector.  For example, let's first define a vector >>

a <- (1:10)*2

#Q:  What is the size of 'a'?  What is the maximum value of 'a'?

#   Now let's find the indicies for all values in 'a' that exceed 10.
#   Doing this is simple in R >>

indices = which(a > 10)

#Q:  What is now stored in the variable "indices"?
#Q:  'which' is a function built into R.  What does �which� do?
#HINT:  (Look in R Help!)

#We can examine the values of 'a' at the 'indices' >>

a[indices]

#We can mainpute the values of 'a' at the 'indices' >>

a[indices] <- 0

#Q:  Now what is the largest value stored in vector 'a'?

##  Example 13:  Plotting data in R.
#   It's not easy to look at lists of numbers and gain any intuitive
#   feeling for their behavior, especially when the lists are long.  In
#   these cases, it's much better to visualize the lists of numbers by
#   plotting then.  Consider >>

x <- 0:10

#   The above line constructs a vector that starts at 0, ends at 10, and
#   takes steps of size 1 from 0 to 10.  Then define >>

y = sin(x)

#   Looking at the values in 'y' can you tell what's happending?
#   To visualize 'y' versus 'x', execute >>

plot(x,y)

#  This command will produce a plot of x versus y.  It should look a bit
#  jagged, and not smooth like a sinusoid.  To make the curve more smooth,
#  let's redefine 'x' as >>

x <- seq(1,10,.1);

# seq is an R command that generates a sequence from one value to another 
# with a specific step size 
#Q:  Compare this definition of 'x' to the definition above?  How do these
#two definitions differ?
#Q:  What is the size of 'x'?  Does this make sense?

#  Now recompute 'y' as >>

y <- sin(x);

#  And plot it >>

plot(x,y)

#Q:  Eh?  How does the plot look?

##  Example 14:  We can make multiple plots, one atop the other.
#   Let's define a second vector >>

z <- cos(x);

#   And plot it >>

plot(x,z)

#   We'd now like to compare 'y' and 'z'.  To do this,
#   let's plot both vectors on the same figure.  Plot x versus z >>

plot(x,z)

#   Now, tell R to plot on the same figure >>

par(new=TRUE)

#   And plot also on this figure x versus y >>

plot(x,y,col=�red�)

#NOTE:  We've included more arguments to the function 'plot'.  We've here
#told plot to draw the curve in a particular color --- red.  There are many
#options we can use to plot;  to see more, check out 'plot' in R Help.

#   We can also label the axis and give the figure a title >>

plot(x,y,col=�red�,xlab=�Time�,ylab=�Voltage�)
title(�Voltage vs. Time�)

##  Example 15:  We can make random numbers in R.
#   To generate a single random number in R, type >>

rnorm(1)

#Q:  Execute this command a few times.  What do you get?

#   To generate a list of random numbers, type >>

rnorm(10)

#   We sometimes will need to generate long lists of random numbers >>

r <- rnorm(1000)

#Q:  How many elements are in the vector 'r'?

#   To see how these random numbers are distributed, we can compute a
#   histogram >>

hist(r)

#   See R Help to learn about the function 'hist'. 

##  Example 16:  Repeating commands over and over and over . . . 
#   Sometimes we'll want to repeat the same command over and over again.
#   What if we want to plot sin(x + k*pi/4) where k varies from 1 to 5 in
#   steps of 1;  how do we do it?  Consider the following >>

x <- seq(0,10,0.1)  #Define a vector x that ranges from 0 to 10 with step 0.1.
k=1
y <- sin(x + k*pi/4)
plot(x,y)

k=2
y <- sin(x + k*pi/4)
par(new=TRUE)
plot(x,y)

k=3
y <- sin(x + k*pi/4)
par(new=TRUE)
plot(x,y)

k=4
y <- sin(x + k*pi/4)
par(new=TRUE)
plot(x,y)

k=5
y <- sin(x + k*pi/4)
par(new=TRUE)
plot(x,y)

#   That's horrible code!  All I did was cut and paste the same thing
#   four times.  As a general rule, if you're cutting and pasting in code,
#   you're doing something wrong.  There's a much more elegant way to do
#   this, and it involves making a 'for' loop.  Consider >>

x <- seq(0,10,0.1)  	     #First, define the vector x.
for (k in 1:5) {            #For each value of k from 1 to 5 in steps of 1.
  y <- sin(x + k*pi/4)    #Define y (note the variable 'k' in sin).
  plot(x,y)               #Plot x versus y.
  par(new=TRUE)           #Hold the figure.
}

#   The small section of code above replaces all the cutting-and-pasting.
#   Instead of cutting and pasting, we update the definition of 'y' and
#   plot it within this for-loop.

#Q:  Spend some time studying this for-loop.  Does it make sense?


##  Example 17:  Loading data in R.
#   Sometimes we'll consider examples in this course that involve loading
#   data.  Fortunately, that's easy to do in R. 
#   Download the file "cholesterol.dat".  We'd now like to open this data set.  
#   The first step is to direct R to the same directory that contains the
#   downloaded file.  To do this, click on the 'Misc' header in the R menu
#
#   Once you're in the correct directory, type >>

data <- read.table("cholesterol.dat",sep=",",header=TRUE)

#   This command reads in the data stored in the file "cholesterol.dat" into
#   a variable called �data�

#Q:  What variables now exist in your workspace?  What is the dimension of
#'data'? What variables are contained in �data�? Plot Before versus After 
#to get a sense for how they behave.