a <- vector(mode="character",length = 10) #define a vector, create space
b <- c(1,2,3) #concatenate elements
c <- seq(1,6,1) #create a sequence with a step (initial, final, step)
a[1]='hola'
d <- c("uno",1,TRUE)
e <- c(5,TRUE)

###Matrix
M=matrix(c, nrow=3, byrow=TRUE)
M2=matrix(c, nrow=4, byrow=TRUE) #The last rwo will start to be fill with the vector

d1=c("A","B","C")
d2=c("x","y","w")
d3=c("p1","p2","p3","p4")
##Array (vector_with_elements, matrix_shape,dimention_label)
z <- array(1:36, c(3,3,4),dimnames=list(d1,d2,d3))
z[1,2,3] #element(1,2) of matrix 3
z["A","y","p3"] #same of previous line but using labels. 

#Acording to the video one of the two below may not work but both work for me.
y <- array(1:37, c(3,3,4),dimnames=list(d1,d2,d3)) #This one works
w <- array(1:35, c(3,3,4),dimnames=list(d1,d2,d3)) #This one does not work


##Frames
#the row = observations
#the columns = variables (all elements in one column same data type), 
#like attributes I guess columns are vectors and for a frame all of 
#them may have the same dimension. 

#Create a data frame
ID <- c(50,51,52)
Age <- c(15,25,30)
Gender <- c("female","male","female")
Update <- c(TRUE,FALSE,TRUE)
patient <- data.frame(ID,Gender,Age,Update)
patient$ID
patient[2,3]
patient$ID[3]

#List: Ordered collection of objects with whatever data structure
t <- "Strint title example"
my_list <- list(t,M2,patient)
my_list[[3]]$ID
mode(my_list)
length(my_list)
summary(my_list)
str(my_list)

#factor variables, for example cars can be only blue, red, white.
#nominal variables, are the ones that express category but order does not matter.
#ordinal variables are categorical variables and order DOES matter
factor() #values and levels=categories 
v=c(100,101)
M2mrbind(M2,v) #it does not change M2
M2


