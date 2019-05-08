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


missi<- calcule_missing_values(new)

head(missi)

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
new <- drop_useless(new,c("desc","mths_since_last_delinq","pub_rec_bankruptcies"))
a <- drop_useless(a,c("loan_bin"))

head(calcule_missing_values(new))

drop_rows <- function (df,threshold){
  a <- df[rowSums(is.na(df)) < threshold, ]
  return (a)
}
a <- drop_rows(new,2)
head(calcule_missing_values(a))

# convert int_rate to num 
b<- lapply(a$int_rate, function(x) as.numeric(sub("%", "", x))) 
v <- unlist(b)
a$int_rate <-v
str(a)

print(calcule_missing_values(a))
library(ggplot2)  

box_plot <- function (df, var1 , var2){
  p=ggplot(df, aes(x =df$var1, y = df$var2,fill =df$var1))  + geom_boxplot() + theme_bw()
  print(p)
  }
names(a)
a$loan_bin=lapply(a$loan_status, function(x) as.numeric(sub("%", "", x)))
box_plot(df=a,var1=loan_status,var2=loan_amnt)

ggplot(a, aes(x =loan_amnt , fill =loan_status))  + geom_boxplot() +facet_grid(loan_status ~ ., scales = 'free') +  theme_bw()
head(a)
write.csv(a,"C:\\Users\\hmzoughi\\Desktop\\Loan_Analysis\\Loan_Analysis\\clean_loan.csv")
str(a)