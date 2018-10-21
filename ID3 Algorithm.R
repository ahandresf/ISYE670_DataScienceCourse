# ID3 Algorithm
# Christine Nguyen
# The following functions are from
# https://cran.r-project.org/web/packages/data.tree/vignettes/applications.html#id3-machine-learning
# 
# ** This uses the data.tree package. Install the package before using this.
# 


#### Main Functions
library(data.tree)

IsPure <- function(data) {
  length(unique(data[,ncol(data)])) == 1
}

Entropy <- function( vls ) {
  res <- vls/sum(vls) * log2(vls/sum(vls))
  res[vls == 0] <- 0
  -sum(res)
}

InformationGain <- function( tble ) {
  entropyBefore <- Entropy(colSums(tble))
  s <- rowSums(tble)
  entropyAfter <- sum (s / sum(s) * apply(tble, MARGIN = 1, FUN = Entropy ))
  informationGain <- entropyBefore - entropyAfter
  return (informationGain)
}

# The following function is called TrainID3
TrainID3 <- function(node, data) {
  
  node$obsCount <- nrow(data)
  
  #if the data-set is pure (e.g. all toxic), then
  if (IsPure(data)) {
    #construct a leaf having the name of the pure feature (e.g. 'toxic')
    child <- node$AddChild(unique(data[,ncol(data)]))
    node$feature <- tail(names(data), 1)
    child$obsCount <- nrow(data)
    child$feature <- ''
  } else {
    #calculate the information gain
    ig <- sapply(colnames(data)[-ncol(data)], 
                 function(x) InformationGain(
                   table(data[,x], data[,ncol(data)])
                 )
    )
    #chose the feature with the highest information gain (e.g. 'color')
    #if more than one feature have the same information gain, then take
    #the first one
    feature <- names(which.max(ig))
    node$feature <- feature
    
    #take the subset of the data-set having that feature value
    
    childObs <- split(data[ ,names(data) != feature, drop = FALSE], 
                      data[ ,feature], 
                      drop = TRUE)
    
    for(i in 1:length(childObs)) {
      #construct a child having the name of that feature value (e.g. 'red')
      child <- node$AddChild(names(childObs)[i])
      
      #call the algorithm recursively on the child and the subset      
      TrainID3(child, childObs[[i]])
    }
    
  }
  
}

Predict <- function(tree, features) {
  
  if(length(tree$children[[1]])== 0)
    return (print("ERROR: The decision tree is unable to make a prediction."))
  if (tree$children[[1]]$isLeaf) 
    return (tree$children[[1]]$name)
  child <- tree$children[[features[[tree$feature]]]]
  return ( Predict(child, features))
}

### Plotting 
## For advanced use with plot
## (Modified February 2017 by Christine Nguyen)

GetNodeLabel <- function(node) { 
  if(node$isLeaf == FALSE)
  { 
    label = paste0(node$feature,  '\n # Obs = ', ' ', format(node$obsCount, scientific = FALSE, big.mark = ",")) 
  }
  else
  {
    label = paste0(node$name,  '\n # Obs = ', ' ', format(node$obsCount, scientific = FALSE, big.mark = ","))
  }
    return (label)
  }

GetEdgeLabel <- function(node) {
  label = paste0(node$name)
  return (label)
}

