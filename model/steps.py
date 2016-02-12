from drain import step, model, util
from epa.model.transform import EpaTransform
from itertools import product

metrics = [
    {'metric':'baseline'},
    {'metric':'count'},
    {'metric':'precision', 'dropna':True, 'k':100},
    {'metric':'precision', 'dropna':True, 'k':200},
    {'metric':'precision', 'dropna':True, 'k':500},
    {'metric':'precision', 'dropna':True, 'k':1000},
    {'metric':'auc'},
]

def violation():
    return models(transform_search= {'outcome':['violation_epa'],
            
            })

def evaluation():
    return models(transform_search={'outcome':['evaluation_epa'],
        'train_years': [3]
    })

def models(transform_search={}, estimator_search={}):
    steps = []
    transform_search = util.merge_dicts(dict(
        train_years = range(1,6),
        region = [None],
        year=range(2012,2015+1)
    ), transform_search)

    estimator_search = dict(
        n_estimators=[500],
    )

    for transform_args, estimator_args in product(
            util.dict_product(transform_search), 
            util.dict_product(estimator_search)):
        print transform_args, estimator_args

        transform = EpaTransform(month=1, day=1, 
                handlers = {'facility': ['all']},
                investigations = {'facility': ['1y', '5y']},#, 'state':['1y']},
                name='transform', **transform_args)

        estimator = step.Construct('sklearn.ensemble.RandomForestClassifier', 
                n_jobs=-1, name='estimator', **estimator_args)

        y = model.FitPredict(inputs=[estimator, transform], name='y', target=True)
        metrics1 = model.PrintMetrics(metrics, inputs=[y], target=True)

#        calibrator = step.Construct('sklearn.calibration.CalibratedClassifierCV', cv=4, inputs=[estimator], inputs_mapping=['base_estimator'], name='calibrator')

#        y_calibrated = model.FitPredict(inputs=[calibrator, transform], name='y_calibrated', target=True)
#        metrics2 = model.PrintMetrics(metrics, inputs=[y_calibrated], target=True)

        steps.append(metrics1)
#        steps.append(metrics2)

    return steps
