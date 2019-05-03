calcule_missing_values <- function(df) {
  na_count <- sapply(df, function(y)
    sum(length(which(is.na(
      y
    )))))
  na_count <- data.frame(na_count)
  na_count$percentage <- (na_count$na_count / nrow(df)) * 100
  na_count <- na_count[order(-na_count$percentage), ]
  return(na_count)
}


missing<- calcule_missing_values(new)



drop_columns <- function (mis,df,threshold){
  m <- mis[mis$percentage < threshold, ]
  a <- rownames(m)
  return(df[,c(a)])
}
new <- drop_columns(mis = missing, df= loan , threshold = 90)
new_missi <- calcule_missing_values(new)
drop_useless <- function (df,delete){
  newData <- df[,!(names(df) %in% delete)] 
  return (newData)
}

head(calcule_missing_values(drop_useless(new,c("desc","mths_since_last_delinq"))))
new <- drop_useless(new,c("desc","mths_since_last_delinq"))
head(calcule_missing_values(new))

