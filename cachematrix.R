## Defines two functions, one to make a special "cached matrix" and one to 
## calculate its inverse. If the inverse has been calculated once, it is stored
## in the matrix. Subsequent calls to calculate the inverse will just return
## the precomputed inverse.



## makeCacheMatrix generates a matrix capable of caching its inverse. 
## A list of 4 functions are returned:

## set: sets the values in the matrix. 
## get: returns the matrix defined by the "set" function
## setInverse: sets the cached inverse of the matrix
## getInverse: gets the cached inverse of the matrix

## Note: setInverse and getInverse are not to be called by the user.
##       use cacheSolve instead (see below).
## No error checking of any kind is performed. Input is assumed to be correct.

makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    # Updates the matrix 'x' in the parent enviroment. 
    # If the matrix is updated the inverse is reset to NULL
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    # Returns the matrix set by the 'set' function above
    get <- function() x 
    # Update the inverse in the parent environment
    setInverse <- function(inverse) inv <<- inverse 
    # Returns the inverse (NULL if not calculated yet)
    getInverse <- function() inv
    # Return a list of the 4 functions defined above.
    list(set = set, get = get,
         setInverse = setInverse,
         getInverse = getInverse)
}



## cacheSolve calculates the inverse of a cached matrix generated by 
## makeCacheMatrix, and stores the result in the cached matrix. 
## If the inverse has already been calculated once, the cached result 
## is returned.
cacheSolve <- function(x, ...) {
    inv <- x$getInverse() # Get the inverse
    # inv is different from NULL if the inverse has previously been calculated.
    if(!is.null(inv)) { # Is inv different from NULL?
        message("getting cached data")
        return(inv) # If so, return the value in the cache
    }
    # If the function progresses to this point inv was NULL. 
    # Get the data in 'x', calculate the inverse (with 'solve'), and update the
    # cache in 'x'. Finally return the calculated inverse.
    data <- x$get()
    inv <- solve(data, ...)
    x$setInverse(inv)
    inv
}


## Example
# cMatrix <- makeCacheMatrix()
# cMatrix$set(matrix(c(2,2,3,2), nrow = 2))
# cMatrix$get()
# cacheSolve(cMatrix)
# cacheSolve(cMatrix)