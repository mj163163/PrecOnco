##loading libraries
library(data.table)
library(h2o)
h2o.init()

##loading training dataset
data = fread("Training_data_TCGA_dataset.csv")
data = as.data.frame(data)
data$label <- ifelse(data$label=="responder", 1, 0)
data$label = as.factor(data$label)


## Split data in the ratio 80:20
smp_size <- floor(0.8 * nrow(data))

## set the seed to make your partition reproducible
set.seed(123)
trainIndex <- sample(seq_len(nrow(data)), size = smp_size)



Train <- data[ trainIndex,]
Test  <- data[-trainIndex,]


train = as.h2o(Train)


# Response column
y <- "label"
x <- setdiff(names(train), y)





# Run AutoML for 20 base models
aml <- h2o.automl(x = x, y = y,
                  training_frame = train,
                  max_models = 20,
                  seed = 1,max_runtime_secs=0,keep_cross_validation_predictions = T,keep_cross_validation_fold_assignment = T,keep_cross_validation_models = T)


##predictions on test dataset
test = as.h2o(Test)
pred=h2o.predict(aml@leader,test)

