#data prepration
train <- read.csv("C:\\Users\\hup128\\Desktop\\data_run_01\\train.csv", header = TRUE,  sep = ",")
amazon_test <- read.csv("C:\\Users\\hup128\\Desktop\\data_run_01\\test.csv", header = TRUE,  sep = ",")
amazon_sub <- read.csv("C:\\Users\\hup128\\Desktop\\data_run_01\\sampleSubmission.csv", header = TRUE,  sep = ",")

#predictor varialbe design

#model generation
install.packages("Matrix")
library(Matrix)
X <- sparse.model.matrix(as.formula(paste("ACTION ~", paste(colnames(train[,-1]), sep = "", collapse=" +"))), data = train)
X_test <- sparse.model.matrix(as.formula(paste""))
install.packages("glmnet")
library(glmnet)
model_cv <- cv.glmnet(X, train[,1], family = "binomial")
model <-glmnet(X, train[,1], family = "binomial") 
predict(model, newx =amazon_test[1:10, ])

#normalizing the data
X = X - X.min(0)

action_model <- lm(amazon_tr$ACTION ~ amazon_tr$RESOURCE + amazon_tr$MGR_ID +0)
summary(action_model)
action_fit <- predict(model, newdata= amazon_test)
output <-vector()
for (i in 1:32769){
  if (action_fit[i] >0.5){
    output[i]<-1;
  }
  else{ output[i] <- 0;
      }
}

for (j in 1:32769){
  amazon_sub[j,2] <- output[j]
}
#model evaluation (using the verification package):
install.packages("verification")
library(verification)
auc = roc.area(true_labels, predictions)
