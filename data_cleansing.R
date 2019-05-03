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


missing<- calcule_missing_values(loan)
head(missing)
library(ggplot2)
rownames(missing)
barplot(missing$percentage, names.arg=rownames(missing), horiz=F, las=3, cex.names=0.5, col = grey.colors(nrow(missing)), border=NA)


