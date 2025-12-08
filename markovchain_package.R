person1 <- c("happy", "calm", "neutral", "sad", "angry", "stressed", "happy")
person2 <- c("happy", "neutral", "calm", "sad", "angry", "happy", "stressed")
person3 <- c("calm", "happy", "neutral", "sad", "angry", "stressed", "happy")
person4 <- c("happy", "calm", "sad", "neutral", "angry", "stressed", "happy")
person5 <- c("happy", "calm", "sad", "angry", "neutral", "happy", "stressed")
person6 <- c("happy", "calm", "neutral", "sad")




library(markovchain)

L <- list(person1, person2, person3, person4, person5)
m <- do.call("rbind", lapply(L, function(x) cbind(head(x, -1), tail(x, -1))))
mc <- markovchainFit(m)
est <- mc$estimate

est # show transition matrix
# ...snip...

# estimate next step after "shirt"
person6 <- c("underwear", "socks", "pants", "shirt")
prior_state <- tail(person6, 1)
predict(est, prior_state)
## [1] tie 

plot(est)
