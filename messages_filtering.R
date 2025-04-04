getwd()
# load the dataset into the R environment
sms_raw <- read.csv("sms_spam.csv", stringsAsFactors = FALSE)
# check the structure of the dataset
str(sms_raw)
# convert the type variable into a factor
sms_raw$type <- factor(sms_raw$type)
sms_raw$type
str(sms_raw$type)
# check the proportion of spam to ham
prop.table(table(sms_raw$type))
# load the text minning package 

library(tm)
sms_corpus <- Corpus(VectorSource(sms_raw$text))
sms_corpus
inspect(sms_corpus[1:3])
# perform some data cleaning on the text variable in the dataset

sms_corpus_clean <- tm_map(sms_corpus, tolower)
sms_corpus_clean <- tm_map(sms_corpus_clean, removeNumbers)
sms_corpus_clean <- tm_map(sms_corpus_clean, removePunctuation)
sms_corpus_clean <- tm_map(sms_corpus_clean, removeWords, stopwords())
sms_corpus_clean <- tm_map(sms_corpus_clean, stripWhitespace)

# inspect the corpus before and after cleanng

inspect(sms_corpus[1:3])
inspect(sms_corpus_clean[1:3])

# creat a sparse matrix
sms_dtm <-DocumentTermMatrix(sms_corpus_clean)
View(sms_dtm)
# splitting the raw dataset into train and test data
sms_raw_train <- sms_raw[1:4169,]
sms_raw_test <- sms_raw[4170:5559,]

# splitting the documenttermmatrix into train and test data
sms_dtm_train <- sms_dtm[1:4169,]
sms_dtm_test <- sms_dtm[4170:5559,]

# splitting the corpus data
sms_corpus_train <- sms_corpus_clean[1:4169]
sms_corpus_test <- sms_corpus_clean[4170:5559]

prop.table(table(sms_raw_train$type))
prop.table(table(sms_raw_test$type))

library(wordcloud)
wordcloud(sms_corpus_train, min.freq = 40, random.order = F, )

spam <- subset(sms_corpus_train, type == "spam")
ham <- subset(sms_corpus_train, type == "ham")

wordcloud(spam$text, max.words = 40, scale = c(3, 0.5), random.order  = F)
wordcloud(ham$text, max.words = 40, scale = c(3, 0.5), random.order = F)

findFreqTerms(sms_dtm_train, 5)
install.packages("quanteda")
library("quanteda")
freq_terms <- findFreqTerms(sms_dtm_train, 5)
freq_terms
sms_dict <- dictionary(list(frequent_terms = freq_terms))
sms_dict <- quanteda::dictionary(list(frequent_terms = freq_terms))
exists("dictionary", where = asNamespace("quanteda"), inherits = FALSE)
sms_dict <- Dict::dict(frequent_terms = freq_terms)
sms_dict
sms_train <- DocumentTermMatrix(sms_corpus_train,list(dict = sms_dict))
sms_train
sms_test  <- DocumentTermMatrix(sms_corpus_test,
                                list(dict = sms_dict))
sms_test
convert_counts <- function(x) {
  x <- ifelse(x > 0, 1, 0)
  x <- factor(x, levels = c(0, 1), labels = c("No", "Yes"))
  return(x)
}
sms_train <- apply(sms_train, MARGIN = 2, convert_counts)
sms_test  <- apply(sms_test, MARGIN = 2, convert_counts)
install.packages("e1071")
library("e1071")
sms_classifier <- naiveBayes(sms_train, sms_raw_train$type)
sms_classifier
sms_test_pred <- predict(sms_classifier, sms_test)
library(gmodels)
CrossTable(sms_test_pred, sms_raw_test$type,
           prop.chisq = FALSE, prop.t = FALSE,
           dnn = c('predicted', 'actual'))

