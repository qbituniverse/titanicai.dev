Process.Training <- function(trainset, testset, settings) {
    # create model
    titanic.data.model <- ModelTraining.Create(df = trainset, settings = settings)

    # create predictions
    predict <- ModelTraining.Predict.Single(model = titanic.data.model$model,
                                            df = testset,
                                            settings = settings)

    titanic.data.model$prediction <- predict$prediction
    titanic.data.model$probability <- predict$probability

    # calculate model stats
    titanic.data.model$stats <- ModelPerformance.CalculateStats.Model(model = titanic.data.model,
                                                                      df = testset,
                                                                      settings = settings)

    # print out model stats
    ModelPerformance.PrintStats.Model(titanic.data.model)

    # returns
    return(list(type = settings$model$type, model = titanic.data.model))
}